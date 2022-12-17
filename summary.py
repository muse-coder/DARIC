# import pwd
import re
import pandas as pd
import  os
def get_area_report(file_path,str_pattern):
    file=open(file_path,'r')
    content=file.readlines()
    target=[]
    target_sum_area=0
    for line in content:
        line_split = line.split()
        str_content = line_split[0]
        if str_pattern.match(str_content):
            # print (str_content)
            # print(str_content)
            target.append(line_split[1])
            target_sum_area = target_sum_area + float(line_split[1])
    # print(len(target))
    average_area=0
    if(len(target)>0):
        average_area=target_sum_area/len(target)
    # print(target_sum_area/len(target))
    file.close() #文件打开，使用完毕后需要关闭
    return average_area , len(target)
    
def get_area_df(file_path,pattern_dic):
    df_index=[]
    df_area=[]
    df_num=[]
    for target_pattern in pattern_dic:
        average_area,num=get_area_report(file_path,target_pattern['pattern'])
        pattern_name=target_pattern['name']
        # print(pattern_name)
        df_index.append(pattern_name)
        df_area.append(average_area)
        df_num.append(num)        
    data={"average_area":df_area,"num":df_num}
    df=pd.DataFrame(data,index=df_index)
    file_path_split=file_path.split('\\')
    print("***********************************")
    print(df)
    print(file_path)
    print("***********************************")
    to_csv_path=file_path_split[0]+"_"+file_path_split[2]+"_area.csv"
    df.to_csv(to_csv_path)
    
def get_power_report(file_path,str_pattern):
    file=open(file_path,'r')
    content=file.readlines()
    target=[]
    target_sum_power=0
    for line in content:
        line_split = line.split()
        str_content = line_split[0]
        if str_pattern.match(str_content):
            # print (str_content)
            # print(str_content)
            target.append(line_split[5])
            target_sum_power = target_sum_power + float(line_split[5])
    # print(len(target))
    average_power=0
    if(len(target)):
        average_power=target_sum_power/len(target)
    # print(target_sum_power/len(target))
    file.close() #文件打开，使用完毕后需要关闭
    return average_power , len(target)
    
def get_power_df(file_path,pattern_dic):
    df_index=[]
    df_power=[]
    df_num=[]
    for target_pattern in pattern_dic:
        average_power,num=get_power_report(file_path,target_pattern['pattern'])
        pattern_name=target_pattern['name']
        # print(pattern_name)
        df_index.append(pattern_name)
        df_power.append(average_power)
        df_num.append(num)        
    data={"average_power":df_power,"num":df_num}
    df=pd.DataFrame(data,index=df_index)
    file_path_split=file_path.split('\\')
    print("***********************************")
    print(df)
    print(file_path)
    print("***********************************")
    to_csv_path=file_path_split[0]+"_"+file_path_split[2]+"_power.csv"
    df.to_csv(to_csv_path)
    
if __name__ == '__main__':
    reports_paths=['report\\new\\4_LSU_FIFO_reports','report\\new\\4_LSU_no_FIFO_reports',
                   'report\\new\\8_LSU_FIFO_reports','report\\new\\8_LSU_no_FIFO_reports']
    # daric_with_fifo_path=['./4_LSU_FIFO_reports','./8_LSU_FIFO_reports']
    # daric_no_fifo_path=['./4_LSU_FIFO_reports','./8_LSU_FIFO_reports']
    area_file_list=[]
    power_file_list=[]
    for path in reports_paths:
        area_report_path=path+'\\Daric.mapped.area.txt'
        power_report_path=path+'\\Daric.mapped.power.txt'
        
        area_file_list.append(area_report_path)        
        power_file_list.append(power_report_path)
        
    area_pe_pattern_dic={'name':"PE", 'pattern':re.compile(r".*PE_[0-9]$")}
    area_lsu_pattern_dic={'name':"LSU", 'pattern':re.compile(r".*LSU$")}
    area_pe_crossbar_7x6_pattern_dic={'name':"PE_crossbar_7x6", 'pattern':re.compile(r".*PE_crossbar_7x6_inst$")}
    area_fu_pattern_dic={'name':"fu", 'pattern':re.compile(r".*fu_lut$")}
    area_reg_file_pattern_dic={'name':"reg_file", 'pattern':re.compile(r".*reg_file_lut$")}
    area_fifo_pattern_dic={'name':"fifo", 'pattern':re.compile(r".*fifo_[0-9]$")}
    area_BG_pattern_dic={'name':"BG", 'pattern':re.compile(r".*BG[0-9]$")}

    power_pe_pattern_dic={'name':"PE", 'pattern':re.compile(r"^PE_[0-9]")}
    power_lsu_pattern_dic={'name':"LSU", 'pattern':re.compile(r"^LSU")}
    power_pe_crossbar_7x6_pattern_dic={'name':"PE_crossbar_7x6", 'pattern':re.compile(r"^PE_crossbar_7x6_inst")}
    power_fu_pattern_dic={'name':"fu", 'pattern':re.compile(r"^fu_lut")}
    power_reg_file_pattern_dic={'name':"reg_file", 'pattern':re.compile(r"^reg_file_lut")}
    power_fifo_pattern_dic={'name':"fifo", 'pattern':re.compile(r"^fifo_[0-9]")}
    power_BG_pattern_dic={'name':"BG", 'pattern':re.compile(r"^BG[0-9]")}

    area_pattern_dic=[area_pe_pattern_dic,area_lsu_pattern_dic,area_pe_crossbar_7x6_pattern_dic
                       ,area_fu_pattern_dic,area_reg_file_pattern_dic,area_fifo_pattern_dic,area_BG_pattern_dic]
    
    power_pattern_dic=[power_pe_pattern_dic,power_lsu_pattern_dic,power_pe_crossbar_7x6_pattern_dic,
                      power_fu_pattern_dic,power_reg_file_pattern_dic,power_fifo_pattern_dic,power_BG_pattern_dic]
    print(os.getcwd())
    
    for area_file_path in area_file_list :
        get_area_df(area_file_path,area_pattern_dic)
        print('\n')
        
    for power_file_path in power_file_list :
        get_power_df(power_file_path,power_pattern_dic)
    