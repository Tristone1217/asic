`timescale	1ns/1ns
///////////////////////////////////////////////////////////////////////////
// Author		 : ������
// Create Date	 : 2019/05/12
// Module Name	 : simple_fsm
// Project Name	 : simple_fsm
// Target Devices: Altera EP4CE10F17C8
// Tool Versions : Quartus 13.0
// Description	 :
// Revision      : V1.0
// Additional Comments:
//////////////////////////////////////////////////////////////////////////

module	simple_fsm(
	input	wire	sys_clk		,	//ϵͳʱ��50MHz
	input	wire	sys_rst_n	,	//ȫ�ָ�λ
	input	wire	pi_money	,	//Ͷ�ҷ�ʽ����Ϊ����Ͷ�ң�0����Ͷ1Ԫ��1��
		
	output	reg		po_cola			//po_colaΪ1ʱ�����֣�po_colaΪ0ʱ��������	
);

//ֻ������״̬��ʹ�ö�����
parameter	IDLE = 3'b001;
parameter	ONE  = 3'b010;
parameter	TWO  = 3'b100;

reg		[2:0]	state;				

//��һ��״̬����������ǰ״̬state��θ���������ת����һ״̬
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		state <= IDLE;								//�κ������ֻҪ����λ�ͻص���ʼ״̬
	else	case(state)
				IDLE	:	if(pi_money == 1'b1)	//�ж��������
								state <= ONE;
							else
								state <= IDLE;
								
				ONE		:	if(pi_money == 1'b1)
								state <= TWO;							
							else
								state <= ONE;
								
				TWO		:	if(pi_money == 1'b1)
								state <= IDLE;
							else	
								state <= TWO;
								
				default	:		state <= IDLE;		//���״̬����ת�������״̬֮��Ҳ�ص���ʼ״̬
			endcase

//�ڶ���״̬����������ǰ״̬state������pi_money���Ӱ��po_cola���
always@(posedge sys_clk	or negedge sys_rst_n)	
	if(sys_rst_n ==	1'b0)	
		po_cola <= 1'b0;
	else 	if((state == TWO) && (pi_money == 1'b1))		
		po_cola <= 1'b1;
	else	
		po_cola <= 1'b0;
			
endmodule	
