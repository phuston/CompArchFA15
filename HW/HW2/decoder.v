`define AND and #50
`define OR or #50
`define NOT not #50

module behavioralDecoder(out0,out1,out2,out3, address0,address1, enable);
output out0, out1, out2, out3;
input address0, address1;
input enable;
assign {out3,out2,out1,out0}=enable<<{address1,address0};
endmodule

module structuralDecoder(out0,out1,out2,out3, address0,address1, enable);
output out0, out1, out2, out3;
input address0, address1;
input enable;
wire naddress0, naddress1, a0ANDa1, NOTa0ANDNOTa1, a0ANDNOTa1, NOTa0ANDa1;
`NOT not1(naddress0, address0);
`NOT not2(naddress1, address1);
`AND and1(a0ANDa1, address0, address1);
`AND and2(NOTa0ANDNOTa1, naddress0, naddress1);
`AND and3(a0ANDNOTa1, address0, naddress1);
`AND and4(NOTa0ANDa1, naddress0, address1);

`AND and5(out0, enable, NOTa0ANDNOTa1);
`AND and6(out1, enable, a0ANDNOTa1);
`AND and7(out2, enable, NOTa0ANDa1);
`AND and8(out3, enable, a0ANDa1);

endmodule

module testDecoder; 
	reg addr0, addr1;
	reg enable;
	wire out0,out1,out2,out3;
	// behavioralDecoder decoder (out0,out1,out2,out3,addr0,addr1,enable);
	structuralDecoder decoder (out0,out1,out2,out3,addr0,addr1,enable); // Swap after testing

	initial begin		
		$dumpfile("decoder.vcd");
    	$dumpvars(0, testDecoder);
		$display("En A0 A1| O0 O1 O2 O3 | Expected Output");
		enable=0;addr0=0;addr1=0; #1000 
		$display("%b  %b  %b |  %b  %b  %b  %b | All false", enable, addr0, addr1, out0, out1, out2, out3);
		enable=0;addr0=1;addr1=0; #1000
		$display("%b  %b  %b |  %b  %b  %b  %b | All false", enable, addr0, addr1, out0, out1, out2, out3);
		enable=0;addr0=0;addr1=1; #1000 
		$display("%b  %b  %b |  %b  %b  %b  %b | All false", enable, addr0, addr1, out0, out1, out2, out3);
		enable=0;addr0=1;addr1=1; #1000 
		$display("%b  %b  %b |  %b  %b  %b  %b | All false", enable, addr0, addr1, out0, out1, out2, out3);
		enable=1;addr0=0;addr1=0; #1000 
		$display("%b  %b  %b |  %b  %b  %b  %b | O0 Only", enable, addr0, addr1, out0, out1, out2, out3);
		enable=1;addr0=1;addr1=0; #1000 
		$display("%b  %b  %b |  %b  %b  %b  %b | O1 Only", enable, addr0, addr1, out0, out1, out2, out3);
		enable=1;addr0=0;addr1=1; #1000 
		$display("%b  %b  %b |  %b  %b  %b  %b | O2 Only", enable, addr0, addr1, out0, out1, out2, out3);
		enable=1;addr0=1;addr1=1; #1000 
		$display("%b  %b  %b |  %b  %b  %b  %b | O3 Only", enable, addr0, addr1, out0, out1, out2, out3);


	end
endmodule
