# 向bank写入数据 #

## lsu1 ##
向bank1-fifo-0中存入PE1数据 32'd5
lsu-inst code    
	0   store_sel,		//17:17  1->load_reg  0->PE_data
	00	pe_control,     //16:15
	1    mode_sel,	    //14:14  0-> rom  1->fifo
    000    fifo_sel,	    //13:11
	0    lsu_bank_sel,   //10:10
	1   lsu_en,		    //9:9
    1    wr_sel,  	    //8:8  1 ->write_en  0 -> read_en
	8'd000    rom_addr 	    //7:0

inst				  pe1    pe2     pe3    pe4     bank_readin_bus  
0 00  1 000 0 1 1 8'd0	   32'd5  32'd0   32'd0  32'd0   0

0 00  1 000 

## lsu2 ## disable

0 00 1 000 0 0 

