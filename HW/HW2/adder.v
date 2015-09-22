`define AND and #50
`define OR or #50
`define NOT not #50
`define XOR xor #50

module behavioralFullAdder(sum, carryout, a, b, carryin);
	output sum, carryout;
	input a, b, carryin;
	assign {carryout, sum}=a+b+carryin;
endmodule

module structuralFullAdder(sum, carryout, a, b, carryin);
	output sum, carryout;
	input a, b, carryin;

	// Wires for out
	wire bXORc, nbXORc, na, nb, nc, aANDbXORc, aANDnbXORc;

	// Wires for carryout
	wire bANDc, aANDc, aANDb;

	`NOT n1(na, a);
	`NOT n2(nb, b);

	// Out logic
	`XOR x1(bXORc, b, carryin);
	`NOT nx1(nbXORc, bXORc);

	`AND a1(aANDbXORc, na, bXORc);
	`AND a2(aANDnbXORc, a, nbXORc);

	`OR o1(sum, aANDbXORc, aANDnbXORc);

	// Carryout logic
	`AND a3(bANDc, b, carryin);
	`AND a4(aANDc, a, carryin);
	`AND a5(aANDb, a, b);

	`OR o2(carryout, bANDc, aANDc, aANDb);
endmodule

module testFullAdder;
	reg a, b, carryin;
	wire sum, carryout;
	// behavioralFullAdder adder (sum, carryout, a, b, carryin);
	structuralFullAdder adder (sum, carryout, a, b, carryin);

	initial begin
        $dumpfile("adder.vcd");
        $dumpvars(0, testFullAdder);

	  	$display("A B Ci | S Co");
		a=0;b=0;carryin=0; #1000 
		$display("%b %b %b  | %b %b", a, b, carryin, sum, carryout);
		a=0;b=0;carryin=1; #1000 
		$display("%b %b %b  | %b %b", a, b, carryin, sum, carryout);
		a=0;b=1;carryin=0; #1000 
		$display("%b %b %b  | %b %b", a, b, carryin, sum, carryout);
		a=0;b=1;carryin=1; #1000 
		$display("%b %b %b  | %b %b", a, b, carryin, sum, carryout);
		a=1;b=0;carryin=0; #1000 
		$display("%b %b %b  | %b %b", a, b, carryin, sum, carryout);
		a=1;b=0;carryin=1; #1000 
		$display("%b %b %b  | %b %b", a, b, carryin, sum, carryout);
		a=1;b=1;carryin=0; #1000 
		$display("%b %b %b  | %b %b", a, b, carryin, sum, carryout);
		a=1;b=1;carryin=1; #1000 
		$display("%b %b %b  | %b %b", a, b, carryin, sum, carryout);
	end
endmodule
 