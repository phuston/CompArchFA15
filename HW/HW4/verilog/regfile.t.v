//------------------------------------------------------------------------------
// Test harness validates hw4testbench by connecting it to various functional 
// or broken register files, and verifying that it correctly identifies each
//------------------------------------------------------------------------------

module hw4testbenchharness();

  wire[31:0]  ReadData1;  // Data from first register read
  wire[31:0]  ReadData2;  // Data from second register read
  wire[31:0]  WriteData;  // Data to write to register
  wire[4:0] ReadRegister1;  // Address of first register to read
  wire[4:0] ReadRegister2;  // Address of second register to read
  wire[4:0] WriteRegister;  // Address of register to write
  wire    RegWrite; // Enable writing of register when High
  wire    Clk;    // Clock (Positive Edge Triggered)

  reg   begintest;  // Set High to begin testing register file
  wire    endtest;  // Set High to end testing register file
  wire    dutpassed;  // Indicates whether register file passed tests

  // Instantiate the register file being tested.  DUT = Device Under Test
  regfile DUT
  (
    .ReadData1(ReadData1),
    .ReadData2(ReadData2),
    .WriteData(WriteData),
    .ReadRegister1(ReadRegister1),
    .ReadRegister2(ReadRegister2),
    .WriteRegister(WriteRegister),
    .RegWrite(RegWrite),
    .Clk(Clk)
  );

  // Instantiate test bench to test the DUT
  hw4testbench tester
  (
    .begintest(begintest),
    .endtest(endtest), 
    .dutpassed(dutpassed),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2),
    .WriteData(WriteData), 
    .ReadRegister1(ReadRegister1), 
    .ReadRegister2(ReadRegister2),
    .WriteRegister(WriteRegister),
    .RegWrite(RegWrite), 
    .Clk(Clk)
  );

  // Test harness asserts 'begintest' for 1000 time steps, starting at time 10
  initial begin
    begintest=0;
    #10;
    begintest=1;
    #1000;
  end

  // Display test results ('dutpassed' signal) once 'endtest' goes high
  always @(posedge endtest) begin
    $display("DUT passed?: %b", dutpassed);
  end

endmodule


//------------------------------------------------------------------------------
// Your HW4 test bench
//   Generates signals to drive register file and passes them back up one
//   layer to the test harness. This lets us plug in various working and
//   broken register files to test.
//
//   Once 'begintest' is asserted, begin testing the register file.
//   Once your test is conclusive, set 'dutpassed' appropriately and then
//   raise 'endtest'.
//------------------------------------------------------------------------------

module hw4testbench
(
// Test bench driver signal connections
input       begintest,  // Triggers start of testing
output reg    endtest,  // Raise once test completes
output reg    dutpassed,  // Signal test result

// Register File DUT connections
input[31:0]   ReadData1,
input[31:0]   ReadData2,
output reg[31:0]  WriteData,
output reg[4:0]   ReadRegister1,
output reg[4:0]   ReadRegister2,
output reg[4:0]   WriteRegister,
output reg    RegWrite,
output reg    Clk
);

  // Initialize register driver signals
  initial begin
    WriteData=32'd0;
    ReadRegister1=5'd0;
    ReadRegister2=5'd0;
    WriteRegister=5'd0;
    RegWrite=0;
    Clk=0;
  end

  integer index;
  integer firstRead;
  integer secondRead;

  // Once 'begintest' is asserted, start running test cases
  always @(posedge begintest) begin
    endtest = 0;
    dutpassed = 1;
    #10

  // Test Case 1: 
  //   Write '42' to register 2, verify with Read Ports 1 and 2
  //   (Passes because example register file is hardwired to return 42)
  WriteRegister = 5'd2;
  WriteData = 32'd42;
  RegWrite = 1;
  ReadRegister1 = 5'd2;
  ReadRegister2 = 5'd2;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse

  // Verify expectations and report test result
  if((ReadData1 == 42) && (ReadData2 == 42)) 
    begin
      $display("Test Case 1 -- PASS");
    end
  else
    begin
      dutpassed = 0;  // Set to 'false' on failure
      $display("Read data -- %b", ReadData1);
      $display("Test Case 1 -- FAIL");
    end

  // Test Case 2: 
  //   Write '15' to register 2, verify with Read Ports 1 and 2
  //   (Fails with example register file, but should pass with yours)
  WriteRegister = 5'd2;
  WriteData = 32'd15;
  RegWrite = 1;
  ReadRegister1 = 5'd2;
  ReadRegister2 = 5'd2;
  #5 Clk=1; #5 Clk=0;

  if((ReadData1 == 15) && (ReadData2 == 15)) 
    begin
      $display("Test Case 2 -- PASS");
    end
  else
    begin
      dutpassed = 0;
      $display("Read data: %b", ReadData1);
      $display("Test Case 2 -- FAIL");
    end

  // Test Case 3:
  //    Check to see if Write Enable is broken
  //

  WriteRegister = 5'd2;
  WriteData = 32'd15;
  RegWrite = 1;
  ReadRegister1 = 5'd2;
  ReadRegister2 = 5'd2;
  #5 Clk=1; #5 Clk=0;

  if((ReadData1 != 15) || (ReadData2 != 15))
    begin
      dutpassed = 0;
      $display("Write Enable -- BROKEN");
    end

  WriteData = 32'd20;
  RegWrite = 0;
  #5 Clk=1; #5 Clk=0;

  if((ReadData1 != 15) || (ReadData2 != 15))
    begin
      dutpassed = 0;
      $display("Write Enable - -- BROKEN");
    end


  // Test Case 4 -- Decoder is broken - all registers are written to

  // Set all register values to 0 
  for (index = 1; index < 32; index = index + 1) begin
    WriteRegister = index;
    WriteData = 32'd0;
    RegWrite = 1;
    ReadRegister1 = 5'd2;
    ReadRegister2 = 5'd2;
    #5 Clk=1; #5 Clk=0;
  end

  // Set one register to arbitrary value
  WriteRegister = 5'd1;
  WriteData = 32'd15;
  RegWrite = 1;
  ReadRegister1 = 5'd1;
  ReadRegister2 = 5'd1;
  #5 Clk=1; #5 Clk=1;

  if(ReadData1 != 15)
    begin
      dutpassed = 0;
      $display("Decoder -- BROKEN");
    end

  for (index = 2; dutpassed && index < 32; index = index + 1) begin
    WriteRegister = 5'd0;
    WriteData = 32'd0;
    RegWrite = 0;
    ReadRegister1 = index;
    #5 Clk=1; #5 Clk=0;

    if(ReadData1 != 0)
      begin
        dutpassed = 0;
        $display("Decoder -- BROKEN");
      end
  end

  // Test Case 5 -- Zero Register is just regular register

  // Make sure register is already zero
  RegWrite = 0;
  ReadRegister1 = 5'd0;
  #5 Clk=1; #5 Clk=0;

  if(ReadData1 != 0) begin
    dutpassed = 0;
    $display("Zero -- BROKEN");
  end

  // Attempt to write another value to ZeroRegister
  RegWrite = 1;
  WriteRegister = 5'd0;
  WriteData = 32'd25;
  ReadRegister1 = 5'd0;
  #5 Clk=1; #5 Clk=0;

  if(ReadData1 != 0) begin
    dutpassed = 0;
    $display("Zero -- BROKEN");
  end

  // Test Case 6 -- Port 2 Broken, always reads reg 17

  // Set all register values to 0 
  for (index = 1; index < 32; index = index + 1) begin
    WriteRegister = index;
    WriteData = 32'd0;
    RegWrite = 1;
    ReadRegister1 = 5'd2;
    ReadRegister2 = 5'd2;
    #5 Clk=1; #5 Clk=0;
  end

  // Set register 17 to known value
  RegWrite = 1;
  WriteRegister = 32'd17;
  WriteData = 32'd15;
  #5 Clk=1; #5 Clk=0;

  // Check all registers but 17 to see if they hold value 15
  for (index = 1; index < 32; index = index + 1) begin
    ReadRegister2 = index;
    RegWrite = 0;
    #5 Clk=1; #5 Clk=0;

    if(index != 32'd17 && ReadData2 == 32'd15) begin
      dutpassed = 0;
      $display("Port2 -- BROKEN");
    end
  end

  if (dutpassed)
    begin
      $display("Test Case Perfect -- PASS");
    end
  else
    begin
      $display("Test Case Perfect -- FAIL");
    end

  // All done!  Wait a moment and signal test completion.
  #5
  endtest = 1;
end

endmodule