module counterR7 (
	input logic clk, rst, incr_pc, R7in,
	input logic [8:0] BUS,
	output logic [8:0] R7
);
logic [8:0] PC;

always_ff @(posedge clk or negedge rst) begin
	if (~rst) begin
		PC <= 9'b000000000;
		end
	else if (R7in == 1'b1) begin
		PC <= BUS;
		end
	else if (incr_pc == 1'b1) begin
		PC <= PC + 9'b000000001;
		end
end

assign R7 = PC;
endmodule 