.PHONY: com sim cov run_dve run_verdi clean

#this can generate fsdb for systemverilog

OUTPUT = top#the name of output file
ALL_DEFINE = +define+DUMP_VDP  
ALL_DEFINE += +define+DUMP_FSDB

# code coverage command
CM      = -cm line+cond+fsm+branch+tgl
CM_NAME = -cm_name ${OUTPUT}
CM_DIR  = -cm_dir ./${OUTPUT}.vdb

# vpd file name
VPD_NAME = +vpdfile+${OUTPUT}.vpd

# compile command
VCS = 	vcs 				                 \
		-sverilog			                 \
	 	+v2k 				                 \
		-timescale=1ns/1ns	                 \
      	-debug_all			                 \
		+notimingcheck		                 \
		+nospecific			                 \
		+vcs+flush+all		                 \
		-full64				                 \
		-fsdb				                 \
		${ALL_DEFINE}		                 \
		${CM}				                 \
		${CM_NAME}			                 \
		${CM_DIR}	    	                 \
		${VPD_NAME}			                 \
		-o ${OUTPUT}		                 \
		-l compile.log

# simulation command
SIM = ./${OUTPUT}					\
		${CM} 						\
		${CM_NAME} 					\
		${CM_DIR}					\
		${VPD_NAME}					\
		-l ${OUTPUT}.log	

# start compile
com:
		${VCS} -f file_list.f

# start simulation
sim:  
	    ${SIM} | tee sim.log

# show the coverage
cov:  
	    dve -covdir *.vdb &
run_dve:
	    dve -vpd ${OUTPUT}.vpd &

# start the verdi
run_verdi:
	    verdi -f file_list.f -nologo -ssf ${OUTPUT}.fsdb &

# start clean
clean:  
	    rm -rf  simv* *.daidir *.log *.vpd *.vdb *.key *.fsdb *.dat *.rc *.conf *race.out* DVEfiles verdiLog csrc *.chain *.field *.lock *.netwk *.pidat *.podat *.sinf *.slist *.str *.tlist *.xlist


