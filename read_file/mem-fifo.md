**bank-fifo 端口设置**


off-chip-mem 总线设计

    assign	{
        off_chip_sel//43:42
		off_chip_en,//41:41
		wr_sel,		//40:40  1 ->write_en  0 -> read_en
		access_addr,//39:32
		write_data,	//31:0
	} = off_chip_bus;

bank 总线设计

    	assign	{
		access_en1,	//41:41
		wr_sel,		//40:40  1 ->write_en  0 -> read_en
		access_addr,//39:32
		write_data	//31:0
 		} = bank1_bus;

## lsu out总线设计 ##
	
    assign	{
        lsu_bank_sel//42:42
		lsu_en,		//41:41
		wr_sel,		//40:40  1 ->write_en  0 -> read_en
		access_addr,//39:32
		write_data	//31:0
	} = lsu_bus;


**lsu inst design** 

	assign {
        store_sel,		//17:17  1->load_reg  0->PE_data
		pe_control,     //16:15
	    mode_sel,	    //14:14  0-> rom  1->fifo
        fifo_sel,	    //13:11
	    lsu_bank_sel,   //10:10
	    lsu_en,		    //9:9
        wr_sel,  	    //8:8  1 ->write_en  0 -> read_en
	    rom_addr 	    //7:0
    } = inst;


##	bank_fifo port ##

