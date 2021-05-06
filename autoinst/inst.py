#!/usr/bin/python
import sys
import re
 
#global parameter max length
maxlen=0
maxbw =0

#global match mode
comment_pt=r'^\s*\/\/'
cmatch    =re.compile(comment_pt)

module_pt =r'module\s+(\w+)'
mmatch    =re.compile(module_pt)

parameter_pt=r'parameter\s*(\w+)\s*=.*'
pmatch      =re.compile(parameter_pt)

signal_pt =r'(output|input|inout)\s*(wire|reg|\s)\s*(\[.*?:.*?\]|\s)\s*(\w+)\s*[,; \n]'
smatch    =re.compile(signal_pt)

end_pt    = r'^\s*endmodule'
ematch    = re.compile(end_pt)

#caculate the max length
def calc_maxlen(rtlfile):
    global maxlen
    global maxbw
    global pmatch
    global smatch
    test=open(rtlfile)
    while True:
        line=test.readline()
        if not line:
            break
        if pmatch.findall(line):
            p_tmp=pmatch.findall(line)[0]
            if len(p_tmp)>maxlen:
                maxlen=len(p_tmp)
        if smatch.findall(line):
            s_tmp=smatch.findall(line)[0]
            if len(s_tmp[3])>maxlen:
                maxlen=len(s_tmp[3])
            if len(s_tmp[2].replace('/t',''))>maxbw:
                maxbw=len(s_tmp[2].replace('/t',''))

def igen(rtlfile):
    global maxlen
    global maxbw 
    global cmatch
    global mmatch
    global pmatch
    global smatch
    global ematch
    params=[]
    sigs  =[]
    start =0
    end   =0
    md_name=''
    ins_name='U_'+md_name

    file=rtlfile
    test=open(file)
    while True:
        line=test.readline()
        if not line:
            break

        comment_mc=cmatch.match(line)
        module_mc =mmatch.match(line)
        end_mc    =ematch.match(line)

        if comment_mc:
            pass
        elif module_mc:
            md_name=module_mc.group(1)
            start=1
        elif end==1:
            start=0
            break
        if pmatch.findall(line) and start==1:
            p_tmp=pmatch.findall(line)[0]
            params.append(p_tmp)
        if smatch.findall(line) and start==1:
            s_tmp=smatch.findall(line)[0]
            sigs.append(s_tmp)
        if end_mc:
            end=1
    test.close

    ins_name='U_'+md_name.upper()

    #print head
    head_fmt0='/'*2+'-'*58
    head_fmt1='/'*2+'-'*4+' INSTANCE OF '+md_name

    print head_fmt0
    print head_fmt1
    print head_fmt0

    #print output wire
    for sig in sigs:
        #if sig[3][:3]=='clk' or sig[3][:3]=='rst':
        #    new_sig3=sig[3]
        #elif sig[3][-2:]=='_i' or sig[3][-2:]=='_o':
        #    new_sig3=sig[3][:-2]+'_s'
        #else:
        #   new_sig3=sig[3]
        new_sig3=sig[3]

        if sig[0]=='output' or sig[0]=='inout':
            print "wire"+" "*4+\
                  "%-*s "%(maxbw,sig[2].replace('/t',''))+\
                  " "*4+\
                  "%-*s;"%(maxlen,new_sig3)
    
    #print module name
    if len(params)==0:
        print "%-s %-s("%(md_name,ins_name)
    else:
        print "%-s #("%md_name
    
    #print instance of parameter
    if len(params)==0:
        pass
    else:
        for param in params:
            if params[len(params)-1]==param:
                sp_param=")"
            else:
                sp_param=","
            print "    .%-*s (%-*s )%s"%\
            (maxlen,param,maxlen,param,sp_param)
    
    #print instance name
    if len(params)==0:
        pass
    else:
        print ins_name+' ('
    
    #print input and output signals
    for sig in sigs:
        if sigs[len(sigs)-1]==sig:
            sp_sig=' '
        else:
            sp_sig=','
        if sigs[0]=='inout':
            dirtag='io'
        else :
            dirtag=sig[0][0]

        #if sig[3][:3]=='clk' or sig[3][:3]=='rst':
        #    new_sig3=sig[3]
        #elif sig[3][-2:]=='_i' or sig[3][-2:]=='_o':
        #    new_sig3=sig[3][:-2]+'_s'
        #else:
        #    new_sig3=sig[3]
        new_sig3=sig[3]
        print "    .%-*s (%-*s )%s //%s,%-*s"%\
                (maxlen,sig[3],\
                 maxlen,new_sig3,\
                 sp_sig       ,\
                 dirtag,maxbw ,\
                 sig[2].replace('/t',''))
    
    #print end
    print ");"
    print ""
    
#run the program
if len(sys.argv)<2:
    print "ERROR USEAGE"
else:
    for aidx in range(1,len(sys.argv)):
        calc_maxlen(sys.argv[aidx])
    for aidx in range(1,len(sys.argv)):
        igen(sys.argv[aidx])
