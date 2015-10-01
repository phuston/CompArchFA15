## Lab 0 Results
##### Patrick Huston, Isaac Getto, Kai Levy

1. Waveforms
  
  ![waveform](/Lab/Lab0/img/fulladderwave.png)
  
  The operations that result in carryout and overflow (e.g. -4 + -5) take considerably longer. That is because these operations use more gates, and each additional gate used adds to the calculation time. 

2. Test Strategy

  To test our adder, we chose 4 test additions from 4 different categories
    * Regular addition
    * Addition that results in only a carry out
    * Addition that results in only overflow
    * Addition that results in both a carry out and overflow
    
  Following are our tests:
  
  Regular | Carry Out | Overflow | CO + OF
  -------:|:---------:|:--------:|:-------
  0 + 0   | -1 + -1   |  5 + 3   | -5 + -4
  0 + 1   | -1 + 7    |  7 + 7   | -6 + -3
  -6 + 5  | -4 + 6    |  4 + 7   | -5 + -8
  -4 + 4  | -6 + 7    |  7 + 1   | -8 + -1
  
  We approached the testing with this strategy to cover as wide a variety of outputs as possible (covering 4 cases for each of the possible output domains).
  
  
3. Test Case Failures
  
    We ran into zero test case failures because we were very deliberate in our design. To create a flawless system, we utilized our 1-bit full adders from the previous assignment (which were already verified to function correctly), and strung four of them together, ensuring that the implementation was correct by running through some test cases on the whiteboard. Next, we referenced the lecture slides to determine when an overflow occurs, and implemented this feature before going through our first full testing run. Once we worked out the verilog kinks, we found that the calculator worked as expected. 
    
4. FPGA Testing
    Below are the 4 steps involved in adding two numbers on the FPGA board. In this case, we were adding 7 and 1, which resulted in an overflow.

    <img src="/Lab/Lab0/img/Step0.jpg" alt="waveform" width="100"/>
    Here we set the first input to 7 (0111)
    ![waveform](/Lab/Lab0/img/Step1.jpg =250x)
    Here we set the second input to 1 (0001)
    ![waveform](/Lab/Lab0/img/Step2.jpg =250x)
    Here we view the sum, -8 (1000)
    ![waveform](/Lab/Lab0/img/Step3.jpg =250x)
    Here we view the carryout (0) and overflow (1), which shows that our result is invalid.
    
5. Summary Statistics
    * Total On-Chip Power -- 0.113 W
    * Junction Temperature -- 26.3 Deg. C
    * Thermal Margin -- 58.7 Deg. C

    ![summstats](/Lab/Lab0/img/resources.png)
