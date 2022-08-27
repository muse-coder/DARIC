//---------------PE_INST----------------//


    always  #(cycle/2)  clk = ~ clk;
    integer i;
    initial begin
        clk = 1'b1;
        rst = 1'b1;
        BG3_en  =  1'b0 ;   BG3_sel  =  1'b0 ;    BG3_mode  =  1'b0 ; BG3_fifo_sel ='b0 ;   //  19:18
	    BG2_en  =  1'b0 ;   BG2_sel  =  1'b0 ;    BG2_mode  =  1'b0 ; BG2_fifo_sel ='b0 ;   //  17:16
	    BG1_en  =  1'b0 ;   BG1_sel  =  1'b0 ;    BG1_mode  =  1'b0 ; BG1_fifo_sel ='b0 ;   //  15:14
	    BG0_en  =  1'b0 ;   BG0_sel  =  1'b0 ;    BG0_mode  =  1'b0 ; BG0_fifo_sel ='b0 ;   //  13:12
        ex_wen  =  'b0;   
	    ex_ren  =  'b0;   
	    ex_addr =  'b0;  
	    ex_data =  'b1;  
        //LSU initial
        LSU_0_ren      ='b0 ;   LSU_1_ren      ='b0 ;   LSU_2_ren      ='b0 ;   LSU_3_ren      ='b0 ;
        LSU_0_wen      ='b0 ;   LSU_1_wen      ='b0 ;   LSU_2_wen      ='b0 ;   LSU_3_wen      ='b0 ;
        LSU_0_w_sel    ='b0 ;   LSU_1_w_sel    ='b0 ;   LSU_2_w_sel    ='b0 ;   LSU_3_w_sel    ='b0 ;
        LSU_0_pe_sel   ='b0 ;   LSU_1_pe_sel   ='b0 ;   LSU_2_pe_sel   ='b0 ;   LSU_3_pe_sel   ='b0 ;
        LSU_0_store_sel='b1 ;   LSU_1_store_sel='b1 ;   LSU_2_store_sel='b1 ;   LSU_3_store_sel='b1 ;
          
                           
//--------向BG0写入20个数据-----------------//
    #40 rst = 1'b0;
        BG0_en      =   1'b1;
        ex_wen      =   1'b1;
        for ( i=1 ;i<=20 ;i=i+1 ) begin
    		#10 ex_addr   <= 'b0 +i   ;	//41:32
    		    ex_data   <= 'b1 +i   ;  		//31:0
        end
        BG0_en      =   1'b1;
        ex_wen      =   1'b0;
// -------------end------------------//

//  BG0停止写数据  LSU0发出读指令 读出10个数据(LSU和external读写需要切换模式 BG_sel)--------//
        LSU_0_ren    =   1'b1   ;      
        BG0_sel      =   1'b1   ;    
//  LSU0发出写FIFO模式指令 向BG1的FIFO0写入10个数据,LSU0连接BG1 修改crossbar指令
    #30  BG1_en      =   1'b1   ;
         BG1_mode    =   1'b1   ;    
         BG1_sel     =   1'b1   ;  
         LSU_0_w_sel =   2'b01  ;
         LSU_0_wen   =   1'b1   ;
//  LSU0向PE0写入load数据至R0
    
//  LSU0停止写FIFO   LSU1开始读BG1的FIFO0 且将读出的数据写入到BG2的FIFO0         
    #100 LSU_0_wen   =   1'b0   ;
         LSU_1_ren   =   1'b1   ;
         
    #30  LSU_1_wen   =   1'b1   ;
         LSU_1_w_sel =   2'b10  ;
         BG2_mode    =   1'b1   ;
         BG2_en      =   1'b1   ;
         BG2_sel     =   1'b1   ;
//  LSU2开始读BG2中的FIFO0数据 
    #10  LSU_2_ren   =   1'b1   ;
    end 
