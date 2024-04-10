module multdiv(
	data_operandA, data_operandB, 
	ctrl_MULT, ctrl_DIV, 
	clock, 
	data_result, data_exception, data_resultRDY);

    input [31:0] data_operandA, data_operandB;
    input ctrl_MULT, ctrl_DIV, clock;

    output [31:0] data_result;
    output data_exception, data_resultRDY;

    wire WE, clear, one, zero;
    assign one = 1;
    assign zero = 0;

  
    wire[31:0] multresult, divresult; 
    wire multexcep, divexcep, divready, multready;
    mult multiply(multresult, data_operandA, data_operandB, clock, ctrl_MULT, zero, multready, multexcep);
    div divide(divresult, data_operandB, data_operandA, clock, ctrl_DIV, zero, divready, divexcep);

    assign data_result = multactive? multresult : (divactive? divresult: 32'b0);
    assign data_exception = multactive? multexcep : (divactive? divexcep: 1'b0);
    assign data_resultRDY = multactive? multready : (divactive? divready: 1'b0);

    //FIGURE OUT CONTROL BETWEEN MULT AND DIV

    dffe_ref multdff(multactive, ctrl_MULT, clock, ctrl_MULT | ctrl_DIV, zero);
    dffe_ref divdff(divactive, ctrl_DIV, clock, ctrl_MULT | ctrl_DIV, zero);




    



    // add your code here
    //okay lets think about this rationale here
    //so if we are following the multiplication method, we take opA and opB, store them in registers, and add opA to registerM if LSB of opB is 1, then shift opB by 1. 
    

    //check if LSB op is one



    

    
    //we have counter, will equaL 32 when bit5 is 1. So we need notbit5 AND clock as enable for out write to register
    
   






endmodule