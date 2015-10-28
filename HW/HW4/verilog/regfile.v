//------------------------------------------------------------------------------
// MIPS register file
//   width: 32 bits
//   depth: 32 words (reg[0] is static zero register)
//   2 asynchronous read ports
//   1 synchronous, positive edge triggered write port
//------------------------------------------------------------------------------

module regfile
(
output[31:0]	ReadData1,	// Contents of first register read
output[31:0]	ReadData2,	// Contents of second register read
input[31:0]	WriteData,	// Contents to write to register
input[4:0]	ReadRegister1,	// Address of first register to read
input[4:0]	ReadRegister2,	// Address of second register to read
input[4:0]	WriteRegister,	// Address of register to write
input		RegWrite,	// Enable writing of register when High
input		Clk		// Clock (Positive Edge Triggered)
);

	wire[31:0] regSelect;
	decoder1to32 decoder(regSelect, RegWrite, WriteRegister);

	wire[31:0][31:0] regOutputs;

	register32zero register0(regOutputs[0], WriteData, regSelect[0], Clk);

	genvar index;
	generate
		for (index = 1; index < 32; index = index + 1) begin: REGISTERS
			register32 registerN(regOutputs[index], WriteData, regSelect[index], Clk);
		end
	endgenerate

  	mux32to1by32 mux1(ReadData1, ReadRegister1, regOutputs[0], regOutputs[1], regOutputs[2], regOutputs[3], regOutputs[4], regOutputs[5], regOutputs[6], regOutputs[7], regOutputs[8], regOutputs[9], regOutputs[10], regOutputs[11], regOutputs[12], regOutputs[13], regOutputs[14], regOutputs[15], regOutputs[16], regOutputs[17], regOutputs[18], regOutputs[19], regOutputs[20], regOutputs[21], regOutputs[22], regOutputs[23], regOutputs[24], regOutputs[25], regOutputs[26], regOutputs[27], regOutputs[28], regOutputs[29], regOutputs[30], regOutputs[31]);
  	mux32to1by32 mux2(ReadData2, ReadRegister2, regOutputs[0], regOutputs[2], regOutputs[1], regOutputs[3], regOutputs[4], regOutputs[5], regOutputs[6], regOutputs[7], regOutputs[8], regOutputs[9], regOutputs[10], regOutputs[11], regOutputs[12], regOutputs[13], regOutputs[14], regOutputs[15], regOutputs[16], regOutputs[17], regOutputs[18], regOutputs[19], regOutputs[20], regOutputs[21], regOutputs[22], regOutputs[23], regOutputs[24], regOutputs[25], regOutputs[26], regOutputs[27], regOutputs[28], regOutputs[29], regOutputs[30], regOutputs[31]);

	// assign ReadData1 = 32'd42;
	// assign ReadData2 = 32'd42;
endmodule