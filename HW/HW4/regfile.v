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

	wire[31:0] regSelect

	decoder1to32 decoder(regSelect, RegWrite, WriteRegister);

	register32zero register0(regOut0, WriteData, regSelect[31], Clk);
	register32     register1(regout1, WriteData, regSelect[30], Clk);
	register32     register2(regout2, WriteData, regSelect[29], Clk);
	register32     register3(regout3, WriteData, regSelect[28], Clk);
	register32     register4(regout4, WriteData, regSelect[27], Clk);
	register32     register5(regout5, WriteData, regSelect[26], Clk);
	register32     register6(regout6, WriteData, regSelect[25], Clk);
	register32     register7(regout7, WriteData, regSelect[24], Clk);
	register32     register8(regout8, WriteData, regSelect[23], Clk);
	register32     register9(regout9, WriteData, regSelect[22], Clk);
	register32     register10(regout10, WriteData, regSelect[21], Clk);
	register32     register11(regout11, WriteData, regSelect[20], Clk);
	register32     register12(regout12, WriteData, regSelect[19], Clk);
	register32     register13(regout13, WriteData, regSelect[18], Clk);
	register32     register14(regout14, WriteData, regSelect[17], Clk);
	register32     register15(regout15, WriteData, regSelect[16], Clk);
	register32     register16(regout16, WriteData, regSelect[15], Clk);
	register32     register17(regout17, WriteData, regSelect[14], Clk);
	register32     register18(regout18, WriteData, regSelect[13], Clk);
	register32     register19(regout19, WriteData, regSelect[12], Clk);
	register32     register20(regout20, WriteData, regSelect[11], Clk);
	register32     register21(regout21, WriteData, regSelect[10], Clk);
	register32     register22(regout22, WriteData, regSelect[9], Clk);
	register32     register23(regout23, WriteData, regSelect[8], Clk);
	register32     register24(regout24, WriteData, regSelect[7], Clk);
	register32     register25(regout25, WriteData, regSelect[6], Clk);
	register32     register26(regout26, WriteData, regSelect[5], Clk);
	register32     register27(regout27, WriteData, regSelect[4], Clk);
	register32     register28(regout28, WriteData, regSelect[3], Clk);
	register32     register29(regout29, WriteData, regSelect[2], Clk);
	register32     register30(regout30, WriteData, regSelect[1], Clk);
	register32     register31(regout31, WriteData, regSelect[0], Clk);

	mux32to1by32 mux1(ReadData1, ReadRegister1, 
					  regOut0, regOut1, regOut2, regOut3, regOut4,
					  regOut5, regOut6, regOut7, regOut8, regOut9,
					  regOut10, regOut11, regOut12, regOut13, regOut14,
					  regOut15, regOut16, regOut17, regOut18, regOut19,
					  regOut20, regOut21, regOut22, regOut23, regOut24,
					  regOut25, regOut26, regOut27, regOut28, regOut29,
					  regOut30, regOut31);

	mux32to1by32 mux2(ReadData2, ReadRegister2, 
					  regOut0, regOut1, regOut2, regOut3, regOut4,
					  regOut5, regOut6, regOut7, regOut8, regOut9,
					  regOut10, regOut11, regOut12, regOut13, regOut14,
					  regOut15, regOut16, regOut17, regOut18, regOut19,
					  regOut20, regOut21, regOut22, regOut23, regOut24,
					  regOut25, regOut26, regOut27, regOut28, regOut29,
					  regOut30, regOut31);


  // These two lines are clearly wrong.  They are included to showcase how the 
  // test harness works. Delete them after you understand the testing process, 
  // and replace them with your actual code.
  assign ReadData1 = 42;
  assign ReadData2 = 42;

endmodule