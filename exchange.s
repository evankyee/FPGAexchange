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
#MEM ORGANIZATION
#0 1 BUY HEAD
#1 2 BUY HEAD
#2 3 BUY HEAD
#3 4 BUY HEAD
#4 5 BUY HEAD
#5 6 BUY HEAD
#6 7 BUY HEAD
#7 8 BUY HEAD

#8 1 SELL HEAD
#9 2 SELL HEAD
#10 3 SELL HEAD
#11 4 SELL HEAD
#12 5 SELL HEAD
#13 6 SELL HEAD
#14 7 SELL HEAD
#15 8 SELL HEAD

#16 1 BUY TAIL
#17 2 BUY TAIL
#18 3 BUY TAIL
#19 4 BUY TAIL
#20 5 BUY TAIL
#21 6 BUY TAIL
#22 7 BUY TAIL
#23 8 BUY TAIL

#24 1 SELL TAIL
#25 2 SELL TAIL
#26 3 SELL TAIL
#27 4 SELL TAIL
#28 5 SELL TAIL
#29 6 SELL TAIL
#30 7 SELL TAIL
#31 8 SELL TAIL

#32 1 Head Buy Val
#33 2 Head Buy Val
#34 3 Head Buy Val
#35 4 Head Buy Val
#36 5 Head Buy Val
#37 6 Head Buy Val
#38 7 Head Buy Val
#39 8 Head Buy Val

#40 1 Head Sell Val
#41 2 Head Sell Val
#42 3 Head Sell Val
#43 4 Head Sell Val
#44 5 Head Sell Val
#45 6 Head Sell Val
#46 7 Head Sell Val
#47 8 Head Sell Val

# BUY A MEM ALLOC
# SELL A MEM ALLOC
# BUY B MEM ALLOC
# SELL B MEM ALLOC
# ...continues


main:
    addi $r28, $r0, 48 #first spot for A buy
    nop
    nop
    nop
    addi $r27, $r0, 148 #first spot for A sell (100 orders)
    nop
    nop
    nop
    addi $r16, $r0, 0
    nop
    nop
    nop
    sw $r27, 24($r16) #SELL TAIL
    nop
    nop
    nop
    sw $r28, 16($r16) #BUY TAIL
    nop
    nop
    nop
    sw $r27, 8($r16) #SELL head
    nop
    nop
    nop
    sw $r28, 0($r16) #BUY head

    addi $r28, $r0, 248 #first spot for b buy
    nop
    nop
    nop
    addi $r27, $r0, 348 #first spot for b sell (100 orders)
    nop
    nop
    nop
    addi $r16, $r0, 1
    nop
    nop
    nop
    sw $r27, 24($r16) #SELL TAIL
    nop
    nop
    nop
    sw $r28, 16($r16) #BUY TAIL
    nop
    nop
    nop
    sw $r27, 8($r16) #SELL head
    nop
    nop
    nop
    sw $r28, 0($r16) #BUY head

    addi $r28, $r0, 448 #first spot for c buy
    nop
    nop
    nop
    addi $r27, $r0, 548 #first spot for c sell (100 orders)
    nop
    nop
    nop
    addi $r16, $r0, 2
    nop
    nop
    nop
    sw $r27, 24($r16) #SELL TAIL
    nop
    nop
    nop
    sw $r28, 16($r16) #BUY TAIL
    nop
    nop
    nop
    sw $r27, 8($r16) #SELL head
    nop
    nop
    nop
    sw $r28, 0($r16) #BUY head

    addi $r28, $r0, 648 #first spot for d buy
    nop
    nop
    nop
    addi $r27, $r0, 748 #first spot for d sell (100 orders)
    nop
    nop
    nop
    addi $r16, $r0, 3
    nop
    nop
    nop
    sw $r27, 24($r16) #SELL TAIL
    nop
    nop
    nop
    sw $r28, 16($r16) #BUY TAIL
    nop
    nop
    nop
    sw $r27, 8($r16) #SELL head
    nop
    nop
    nop
    sw $r28, 0($r16) #BUY head

    addi $r28, $r0, 848 #first spot for e buy
    nop
    nop
    nop
    addi $r27, $r0, 948 #first spot for e sell (100 orders)
    nop
    nop
    nop
    addi $r16, $r0, 4
    nop
    nop
    nop
    sw $r27, 24($r16) #SELL TAIL
    nop
    nop
    nop
    sw $r28, 16($r16) #BUY TAIL
    nop
    nop
    nop
    sw $r27, 8($r16) #SELL head
    nop
    nop
    nop
    sw $r28, 0($r16) #BUY head

    addi $r28, $r0, 1048 #first spot for f buy
    nop
    nop
    nop
    addi $r27, $r0, 1148 #first spot for f sell (100 orders)
    nop
    nop
    nop
    addi $r16, $r0, 5
    nop
    nop
    nop
    sw $r27, 24($r16) #SELL TAIL
    nop
    nop
    nop
    sw $r28, 16($r16) #BUY TAIL
    nop
    nop
    nop
    sw $r27, 8($r16) #SELL head
    nop
    nop
    nop
    sw $r28, 0($r16) #BUY head

    addi $r28, $r0, 1248 #first spot for g buy
    nop
    nop
    nop
    addi $r27, $r0, 1348 #first spot for g sell (100 orders)
    nop
    nop
    nop
    addi $r16, $r0, 6
    nop
    nop
    nop
    sw $r27, 24($r16) #SELL TAIL
    nop
    nop
    nop
    sw $r28, 16($r16) #BUY TAIL
    nop
    nop
    nop
    sw $r27, 8($r16) #SELL head
    nop
    nop
    nop
    sw $r28, 0($r16) #BUY head

    addi $r28, $r0, 1448 #first spot for h buy
    nop
    nop
    nop
    addi $r27, $r0, 1548 #first spot for h sell (100 orders)
    nop
    nop
    nop
    addi $r16, $r0, 7
    nop
    nop
    nop
    sw $r27, 24($r16) #SELL TAIL
    nop
    nop
    nop
    sw $r28, 16($r16) #BUY TAIL
    nop
    nop
    nop
    sw $r27, 8($r16) #SELL head
    nop
    nop
    nop
    sw $r28, 0($r16) #BUY head
    loop1:
        bne $r20, $r0, newdata #check if new data in 29
        nop
        nop
        nop
        j loop1

newdata: #we have (32bits:DATA 32bits:PointertoNext)
    #first check if can execute trade

    ##8 securities

    addi $r29, $r20, 0 #putting IO reg into 29
    and $r20, $r20, $r0 #clearing IO reg
    
    #looking at the security
    sll $r16, $r29, 1
    sra $r16, $r16, 29 #r16 holds our security!!

    lw $r25, 0($r16) #BUY HEAD
    lw $r26, 8($r16) #SELL HEAD
    lw $r28, 16($r16) #BUY TAIL
    lw $r27, 24($r16) #SELL TAIL


    sra $r3, $r29, 31 #need to integrate rll isn
    bne $r3, $r0, newBUY

   
    
    #WE CAN USE THIS SECURITY TO ACCESS POINTERS!!
    
    #TO DO: ADD POINTERS IN DMEM THAT POINT TO LISTS OF BUY AND SELL! WOULD HAVE TO UPDATE OUR OPEN REG28 AND OPEN R27 each time we get new data

    newSELL: #want to check if overlap from new trade!
    lw $r4, 0($r25) #highest buy Trade Order is in r4
    #examining prices
    nop
    nop
    nop
    sra $r22, $r4, 24 #top 8 bits in r22
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

    #IO FOR USER INFO EXECUTION
    and $r21, $r21, $r0
    nop
    nop
    nop
    add $r21, $r0, $r22
    and $r22, $r22, $r0
    add $r22, $r29, $r0
    sra $r22, $r22, 24
    sll $r22, $r22, 24
    add $r21, $r21, $r22
    add $r19, $r21, $r0

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
    and $r21, $r21, $r0
    nop
    nop
    nop
    add $r21, $r0, $r22
    and $r22, $r22, $r0
    add $r22, $r29, $r0
    sra $r22, $r22, 24
    sll $r22, $r22, 24
    add $r21, $r21, $r22
    add $r19, $r21, $r0
    lw $r25, 1($r25) #head=head.next address
    sra $r29, $r29, 12 #setting vol of new sale to zero
    sll $r29, $r29, 12
    add $r29, $r29, $r6 #UPDATED VOL IN NEW SALE ORDER (IN REG29, and new head address in r25)
    j newSELL #START SALE CHECK OVER AGAIN


    doneWithData:
    sw $r25, 0($r16) #BUY HEAD
    sw $r26, 8($r16) #SELL HEAD
    sw $r28, 16($r16) #BUY TAIL
    sw $r27, 24($r16) #SELL TAIL
    #SAVING THE VALUES OF HEAD TO MEM
    lw $r4, 0($r25)
    nop
    nop
    nop
    lw $r5, 0($r26)
    nop
    nop
    nop
    #BCD PRICE
    and $r8, $r8, $r0
    nop
    nop
    nop
    sll $r8, $r4, 8
    nop
    nop
    nop
    sra $r8, $r8, 20 #R8 HAS PRICE OF BUY
    nop
    nop
    nop
    and $r9, $r9, $r0
    nop
    nop
    nop
    and $r10, $r10, $r0
    nop
    nop
    nop
    addi $r10, $r0, 100
    nop
    nop
    nop
    div $r9, $r8, $r10 #getting hundreds digit and putting into r9
    nop
    nop
    nop
    and $r11, $r11, $r0
    nop
    nop
    nop
    add $r11, $r9, $r0
    nop
    nop
    nop
    mul $r11, $r11, $r10
    nop
    nop
    nop
    sub $r8, $r8, $r11 #subtracting hundreds place so we have 10 and one left
    nop
    nop
    nop
    and $r12, $r12, $r0
    nop
    nop
    nop
    add $r12, $r12, $r9 #r12 has hundred bits
    
    nop
    nop
    nop
    addi $r10, $r0, 10
    nop
    nop
    nop
    div $r9, $r8, $r10
    nop
    nop
    nop
    and $r11, $r11, $r0
    nop
    nop
    nop
    add $r11, $r9, $r0
    nop
    nop
    nop
    mul $r11, $r11, $r10
    nop
    nop
    nop
    sub $r8, $r8, $r11 #subtracting tens place so we have one left
    nop
    nop
    nop
    sll $r9, $r9, 4
    nop
    nop
    nop
    add $r12, $r12, $r9 #r12 has hundred bits
    nop
    nop
    nop
    sll $r8, $r8, 8
    nop
    nop
    nop
    add $r12, $r12, $r8 

    #BCD VOL FIXED
    and $r8, $r8, $r0
    sll $r8, $r4, 20
    nop
    nop
    nop
    sra $r8, $r8, 20 #R8 HAS vol OF BUY
    nop
    nop
    nop
    and $r9, $r9, $r0
    nop
    nop
    nop
    and $r10, $r10, $r0
    nop
    nop
    nop
    addi $r10, $r0, 100
    nop
    nop
    nop
    div $r9, $r8, $r10 #getting hundreds digit and putting into r9
    and $r11, $r11, $r0
    nop
    nop
    nop
    add $r11, $r9, $r0
    nop
    nop
    nop
    mul $r11, $r11, $r10
    nop
    nop
    nop
    sub $r8, $r8, $r11 #subtracting hundreds place so we have 10 and one left

    sll $r9, $r9, 12
    nop
    nop
    nop
    add $r12, $r12, $r9 #r12 has hundred bits
    nop
    nop
    nop
    addi $r10, $r0, 10
    nop
    nop
    nop
    div $r9, $r8, $r10
    nop
    nop
    nop
    and $r11, $r11, $r0
    nop
    nop
    nop
    add $r11, $r9, $r0
    nop
    nop
    nop
    mul $r11, $r11, $r10
    nop
    nop
    nop
    sub $r8, $r8, $r11 #subtracting tens place so we have one left
    sll $r9, $r9, 16
    nop
    nop
    nop
    add $r12, $r12, $r9 #r12 has hundred bits
    nop
    nop
    nop
    sll $r8, $r8, 20
    nop
    nop
    nop
    add $r12, $r12, $r8 
    nop
    nop
    nop
    sw $r12, 32($r16) #saving buy stuff
    nop
    nop
    nop

    #BCD PRICE
    and $r8, $r8, $r0
    sll $r8, $r5, 8
    nop
    nop
    nop
    sra $r8, $r8, 20 #R8 HAS PRICE OF BUY
    nop
    nop
    nop
    and $r9, $r9, $r0
    and $r10, $r10, $r0
    nop
    nop
    nop
    addi $r10, $r0, 100
    nop
    nop
    nop
    div $r9, $r8, $r10 #getting hundreds digit and putting into r9
    nop
    nop
    nop
    and $r11, $r11, $r0
    nop
    nop
    nop
    add $r11, $r9, $r0
    nop
    nop
    nop
    mul $r11, $r11, $r10
    nop
    nop
    nop
    sub $r8, $r8, $r11 #subtracting hundreds place so we have 10 and one left
    nop
    nop
    nop
    and $r12, $r12, $r0
    nop
    nop
    nop
    add $r12, $r12, $r9 #r12 has hundred bits
    nop
    nop
    nop
    addi $r10, $r0, 10
    nop
    nop
    nop
    div $r9, $r8, $r10
    nop
    nop
    nop
    and $r11, $r11, $r0
    nop
    nop
    nop
    add $r11, $r9, $r0
    nop
    nop
    nop
    mul $r11, $r11, $r10
    nop
    nop
    nop
    sub $r8, $r8, $r11 #subtracting tens place so we have one left
    sll $r9, $r9, 4
    nop
    nop
    nop
    add $r12, $r12, $r9 #r12 has hundred bits
    nop
    nop
    nop
    sll $r8, $r8, 8
    add $r12, $r12, $r8 

    #BCD VOL FIXED
    and $r8, $r8, $r0
    sll $r8, $r5, 20
    nop
    nop
    nop
    sra $r8, $r8, 20 #R8 HAS vol OF BUY
    nop
    nop
    nop
    and $r9, $r9, $r0
    and $r10, $r10, $r0
    addi $r10, $r0, 100

    nop
    nop
    nop
    div $r9, $r8, $r10 #getting hundreds digit and putting into r9
    nop
    nop
    nop
    and $r11, $r11, $r0
    nop
    nop
    nop
    add $r11, $r9, $r0
    nop
    nop
    nop
    mul $r11, $r11, $r10
    nop
    nop
    nop
    sub $r8, $r8, $r11 #subtracting hundreds place so we have 10 and one left
    nop
    nop
    nop
    sll $r9, $r9, 12
    nop
    nop
    nop
    add $r12, $r12, $r9 #r12 has hundred bits
    nop
    nop
    nop
    addi $r10, $r0, 10
    nop
    nop
    nop
    div $r9, $r8, $r10
    nop
    nop
    nop
    and $r11, $r11, $r0
    add $r11, $r9, $r0
    nop
    nop
    nop
    mul $r11, $r11, $r10
    nop
    nop
    nop
    sub $r8, $r8, $r11 #subtracting tens place so we have one left
    nop
    nop
    nop
    sll $r9, $r9, 16
    nop
    nop
    nop
    add $r12, $r12, $r9 #r12 has hundred bits
    nop
    nop
    nop
    sll $r8, $r8, 20
    nop
    nop
    nop
    add $r12, $r12, $r8 
    nop
    nop
    nop

    sw $r12, 40($r16)
    and $r25, $r25, $r0
    and $r26, $r26, $r0
    and $r27, $r27, $r0
    and $r28, $r28, $r0
 
    and $r29, $r29, $r0 #clearing I/O reg!! also clearing all other regs used
    and $r4, $r4, $r0
    and $r5, $r5, $r0
    and $r6, $r6, $r0
    and $r7, $r7, $r0
    and $r3, $r3, $r0
    j loop1


    newBUY:
    lw $r4, 0($r26) #top sale in r4
    nop
    nop
    nop
    sra $r22, $r4, 24 #top 8 bits in r22
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

    #IO FOR USER INFO EXECUTION
    and $r21, $r21, $r0
    nop
    nop
    nop
    add $r21, $r0, $r22
    and $r22, $r22, $r0
    add $r22, $r29, $r0
    sra $r22, $r22, 24
    sll $r22, $r22, 24
    add $r21, $r21, $r22
    add $r19, $r21, $r0

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
    and $r21, $r21, $r0
    nop
    nop
    nop
    add $r21, $r0, $r22
    and $r22, $r22, $r0
    add $r22, $r29, $r0
    sra $r22, $r22, 24
    sll $r22, $r22, 24
    add $r21, $r21, $r22
    add $r19, $r21, $r0
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
    nop
    nop
    nop
    lw $r12, 1($r13) #what is currently prev.next (our temp)
    #prev=r13
    #temp=r12
    #curr=r27
    nop
    nop
    nop
    bne $r12, $r27, NOTLASTSELL #if these are equal, then we are at end of list so we dont need to do anything!
    nop
    nop
    nop
    #if we are here, then prev.next data is empty
    lw $r27, 1($r27)
    nop
    nop
    nop
    j donesortSell

    NOTLASTSELL: #MAYBE FUCXKED UP
    nop
    nop
    nop
    lw $r11, 0($r12) #prev.next order is in 
    nop
    nop
    nop
    sll $r11, $r11, 8
    nop
    nop
    nop
    sra $r11, $r11, 20
    nop
    nop
    nop
    blt $r6, $r11, insertCurrSell #check if curr.price < prev.next.price

    add $r13, $r12, $r0 #prev = prev.next
    j sortsellloop


    insertCurrSell: #if true, lets do some pointer math
    nop
    nop
    nop
    lw $r15, 1($r27) 
    nop
    nop
    nop
    sw $r12, 1($r27)
    nop
    nop
    nop
    add $r18, $r26, $r0
    nop
    nop
    nop
    sellinsertend:
    #we need to iterate from head until we get to node that points to r27
    lw $r17, 1($r18)
    nop
    nop
    nop
    bne $r17, $r27, insertseclastsell
    sw $r15, 1($r18)
    nop
    nop
    nop
    sw $r27, 1($r13)
    nop
    nop
    nop
    add $r27, $r15, $r0 #restoring our next open data line
    nop
    nop
    nop
    j donesortSell

    insertseclastsell:
    add $r18, $r17, $r0
    j sellinsertend


    


    
    NewDatLTLowAsk:
    #add $r12, $r26, $r0 #temp assignment of current head
    lw $r15, 1($r27)
    add $r18, $r26, $r0
    nop
    nop
    nop
    sellnewheadloop:
    #we need to iterate from head until we get to node that points to r27
    lw $r17, 1($r18)
    nop
    nop
    nop
    bne $r17, $r27, secondtolastnodesell

    sw $r15, 1($r18)
    nop
    nop
    nop
    add $r26, $r27, $r0 #make new head register 
    nop
    nop
    nop
    sw $r13, 1($r26) #making our head.next = temp
    add $r27, $r15, $r0 #restoring our next open data line
    j donesortSell

    secondtolastnodesell:
    add $r18, $r17, $r0
    j sellnewheadloop

    
    
    
    


    donesortSell:
    #8,9,10,11,12,13,15
    sw $r25, 0($r16) #BUY HEAD
    sw $r26, 8($r16) #SELL HEAD
    sw $r28, 16($r16) #BUY TAIL
    sw $r27, 24($r16) #SELL TAIL
    #SAVING HEADS VALS TO MEM ADDR
    lw $r4, 0($r25)
    nop
    nop
    nop
    lw $r5, 0($r26)
    nop
    nop
    nop
    #BCD PRICE
    and $r8, $r8, $r0
    sll $r8, $r4, 8
    sra $r8, $r8, 20 #R8 HAS PRICE OF BUY

    and $r9, $r9, $r0
    and $r10, $r10, $r0
    nop
    nop
    nop
    addi $r10, $r0, 100
    nop
    nop
    nop
    div $r9, $r8, $r10 #getting hundreds digit and putting into r9
    nop
    nop
    nop
    and $r11, $r11, $r0
    nop
    nop
    nop
    add $r11, $r9, $r0
    nop
    nop
    nop
    mul $r11, $r11, $r10
    nop
    nop
    nop
    sub $r8, $r8, $r11 #subtracting hundreds place so we have 10 and one left
    nop
    nop
    nop
    and $r12, $r12, $r0
    nop
    nop
    nop
    add $r12, $r12, $r9 #r12 has hundred bits
    
    addi $r10, $r0, 10
    nop
    nop
    nop
    div $r9, $r8, $r10
    nop
    nop
    nop
    and $r11, $r11, $r0
    nop
    nop
    nop
    add $r11, $r9, $r0
    nop
    nop
    nop
    mul $r11, $r11, $r10
    nop
    nop
    nop
    sub $r8, $r8, $r11 #subtracting tens place so we have one left
    sll $r9, $r9, 4
    nop
    nop
    nop
    add $r12, $r12, $r9 #r12 has hundred bits
    nop
    nop
    nop
    sll $r8, $r8, 8
    nop
    nop
    nop
    add $r12, $r12, $r8 
    nop
    nop
    nop
    #BCD VOL FIXED
    and $r8, $r8, $r0
    sll $r8, $r4, 20
    sra $r8, $r8, 20 #R8 HAS vol OF BUY
    nop
    nop
    nop
    and $r9, $r9, $r0
    and $r10, $r10, $r0
    nop
    nop
    nop
    addi $r10, $r0, 100
    nop
    nop
    nop
    div $r9, $r8, $r10 #getting hundreds digit and putting into r9
    nop
    nop
    nop
    and $r11, $r11, $r0
    nop
    nop
    nop
    add $r11, $r9, $r0
    nop
    nop
    nop
    mul $r11, $r11, $r10
    nop
    nop
    nop
    sub $r8, $r8, $r11 #subtracting hundreds place so we have 10 and one left
    nop
    nop
    nop
    sll $r9, $r9, 12
    nop
    nop
    nop
    add $r12, $r12, $r9 #r12 has hundred bits
    nop
    nop
    nop
    addi $r10, $r0, 10
    nop
    nop
    nop
    div $r9, $r8, $r10
    nop
    nop
    nop
    and $r11, $r11, $r0
    nop
    nop
    nop
    add $r11, $r9, $r0
    nop
    nop
    nop
    mul $r11, $r11, $r10
    nop
    nop
    nop
    sub $r8, $r8, $r11 #subtracting tens place so we have one left
    nop
    nop
    nop
    sll $r9, $r9, 16
    nop
    nop
    nop
    add $r12, $r12, $r9 #r12 has hundred bits
    nop
    nop
    nop
    sll $r8, $r8, 20
    nop
    nop
    nop
    add $r12, $r12, $r8 
    nop
    nop
    nop
    sw $r12, 32($r16) #saving buy stuff
    nop
    nop
    nop

    #BCD PRICE
    and $r8, $r8, $r0
    sll $r8, $r5, 8
    sra $r8, $r8, 20 #R8 HAS PRICE OF BUY
    nop
    nop
    nop
    and $r9, $r9, $r0
    nop
    nop
    nop
    and $r10, $r10, $r0
    nop
    nop
    nop
    addi $r10, $r0, 100
    nop
    nop
    nop
    div $r9, $r8, $r10 #getting hundreds digit and putting into r9
    nop
    nop
    nop
    and $r11, $r11, $r0
    nop
    nop
    nop
    add $r11, $r9, $r0
    nop
    nop
    nop
    mul $r11, $r11, $r10
    nop
    nop
    nop
    sub $r8, $r8, $r11 #subtracting hundreds place so we have 10 and one left

    and $r12, $r12, $r0
    add $r12, $r12, $r9 #r12 has hundred bits
    nop
    nop
    nop
    addi $r10, $r0, 10
    nop
    nop
    nop
    div $r9, $r8, $r10
    nop
    nop
    nop
    and $r11, $r11, $r0
    nop
    nop
    nop
    add $r11, $r9, $r0
    nop
    nop
    nop
    mul $r11, $r11, $r10
    nop
    nop
    nop
    sub $r8, $r8, $r11 #subtracting tens place so we have one left
    nop
    nop
    nop
    sll $r9, $r9, 4
    nop
    nop
    nop
    add $r12, $r12, $r9 #r12 has hundred bits
    nop
    nop
    nop
    sll $r8, $r8, 8
    nop
    nop
    nop
    add $r12, $r12, $r8 
    nop
    nop
    nop
    #BCD VOL FIXED
    and $r8, $r8, $r0
    nop
    nop
    nop
    sll $r8, $r5, 20
    nop
    nop
    nop
    sra $r8, $r8, 20 #R8 HAS vol OF BUY
    nop
    nop
    nop
    and $r9, $r9, $r0
    nop
    nop
    nop
    and $r10, $r10, $r0
    nop
    nop
    nop
    addi $r10, $r0, 100
    nop
    nop
    nop
    div $r9, $r8, $r10 #getting hundreds digit and putting into r9
    nop
    nop
    nop
    and $r11, $r11, $r0
    nop
    nop
    nop
    add $r11, $r9, $r0
    nop
    nop
    nop
    mul $r11, $r11, $r10
    nop
    nop
    nop
    sub $r8, $r8, $r11 #subtracting hundreds place so we have 10 and one left
    nop
    nop
    nop
    sll $r9, $r9, 12
    nop
    nop
    nop
    add $r12, $r12, $r9 #r12 has hundred bits
    nop
    nop
    nop
    addi $r10, $r0, 10
    nop
    nop
    nop
    div $r9, $r8, $r10
    nop
    nop
    nop
    and $r11, $r11, $r0
    nop
    nop
    nop
    add $r11, $r9, $r0
    nop
    nop
    nop
    mul $r11, $r11, $r10
    nop
    nop
    nop
    sub $r8, $r8, $r11 #subtracting tens place so we have one left
    nop
    nop
    nop
    sll $r9, $r9, 16
    nop
    nop
    nop
    add $r12, $r12, $r9 #r12 has hundred bits
    nop
    nop
    nop
    sll $r8, $r8, 20
    nop
    nop
    nop
    add $r12, $r12, $r8 
    nop
    nop
    nop

    sw $r12, 40($r16)
    and $r25, $r25, $r0
    and $r26, $r26, $r0
    and $r27, $r27, $r0
    and $r28, $r28, $r0

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
    nop
    nop
    nop
    lw $r12, 1($r13) #what is currently prev.next (our temp)
    #prev=r13
    #temp=r12
    #curr=r28
    nop
    nop
    nop
    bne $r12, $r28, NOTLASTBUY #if these are equal, then we are at end of list so we dont need to do anything!
    nop
    nop
    nop
    #if we are here, then prev.next data is empty
    lw $r28, 1($r28)
    nop
    nop
    nop
    j donesortBuy

    NOTLASTBUY:
    nop
    nop
    nop
    lw $r11, 0($r12) #prev.next order is in 
    nop
    nop
    nop
    sll $r11, $r11, 8
    nop
    nop
    nop
    sra $r11, $r11, 20
    nop
    nop
    nop
    blt $r11, $r6 insertCurrbuy #check if curr.price > prev.next.price
    nop
    nop
    nop
    add $r13, $r12, $r0 #prev = prev.next
    j sortbuyloop


    insertCurrbuy: #if true, lets do some pointer math
    nop
    nop
    nop
    lw $r15, 1($r28) 
    nop
    nop
    nop
    sw $r12, 1($r28)
    nop
    nop
    nop
    add $r18, $r25, $r0
    nop
    nop
    nop
    buyinsertsecloop:
    #we need to iterate from head until we get to node that points to r27
    lw $r17, 1($r18)
    nop
    nop
    nop
    bne $r17, $r28, plsbuycmon
    sw $r15, 1($r18)
    nop
    nop
    nop
    sw $r28, 1($r13)
    nop
    nop
    nop
    add $r28, $r15, $r0 #restoring our next open data line
    j donesortBuy

    plsbuycmon:
    add $r18, $r17, $r0
    j buyinsertsecloop


    
    
    NewDatGTLowAsk:
    #add $r12, $r26, $r0 #temp assignment of current head
    lw $r15, 1($r28)
    add $r18, $r25, $r0
    nop
    nop
    nop
    buynewheadloop:
    #we need to iterate from head until we get to node that points to r27
    lw $r17, 1($r18)
    nop
    nop
    nop
    bne $r17, $r28, secondtolastnodebuy

    sw $r15, 1($r18)
    nop
    nop
    nop
    add $r25, $r28, $r0 #make new head register 
    nop
    nop
    nop
    sw $r13, 1($r25) #making our head.next = temp
    add $r28, $r15, $r0 #restoring our next open data line
    j donesortBuy


    secondtolastnodebuy:
    add $r18, $r17, $r0
    j buynewheadloop

    
   
    
    donesortBuy:
    #8,9,10,11,12,13,15
    sw $r25, 0($r16) #BUY HEAD
    sw $r26, 8($r16) #SELL HEAD
    sw $r28, 16($r16) #BUY TAIL
    sw $r27, 24($r16) #SELL TAIL

    #SAVING HEADS VALS TO MEM ADDR
    lw $r4, 0($r25) #headval 
    nop
    nop
    nop
    lw $r5, 0($r26) #sell val
    nop
    nop
    nop

    #BCD PRICE
    and $r8, $r8, $r0
    nop
    nop
    nop
    sll $r8, $r4, 8
    nop
    nop
    nop
    sra $r8, $r8, 20 #R8 HAS PRICE OF BUY
    nop
    nop
    nop
    and $r9, $r9, $r0
    nop
    nop
    nop
    and $r10, $r10, $r0
    nop
    nop
    nop
    addi $r10, $r0, 100
    nop
    nop
    nop
    div $r9, $r8, $r10 #getting hundreds digit and putting into r9
    nop
    nop
    nop
    and $r11, $r11, $r0
    nop
    nop
    nop
    add $r11, $r9, $r0
    nop
    nop
    nop
    mul $r11, $r11, $r10
    nop
    nop
    nop
    sub $r8, $r8, $r11 #subtracting hundreds place so we have 10 and one left
    nop
    nop
    nop
    and $r12, $r12, $r0
    nop
    nop
    nop
    add $r12, $r12, $r9 #r12 has hundred bits
    nop
    nop
    nop
    addi $r10, $r0, 10
    nop
    nop
    nop
    div $r9, $r8, $r10
    nop
    nop
    nop
    and $r11, $r11, $r0
    nop
    nop
    nop
    add $r11, $r9, $r0
    nop
    nop
    nop
    mul $r11, $r11, $r10
    nop
    nop
    nop
    sub $r8, $r8, $r11 #subtracting tens place so we have one left
    nop
    nop
    nop
    sll $r9, $r9, 4
    nop
    nop
    nop
    add $r12, $r12, $r9 #r12 has hundred bits
    nop
    nop
    nop
    sll $r8, $r8, 8
    nop
    nop
    nop
    add $r12, $r12, $r8 
    nop
    nop
    nop
    #BCD VOL FIXED
    and $r8, $r8, $r0
    nop
    nop
    nop
    sll $r8, $r4, 20
    nop
    nop
    nop
    sra $r8, $r8, 20 #R8 HAS vol OF BUY
    nop
    nop
    nop
    and $r9, $r9, $r0
    nop
    nop
    nop
    and $r10, $r10, $r0
    nop
    nop
    nop
    addi $r10, $r0, 100
    nop
    nop
    nop
    div $r9, $r8, $r10 #getting hundreds digit and putting into r9
    nop
    nop
    nop
    and $r11, $r11, $r0
    nop
    nop
    nop
    add $r11, $r9, $r0
    nop
    nop
    nop
    mul $r11, $r11, $r10
    nop
    nop
    nop
    sub $r8, $r8, $r11 #subtracting hundreds place so we have 10 and one left
    nop
    nop
    nop
    sll $r9, $r9, 12
    nop
    nop
    nop
    add $r12, $r12, $r9 #r12 has hundred bits
    nop
    nop
    nop
    addi $r10, $r0, 10
    nop
    nop
    nop
    div $r9, $r8, $r10
    nop
    nop
    nop
    and $r11, $r11, $r0
    nop
    nop
    nop
    add $r11, $r9, $r0
    nop
    nop
    nop
    mul $r11, $r11, $r10
    nop
    nop
    nop
    sub $r8, $r8, $r11 #subtracting tens place so we have one left
    nop
    nop
    nop
    sll $r9, $r9, 16
    nop
    nop
    nop
    add $r12, $r12, $r9 #r12 has hundred bits
    nop
    nop
    nop
    sll $r8, $r8, 20
    nop
    nop
    nop
    add $r12, $r12, $r8 
    nop
    nop
    nop
    sw $r12, 32($r16) #saving buy stuff
    nop
    nop
    nop

    #BCD PRICE
    and $r8, $r8, $r0
    nop
    nop
    nop
    sll $r8, $r5, 8
    nop
    nop
    nop
    sra $r8, $r8, 20 #R8 HAS PRICE OF BUY
    nop
    nop
    nop
    and $r9, $r9, $r0
    nop
    nop
    nop
    and $r10, $r10, $r0
    nop
    nop
    nop
    addi $r10, $r0, 100
    nop
    nop
    nop
    div $r9, $r8, $r10 #getting hundreds digit and putting into r9
    nop
    nop
    nop
    and $r11, $r11, $r0
    nop
    nop
    nop
    add $r11, $r9, $r0
    nop
    nop
    nop
    mul $r11, $r11, $r10
    nop
    nop
    nop
    sub $r8, $r8, $r11 #subtracting hundreds place so we have 10 and one left
    nop
    nop
    nop
    and $r12, $r12, $r0
    nop
    nop
    nop
    add $r12, $r12, $r9 #r12 has hundred bits
    nop
    nop
    nop
    addi $r10, $r0, 10
    nop
    nop
    nop
    div $r9, $r8, $r10
    nop
    nop
    nop
    and $r11, $r11, $r0
    nop
    nop
    nop
    add $r11, $r9, $r0
    nop
    nop
    nop
    mul $r11, $r11, $r10
    nop
    nop
    nop
    sub $r8, $r8, $r11 #subtracting tens place so we have one left
    nop
    nop
    nop
    sll $r9, $r9, 4
    nop
    nop
    nop
    add $r12, $r12, $r9 #r12 has hundred bits
    nop
    nop
    nop
    sll $r8, $r8, 8
    nop
    nop
    nop
    add $r12, $r12, $r8 

    #BCD VOL FIXED
    and $r8, $r8, $r0
    nop
    nop
    nop
    sll $r8, $r5, 20
    nop
    nop
    nop
    sra $r8, $r8, 20 #R8 HAS vol OF BUY
    nop
    nop
    nop
    and $r9, $r9, $r0
    nop
    nop
    nop
    and $r10, $r10, $r0
    nop
    nop
    nop
    addi $r10, $r0, 100
    nop
    nop
    nop
    div $r9, $r8, $r10 #getting hundreds digit and putting into r9
    nop
    nop
    nop
    and $r11, $r11, $r0
    nop
    nop
    nop
    add $r11, $r9, $r0
    nop
    nop
    nop
    mul $r11, $r11, $r10
    nop
    nop
    nop
    sub $r8, $r8, $r11 #subtracting hundreds place so we have 10 and one left
    nop
    nop
    nop
    sll $r9, $r9, 12
    nop
    nop
    nop
    add $r12, $r12, $r9 #r12 has hundred bits
    nop
    nop
    nop
    addi $r10, $r0, 10
    nop
    nop
    nop
    div $r9, $r8, $r10
    nop
    nop
    nop
    and $r11, $r11, $r0
    nop
    nop
    nop
    add $r11, $r9, $r0
    nop
    nop
    nop
    mul $r11, $r11, $r10
    nop
    nop
    nop
    sub $r8, $r8, $r11 #subtracting tens place so we have one left
    nop
    nop
    nop
    sll $r9, $r9, 16
    nop
    nop
    nop
    add $r12, $r12, $r9 #r12 has hundred bits

    sll $r8, $r8, 20
    nop
    nop
    nop
    add $r12, $r12, $r8 
    nop
    nop
    nop

    sw $r12, 40($r16)
    and $r25, $r25, $r0
    and $r26, $r26, $r0
    and $r27, $r27, $r0
    and $r28, $r28, $r0

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

   #VolpriceOpriceTpriceH