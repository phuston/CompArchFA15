## HW2 Results
###### Patrick Huston | 9.22.15

1. Decoder
  * Test Bench Results
  ```
    En A0 A1| O0 O1 O2 O3 | Expected Output
    0  0  0 |  0  0  0  0 | All false
    0  1  0 |  0  0  0  0 | All false
    0  0  1 |  0  0  0  0 | All false
    0  1  1 |  0  0  0  0 | All false
    1  0  0 |  1  0  0  0 | O0 Only
    1  1  0 |  0  1  0  0 | O1 Only
    1  0  1 |  0  0  1  0 | O2 Only
    1  1  1 |  0  0  0  1 | O3 Only
  ```
  * Waveforms
      ![decoder](/HW/HW2/img/decoder.png)
      
2. Multiplexer
  * Test Bench Results
  Note that while there are 2^6 = 64 possible permutations of inputs, only 4 are shown below. 
  This is because the first two inputs, A0 and A1, serve to 'select' which input will be matched
  in the output. For example, in the first row, A0 = 0 and A1 = 1 select input IN1 to be the output.
  Therefore, inputs IN1, IN2, and IN3 have no effect on the output of the module.
  ```
    A0 A1 IN0 IN1 IN2 IN3  |  OUT  | Expected Output
    0  0  1   x   x   x    |  1    |  Match in0
    0  1  x   x   1   x    |  1    |  Match in2
    1  0  x   1   x   x    |  1    |  Match in1
    1  1  x   x   x   1    |  1    |  Match in3
    0  0  0   x   x   x    |  0    |  Match in0
    0  1  x   x   0   x    |  0    |  Match in2
    1  0  x   0   x   x    |  0    |  Match in1
    1  1  x   x   x   0    |  0    |  Match in3

  ```
  * Waveforms
      ![decoder](/HW/HW2/img/multiplexer.png)
      
3. Adder
  * Test Bench Results
  ```
    A B Ci | S Co
    0 0 0  | 0 0
    0 0 1  | 1 0
    0 1 0  | 1 0
    0 1 1  | 0 1
    1 0 0  | 1 0
    1 0 1  | 0 1
    1 1 0  | 0 1
    1 1 1  | 1 1

  ```
  * Waveforms
      ![decoder](/HW/HW2/img/adder.png)
