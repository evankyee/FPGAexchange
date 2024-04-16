#reg29 inputs data from wrapper I/O write
#reg28 stores next open bit address in DMEM for buys
#reg27 stores next open bit address in DMEM for sells
#reg26 SELLAhead
#reg25 BUYAhead
#reg24 output for execution BUY
#reg23 SELL

#r29[31] tells us 1=buy, 0=sell; 1
#r29[30:28] tells us security 3
#r29[27:24] tells us user 4
#r29[23:12] tells us price 12
#r29[11:0] tells us volume 12

#PUT SECURITY POINTERS IN MEMORY

#everytime we hit 0 on vol for our HEADS, move to next as HEAD!!

#we have pointers to our lists in dmem

##
#TAIL_A_BUY
#TAIL_A_SELL
#HEAD_A_BUY
#HEAD_A_SELL

#TAIL_B_BUY
#TAIL_B_SELL
#HEAD_B_BUY
#HEAD_B_SELL

#TAIL_C_BUY
#TAIL_C_SELL
#HEAD_C_BUY
#HEAD_C_SELL

#TAIL_D_BUY
#TAIL_D_SELL
#HEAD_D_BUY
#HEAD_D_SELL

#TAIL_E_BUY
#TAIL_E_SELL
#HEAD_E_BUY
#HEAD_E_SELL

#TAIL_F_BUY
#TAIL_F_SELL
#HEAD_F_BUY
#HEAD_F_SELL

#TAIL_G_BUY
#TAIL_G_SELL
#HEAD_G_BUY
#HEAD_G_SELL

#TAIL_H_BUY
#TAIL_H_SELL
#HEAD_H_BUY
#HEAD_H_SELL

main:
    addi $r28, $r0, 24 #first spot for A buy
    addi $r27, $r28, 124 #first spot for A sell (100 orders)
    loop1:
        bne $r20, $r0, newdata #check if new data in 29
        nop
        nop
        nop
        j loop1

newdata: #we have (32bits:DATA 32bits:PointertoNext)
    #first check if can execute trade
    addi $r29, $r20, 0 #putting IO reg into 29
    and $r20, $r20, $r0 #clearing IO reg

    sra $r3, $r29, 31 #need to integrate rll isn
    bne $r3, $r0, newBUY

    #looking at the security
    sll $r16, $r29, 1
    sra $r16, $r16, 29 #r16 holds our security!!
    #WE CAN USE THIS SECURITY TO ACCESS POINTERS!!
    
    #TO DO: ADD POINTERS IN DMEM THAT POINT TO LISTS OF BUY AND SELL! WOULD HAVE TO UPDATE OUR OPEN REG28 AND OPEN R27 each time we get new data

    newSELL: #want to check if overlap from new trade!
    lw $r4, 0($r25) #highest buy Trade Order is in r4
    #examining prices
    sll $r5, $r4, 8
    sll $r6, $r29, 8
    sra $r5, $r5, 20 #isolating price of HB
    sra $r6, $r6, 20 #isolating price of new sell
    blt $r6, $r5, newSellEX
    bne $r6, $r5, plswork
    j newSellEX
    plswork:
    j sortSell #no execution so now add to mem and sort stack
    newSellEX:
    #new sell order executed trade!
    #we have to first execute with our head, then if head hits zero (sell order vol > head buy vol) then move to next struct and do same
        #have to handle alerts, updating dmem, moving head, then if sell remaining write to mem

    #first get volumes 
    sll $r6, $r29, 20 #now r6 has volume (shifted) of new order
    sra $r6, $r6, 20
    sll $r7, $r4, 20 #now r7 has volume (shifted) of HB
    sra $r7, $r7, 20
    blt $r7, $r6, OverflowSell
    #sells don't exceed
    sub $r7, $r7, $r6 #finding leftover shares on trade!
    sra $r4, $r4, 12 #clearing r4 trade order vol
    sll $r4, $r4, 12
    add $r4, $r4, $r7
    sw $r4, 0($r25) ##doing math to write remainder back into bitline
    
    add $r24, $r4, $r0 #SENDING REMAINING VOL TO OUTPUT

    bne $r7, $r0 nosalematch
    lw $r25, 1($r25) #head=head.next!! (gets rid of top order perfect match)
    
    nosalematch:
    sra $r29, $r29, 12 #clearing r4 trade order vol
    sll $r29, $r29, 12
    add $r23, $r29, $r0
    j doneWithData #depleted sale!

    #here we have finished our sale volume and now can ignore new order (depleted) and order book stays same on buy side
    


    OverflowSell: #should be loop until sale is exhausted
    sub $r6, $r6, $r7 #leftover sale volume
    sra $r4, $r4, 12 #setting vol of HB to zero
    sll $r4, $r4, 12
    add $r24, $r4, $r0 #SENDING EMPTY VOL TO OUTPUT
    lw $r25, 1($r25) #head=head.next address
    sra $r29, $r29, 12 #setting vol of new sale to zero
    sll $r29, $r29, 12
    add $r29, $r29, $r6 #UPDATED VOL IN NEW SALE ORDER (IN REG29, and new head address in r25)
    j newSELL #START SALE CHECK OVER AGAIN


    doneWithData:
    and $r29, $r29, $r0 #clearing I/O reg!! also clearing all other regs used
    and $r4, $r4, $r0
    and $r5, $r5, $r0
    and $r6, $r6, $r0
    and $r7, $r7, $r0
    and $r3, $r3, $r0
    j loop1


    newBUY:
    lw $r4, 0($r26) #top sale in r4
    sll $r5, $r4, 8
    sll $r6, $r29, 8
    sra $r5, $r5, 20 #isolating price of HS
    sra $r6, $r6, 20 #isolating price of new buy
    bne $r5, $r0, continuebuy
    j noBuyEX
    continuebuy:
    blt $r5, $r6, newBuyEX
    bne $r6, $r5, noBuyEX
    j newBuyEX
    noBuyEX: #if we reach here, no trade executed from new buy
    j sortBuy #no execution so now add to mem and sort stack
    
    newBuyEX:
    #first get volumes 
    sll $r6, $r29, 20 #now r6 has volume (shifted) of new order
    sra $r6, $r6, 20
    sll $r7, $r4, 20 #now r7 has volume (shifted) of HS
    sra $r7, $r7, 20
    blt $r7, $r6, OverflowBuy

    #buys don't exceed
    sub $r7, $r7, $r6 #finding leftover shares on trade!
    sra $r4, $r4, 12 #clearing r4 trade order vol
    sll $r4, $r4, 12
    add $r4, $r4, $r7
    sw $r4, 0($r26) ##doing math to write remainder back into bitline

    add $r23, $r4, $r0 #SENDING REMAINING VOL TO OUTPUT

    bne $r7, $r0, nobuymatch
    lw $r26, 1($r26) #head=head.next!! (gets rid of top order perfect match)
    
    nobuymatch:
    sra $r29, $r29, 12 #clearing r4 trade order vol
    sll $r29, $r29, 12
    add $r24, $r29, $r0
    j doneWithData #depleted sale!
    
    OverflowBuy: #should be loop until buy is exhausted
    sub $r6, $r6, $r7 #leftover buy volume
    sra $r4, $r4, 12 #setting vol of HS to zero
    sll $r4, $r4, 12
    add $r23, $r4, $r0 #SENDING EMPTY VOL TO OUTPUT
    lw $r26, 1($r26) #head=head.next address
    sra $r29, $r29, 12 #setting vol of new sale to zero
    sll $r29, $r29, 12
    add $r29, $r29, $r6 #UPDATED VOL IN NEW SALE ORDER (IN REG29, and new head address in r25)
    j newBUY #START SALE CHECK OVER AGAIN



sortSell: #new order in reg29 (maybe after already executing trades from overflow!)
##4 conditions, empty list, fits front, middle, end

    lw $r8, 0($r26) #highest curr sell in r8
    sll $r9, $r8, 20
    sra $r9, $r9, 20 #now we have remaining vol from curr highest sell in r9

    #SAVING OUR NEW DATA TO MEM
    sw $r29, 0($r27) #write new thing to dmem
    addi $r10, $r27, 2    #store next pointer
    sw $r10, 1($r27) #store right next to our new  (NEW DATA POINTER NOW IN r27!!)

    bne $r9, $r0, sellListNotEmpty
    #sell list empty so we need to set new order as top!
    add $r26, $r27, $r0 #make new head register 
    lw $r27 1($r27) #restoring open data line in r27
    j donesortSell

    sellListNotEmpty:
    #here we have to sort new sell item
    #so we need to get prices from first item in linked list
    #highest curr sell still in r8
    #LOWEST PRICE PRIORITY!
    sll $r11, $r8, 8
    sra $r11, $r11, 20 #PRICE OF CURRENT LOWEST ASK IN r11
    #Price of new sell request is in r6! (Should be but could be point of fault)
   
    add $r13, $r26, $r0 #putting current head as prev for sorting if we do
    
    blt $r6, $r11, NewDatLTLowAsk #if true, then we want new dat in front of current!!!!!!
    #else we want to move to next!
   
    sortsellloop:
    lw $r12, 1($r13) #what is currently prev.next (our temp)
    #prev=r13
    #temp=r12
    #curr=r27
    bne $r12, $r27, NOTLASTSELL #if these are equal, then we are at end of list so we dont need to do anything!
    lw $r11, 0($r12) #prev.next order is in 
    
    #if we are here, then prev.next data is empty
    lw $r27, 1($r27)
    j donesortSell

    NOTLASTSELL:
    sll $r11, $r11, 8
    sra $r11, $r11, 20
    blt $r6, $r11, insertCurr #check if curr.price < prev.next.price

    add $r13, $r12, $r0 #prev = prev.next
    j sortsellloop


    insertCurr: #if true, lets do some pointer math
    lw $r15, 1($r27) 
    sw $r12, 1($r27)
    sw $r27, 1($r13)
    add $r27, $r15, $r0 #restoring our next open data line
    j donesortSell


    
    NewDatLTLowAsk:
    #add $r12, $r26, $r0 #temp assignment of current head
    lw $r15, 1($r27)
    add $r26, $r27, $r0 #make new head register 
    sw $r13, 1($r26) #making our head.next = temp
    add $r27, $r15, $r0 #restoring our next open data line
    j donesortSell
    
    


    donesortSell:
    #8,9,10,11,12,13,15
    and $r8, $r8, $r0
    and $r9, $r9, $r0
    and $r10, $r10, $r0
    and $r11, $r11, $r0
    and $r12, $r12, $r0
    and $r13, $r13, $r0
    and $r15, $r15, $r0
    and $r29, $r29, $r0
    j loop1


#check if list empty by checking vol of head (even if nothing there will just naturally be zero)



sortBuy: #new order in reg29 (maybe after already executing trades from overflow!)
##4 conditions, empty list, fits front, middle, end

    lw $r8, 0($r25) #highest curr buy in r8
    sll $r9, $r8, 20
    sra $r9, $r9, 20 #now we have remaining vol from curr highest sell in r9

    #SAVING OUR NEW DATA TO MEM
    sw $r29, 0($r28) #write new thing to dmem
    addi $r10, $r28, 2 #store next pointer
    sw $r10, 1($r28) #store right next to our new  (NEW DATA POINTER NOW IN r28!!)

    bne $r9, $r0, buyListNotEmpty
    #sell list empty so we need to set new order as top!
    add $r25, $r28, $r0 #make new head register 
    lw $r28 1($r28) #restoring open data line in r28
    j donesortBuy

    buyListNotEmpty:
    #here we have to sort new sell item
    #so we need to get prices from first item in linked list
    #highest curr sell still in r8
    #LOWEST PRICE PRIORITY!
    sll $r11, $r8, 8
    sra $r11, $r11, 20 #PRICE OF HIGHEST BID IN r11
    #Price of new buy request is in r6! (Should be but could be point of fault)
   
    add $r13, $r25, $r0 #putting current head as prev for sorting if we do
    ##NOW WE HAVE TO CHECK IF EXCLUSIVELY GREATER WITH EQUAL AND LT
    
    blt $r11, $r6 NewDatGTLowAsk #if true, then we want new dat in front of current!!!!!!
    #else we want to move to next!
   
    sortbuyloop:
    lw $r12, 1($r13) #what is currently prev.next (our temp)
    #prev=r13
    #temp=r12
    #curr=r28
    bne $r12, $r28, NOTLASTBUY #if these are equal, then we are at end of list so we dont need to do anything!
    lw $r11, 0($r12) #prev.next order is in 
   
    #if we are here, then prev.next data is empty
    lw $r28, 1($r28)
    j donesortBuy

    NOTLASTBUY:
    sll $r11, $r11, 8
    sra $r11, $r11, 20
    blt $r11, $r6 insertCurr #check if curr.price > prev.next.price

    add $r13, $r12, $r0 #prev = prev.next
    j sortbuyloop


    insertCurr: #if true, lets do some pointer math
    lw $r15, 1($r28) 
    sw $r12, 1($r28)
    sw $r28, 1($r13)
    add $r28, $r15, $r0 #restoring our next open data line
    j donesortBuy
    
    NewDatGTLowAsk:
    #add $r12, $r26, $r0 #temp assignment of current head
    lw $r15, 1($r28)
    add $r25, $r28, $r0 #make new head register 
    sw $r13, 1($r25) #making our head.next = temp
    add $r28, $r15, $r0 #restoring our next open data line
    j donesortBuy
    
    donesortBuy:
    #8,9,10,11,12,13,15
    and $r8, $r8, $r0
    and $r9, $r9, $r0
    and $r10, $r10, $r0
    and $r11, $r11, $r0
    and $r12, $r12, $r0
    and $r13, $r13, $r0
    and $r15, $r15, $r0
    and $r29, $r29, $r0
    j loop1



#code for adding to dmem line new data
#sw $r29, 0($r28) #saving our data in memory
   # and $r28, $r28, $r0
   # addi $r2, $r28, 64 #getting address of "next" data struct
   # sw $r2, 1($r28) #saving address of next data struct in memory
   # add $r27, $r28, $r0 #pointer to new data!
   # add $r28, $r2, $r0 #updating our next free space in memory line
   # #pointer to new data in r27
   # j newsort