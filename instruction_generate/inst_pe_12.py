# pe0 inst din_N->din_0->dout_E
import gen_pe 
if __name__ == '__main__':
    crossbar_inst=gen_pe.gen_crossbar_inst(
        dout_N='din_0'  ,
        dout_W='din_res'  ,
        dout_S='din_1',
        dout_E='din_0',
        op_A  ='din_0',
        op_B  ='din_1'
    )

    regfile_inst=gen_pe.gen_regfile_inst(
        dout_R0="res",
        dout_R1='dout_R0',
        dout_R2='dout_R1',
        dout_R3='dout_R2')
    
    C2_C1_inst=gen_pe.gen_C2_C1_inst(
        din_0='din_N',
        din_2='din_S'
    )

    fu_inst=gen_pe.gen_fu_inst(
        operation='+'
    )
    
    PE_inst=fu_inst+crossbar_inst+C2_C1_inst+regfile_inst
    print(PE_inst)
    print(len(PE_inst))
    PE_inst_hex=hex(int(PE_inst,2))
    print(str(PE_inst_hex))