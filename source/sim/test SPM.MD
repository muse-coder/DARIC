##  向SPM写入十个外部数据 1 2 3 ---10
    BG0有效
    SPM_inst:
    BG3_en=0    BG3_sel =0  BG3_mode =0 
	BG2_en=0    BG2_sel =0  BG2_mode =0 
	BG1_en=0    BG1_sel =0  BG1_mode =0 
	BG0_en=1    BG0_sel =0  BG0_mode =0 

    ex_bus:
    ex_wen  = 1
	ex_ren  = 0
	ex_addr = 0-------9
	ex_data = 1-------10    

    LSU_INST
    ren         =   0,     //6:6
    wen         =   0,     //5:5
    w_sel       =   00,    //4:3
    pe_sel      =   00,    //2:1
    store_sel   =   0      //0:0