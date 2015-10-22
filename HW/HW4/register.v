// Single-bit D Flip-Flop with enable
//   Positive edge triggered
module register
(
output reg	q,
input		d,
input		wrenable,
input		clk
);

    always @(posedge clk) begin
        if(wrenable) begin
            q = d;
        end
    end

endmodule

module register32
(
output reg[31:0] q,
input[31:0]      d,
input            wrenable,
input            clk
);
	always @(posedge clk) begin
		if(wrenable) begin
			q = d;
		end
	end

module register32
(
output reg[31:0] q,
input[31:0]      d,
input            wrenable,
input            clk
);

	q = 32'b0

endmodule

module mux32to1by1
(
output      out,
input[4:0]  address,
input[31:0] inputs
);
  assign out = inputs[address];
endmodule

module mux32to1by32
(
output[31:0]    out,
input[4:0]      address,
input[31:0]     input0, input1, input2, ..., input31
);

  wire[31:0] mux[31:0];         // Create a 2D array of wires
  assign mux[0] = input0;       // Connect the sources of the array
  assign mux[1] = input0;
  assign mux[2] = input0;
  assign mux[3] = input0;
  assign mux[4] = input0;
  assign mux[5] = input0;
  assign mux[6] = input0;
  assign mux[7] = input0;
  assign mux[8] = input0;
  assign mux[9] = input0;
  assign mux[10] = input0;
  assign mux[11] = input0;
  assign mux[12] = input0;
  assign mux[13] = input0;
  assign mux[14] = input0;
  assign mux[15] = input0;
  assign mux[16] = input0;
  assign mux[17] = input0;
  assign mux[18] = input0;
  assign mux[19] = input0;
  assign mux[20] = input0;
  assign mux[21] = input0;
  assign mux[22] = input0;
  assign mux[23] = input0;
  assign mux[24] = input0;
  assign mux[25] = input0;
  assign mux[26] = input0;
  assign mux[27] = input0;
  assign mux[28] = input0;
  assign mux[29] = input0;
  assign mux[30] = input0;
  assign mux[31] = input0;
  assign out = mux[address];    // Connect the output of the array
endmodule