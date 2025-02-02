`include "../Define/Fragment_Define.v"

module Hazard_detection_unit(branch_Or_Jump, ID_EX_MemRead, ID_EX_Rt, IF_ID_Rs, IF_ID_Rt, IF_ID_Write, PC_Write, PC_Mux_select, IF_ID_Mux_select, ID_EX_Mux_select);
	input [1:0] branch_Or_Jump;
	input ID_EX_MemRead;
	input [4:0] ID_EX_Rt;
	input [4:0] IF_ID_Rs;
	input [4:0] IF_ID_Rt;
	output reg IF_ID_Write;
	output reg PC_Write;
	output reg [1:0] PC_Mux_select;
	output reg IF_ID_Mux_select;
	output reg ID_EX_Mux_select;
	
	always@(*)
		begin
		if(ID_EX_MemRead && ((ID_EX_Rt == IF_ID_Rs) || (ID_EX_Rt == IF_ID_Rt)))
			begin
			PC_Write <= 1'b0;
			IF_ID_Write <= 1'b0;
			ID_EX_Mux_select <= 1'b1;
			end
		else
			begin
			case(branch_Or_Jump)
				`Sequence:
					begin
					PC_Write <= 1'b1;
					IF_ID_Write <= 1'b1;
					PC_Mux_select <= 2'b00;
					IF_ID_Mux_select <= 1'b0;
					ID_EX_Mux_select <= 1'b0;
					end
				`Branch:
					begin
					PC_Write <= 1'b1;
					IF_ID_Write <= 1'b1;
					PC_Mux_select <= 2'b00;
					IF_ID_Mux_select <= 1'b0;
					ID_EX_Mux_select <= 1'b0;
					end
				`NotBranch:
					begin
					PC_Write <= 1'b1;
					IF_ID_Write <= 1'b1;
					PC_Mux_select <= 2'b01;
					IF_ID_Mux_select <= 1'b1;
					ID_EX_Mux_select <= 1'b1;
					end
				`Jump:
					begin
					PC_Write <= 1'b1;
					IF_ID_Write <= 1'b1;
					PC_Mux_select <= 2'b10;
					IF_ID_Mux_select <= 1'b1;
					ID_EX_Mux_select <= 1'b1;
					end
				default:
					begin
					PC_Write <= 1'b0;
					IF_ID_Write <= 1'b0;
					PC_Mux_select <= 2'b00;
					IF_ID_Mux_select <= 1'b0;
					ID_EX_Mux_select <= 1'b0;
					end
			endcase
			end
		end
endmodule