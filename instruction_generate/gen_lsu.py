from base64 import decode
from unittest import case

def gen_fu_inst(operation):
    Decoder={
        '+': "0000",
        '-': "0001",
        '*': "0010",
    }
    Encoder = str(Decoder[operation])    
    return Encoder

def gen_C2_C1_inst(din_0,din_2):
    Decoder={
        'din_N': "1",
        'din_W': "0",
        'din_S': "1",
        'din_E': "0"
    }
    c1  = str(Decoder[din_0])  
    c2  = str(Decoder[din_2])  
    Encoder =c2+c1
    return  Encoder

def gen_regfile_inst(dout_R0,dout_R1,dout_R2,dout_R3):
    if dout_R0 == "res":
        R0_sel ='0'
    elif dout_R0 == 'din_0':
        R0_sel ='1'
    else :
        print("dout_R0 argument invalid")
    
    if dout_R1 == "dout_R0":
        R1_sel ='0'
    elif dout_R1 == 'din_1':
        R1_sel ='1'
    else :
        print("dout_R1 argument invalid")
    
    if dout_R2 == "dout_R1":
        R2_sel ='0'
    elif dout_R2 == 'din_2':
        R2_sel ='1'
    else :
        print("dout_R2 argument invalid")
    
    if dout_R3 == "dout_R2":
        R3_sel ='0'
    elif dout_R3 == 'din_3':
        R3_sel ='1'
    else :
        print("dout_R3 argument invalid")
    
    Decoder= R0_sel+R1_sel+R2_sel+R3_sel
    return Decoder

def gen_crossbar_inst(dout_N,dout_W,dout_S,dout_E,op_A,op_B):
    Decoder={
        'dout_R0': "000",'dout_R1': "001",'dout_R2': "010",'dout_R3': "011",'din_0'  : "100",'din_1'  : "101",'din_res': "110",'random' : "111"
    }
    op_A_sel  = str(Decoder[op_A])  
    op_B_sel  = str(Decoder[op_B])  
    dout_N_sel= str(Decoder[dout_N])
    dout_S_sel= str(Decoder[dout_S])
    dout_W_sel= str(Decoder[dout_W])
    dout_E_sel= str(Decoder[dout_E]) 
    Encoder=op_A_sel+op_B_sel+dout_N_sel+dout_S_sel+dout_W_sel+dout_E_sel
    return Encoder


if __name__ == '__main__':
    crossbar_inst=gen_crossbar_inst(
        dout_N='din_0'  ,
        dout_W='din_1'  ,
        dout_S='dout_R2',
        dout_E='dout_R3',
        op_A  ='din_0',
        op_B  ='din_1'
    )

    regfile_inst=gen_regfile_inst(
        dout_R0="res",
        dout_R1='dout_R0',
        dout_R2='dout_R1',
        dout_R3='dout_R2')
    
    C2_C1_inst=gen_C2_C1_inst(
        din_0='din_N',
        din_2='din_S'
    )

    fu_inst=gen_fu_inst(
        operation='+'
    )
    
    PE_inst=fu_inst+crossbar_inst+C2_C1_inst+regfile_inst
    print(PE_inst)
    print(len(PE_inst))
    PE_inst_hex=hex(int(PE_inst,2))
    print(str(PE_inst_hex))