`timescale	1ns/1ns
///////////////////////////////////////////////////////////////////////////
// Author		 : ������
// Create Date   : 2019/05/12
// Module Name	 : tb_simple_fsm
// Project Name	 : simple_fsm
// Target Devices: Altera EP4CE10F17C8N
// Tool Versions : Quartus 13.0
// Description	 : 
// Revision		 : V1.0
// Additional Comments:
//////////////////////////////////////////////////////////////////////////

module	tb_simple_fsm();

reg		sys_clk;
reg		sys_rst_n;
reg		pi_money;

wire	po_cola;

//��ʼ��ϵͳʱ�ӡ�ȫ�ָ�λ
initial	begin
	sys_clk	   = 1'b1;
	sys_rst_n <= 1'b0;
	#20
	sys_rst_n <= 1'b1;
    #100000
    $finish;
end

//sys_clk:ģ��ϵͳʱ�ӣ�ÿ10ns��ƽ��תһ�Σ�����Ϊ20ns��Ƶ��Ϊ50MHz
always	#10	sys_clk = ~sys_clk;

//pi_money:���������������ģ��Ͷ��1Ԫ�����
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)	
		pi_money <= 1'b0;
	else
		pi_money <=	{$random} % 2;	        //ȡģ�������������Ǹ������0��1
		
//------------------------------------------------------------ 
wire [2:0] state = simple_fsm_inst.state;   //��RTLģ���е��ڲ��ź����뵽Testbenchģ���н��й۲�

initial	begin
	$timeformat(-9, 0, "ns", 6);
	$monitor("@time %t: pi_money=%b state=%b po_cola=%b", $time, pi_money, state, po_cola);
end
//------------------------------------------------------------

initial begin
  `ifdef DUMP_VPD
    $vcdpluson(0,tb_simple_fsm);
    #100000
    $vcdplusoff(tb_simple_fsm);
  `endif
end

initial begin
  `ifdef DUMP_FSDB
    $fsdbDumpfile("simple_fsm.fsdb");
    $fsdbDumpvars(0,tb_simple_fsm);
  `endif
end

//------------------------simple_fsm_inst------------------------	
simple_fsm	simple_fsm_inst(
    .sys_clk	(sys_clk	),	//input		sys_clk		
	.sys_rst_n	(sys_rst_n	),	//input		sys_rst_n	
	.pi_money	(pi_money	),	//input		pi_money	
					
	.po_cola	(po_cola	)	//output	po_cola		
);

endmodule 	
