`define AND and #50
`define OR or #50
`define NOT not #50

module behavioralMultiplexer(out, address0,address1, in0,in1,in2,in3);
output out;
input address0, address1;
input in0, in1, in2, in3;
wire[3:0] inputs = {in3, in2, in1, in0};
wire[1:0] address = {address1, address0};
assign out = inputs[address];
endmodule

module structuralMultiplexer(out, address0,address1, in0,in1,in2,in3);
output out;
input address0, address1;
input in0, in1, in2, in3;
wire naddress0, naddress1, nin0, nin1, nin2, nin3;
wire na0ANDna1, a0ANDna1, na0ANDa1, a0ANDa1;
wire s0, s1, s2, s3;

`NOT n1(naddress0, address0); 
`NOT n2(naddress1, address1);
`NOT n3(nin0, in0);
`NOT n4(nin1, in1);
`NOT n5(nin2, in2);
`NOT n6(nin3, in3);

`AND a1(s0, naddress0, naddress1, in0);
`AND a2(s1, address0, naddress1, in1);
`AND a3(s2, naddress0, address1, in2);
`AND a4(s3, address0, address1, in3);

`OR or1(out, s0, s1, s2, s3);
endmodule


module testMultiplexer;
    reg addr0, addr1;
    reg in0, in1, in2, in3;
    wire out;

    // behavioralMultiplexer decoder (out,addr0,addr1,in0,in1,in2,in3);
    structuralMultiplexer DUT (out,addr0,addr1,in0,in1,in2,in3);

    initial begin
        $dumpfile("multiplexer.vcd");
        $dumpvars(0, testMultiplexer);

        $display("A0 A1 IN0 IN1 IN2 IN3  |  OUT  | Expected Output");
        addr0=0;addr1=0;in0=1;in1=0;in2=0;in3=0; #1000 
        $display("%b  %b  %b   %b   %b   %b    |  %b    |  %s", addr0, addr1, in0, in1, in2, in3, out, "Match in0");
        addr0=0;addr1=1;in0=0;in1=0;in2=1;in3=0; #1000 
        $display("%b  %b  %b   %b   %b   %b    |  %b    |  %s", addr0, addr1, in0, in1, in2, in3, out, "Match in2");
        addr0=1;addr1=0;in0=0;in1=1;in2=0;in3=0; #1000 
        $display("%b  %b  %b   %b   %b   %b    |  %b    |  %s", addr0, addr1, in0, in1, in2, in3, out, "Match in1");
        addr0=1;addr1=1;in0=0;in1=0;in2=0;in3=1; #1000 
        $display("%b  %b  %b   %b   %b   %b    |  %b    |  %s", addr0, addr1, in0, in1, in2, in3, out, "Match in3");
        addr0=0;addr1=0;in0=0;in1=0;in2=0;in3=0; #1000 
        $display("%b  %b  %b   %b   %b   %b    |  %b    |  %s", addr0, addr1, in0, in1, in2, in3, out, "Match in0");
        addr0=0;addr1=1;in0=0;in1=0;in2=0;in3=0; #1000 
        $display("%b  %b  %b   %b   %b   %b    |  %b    |  %s", addr0, addr1, in0, in1, in2, in3, out, "Match in2");
        addr0=1;addr1=0;in0=0;in1=0;in2=0;in3=0; #1000 
        $display("%b  %b  %b   %b   %b   %b    |  %b    |  %s", addr0, addr1, in0, in1, in2, in3, out, "Match in1");
        addr0=1;addr1=1;in0=0;in1=0;in2=0;in3=0; #1000 
        $display("%b  %b  %b   %b   %b   %b    |  %b    |  %s", addr0, addr1, in0, in1, in2, in3, out, "Match in3");
    end 
endmodule
