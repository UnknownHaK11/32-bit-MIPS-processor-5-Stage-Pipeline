module IMux2x1 (
                 OutputData ,   //  32 bits

              
		///  Inputs

                 DataIn1 ,
                 DataIn2 ,
                 SelectIn

              );

parameter Size = 8;
output  [Size-1:0] OutputData ;

reg     [Size-1:0] OutputData ;

input   [Size-1:0]  DataIn1 ;
input   [Size-1:0]  DataIn2 ;
input   SelectIn ;

always @ ( DataIn1 or DataIn2 or SelectIn )
     begin //{
        if ( SelectIn )
            OutputData = DataIn1 ;
        else
            OutputData = DataIn2 ; 
      end //}

endmodule
