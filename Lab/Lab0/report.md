## Lab 0 Results
##### Patrick Huston, Isaac Getto, Kai Levy

1. Waveforms
  ![waveform](/Lab/Lab0/img/fulladderwave.png)
  
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
  
    We ran into zero test case failures.
    
4. FPGA Testing
    Below are the 4 steps involved in adding two numbers on the FPGA board. In this case, we were adding 7 and 1, which resulted in an overflow.

    ![waveform](/Lab/Lab0/img/Step0.jpg)
    ![waveform](/Lab/Lab0/img/Step1.jpg)
    ![waveform](/Lab/Lab0/img/Step2.jpg)
    ![waveform](/Lab/Lab0/img/Step3.jpg)
    
