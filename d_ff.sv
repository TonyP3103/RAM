module d_ff (
	input logic [8:0] d,
	input logic rst, clk, EN,
	output logic [8:0] q);
	
always_ff @(posedge clk or negedge rst) begin
if (!rst) 	
			q <= 0;
else if (EN) 
			q <= d;
end
endmodule 


module d_ff1bit (
	input logic d,
	input logic rst, clk, EN,
	output logic q);
always_ff @(posedge clk or negedge rst) begin
if (!rst) 	
			q <= 0;
else if (EN) 
			q <= d;
end
endmodule 