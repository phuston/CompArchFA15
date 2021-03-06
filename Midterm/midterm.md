### CompArch Midterm FA 15
###### Patrick Huston | 11.08.15

#### Specification Document

This document aims to describe the core digital electronics behind the bike light. 

##### Inputs and Outputs
There is one input and one output to the bike light. A single button is used to control the output, a single light emitting diode (LED). When the button is pressed, the bike light cycles through its for operational modes, described in detail below.

#### Operational Modes
There are four operational modes to the bike light, depicted graphically as follows:

![System Diagram](/Midterm/img/system_diagram.png "Bike Light System Diagram")

1. Off
  In this mode, the bike light is off. The LED produces no light.
2. On
  In this mode, the bike light is on. The LED shines at normal brightness.
3. Blinking
  In this mode, the bike light cycles between high and low at a frequency of 4Hz. At this frequency, the bike light cycles through its states 4 times per second.
4. Dim
  In this mode, the bike light is on, but oscillates between high and low at a frequency of 128Hz. This frequency is above the human visible range, but will appear significantly dimmer than at full `ON` mode.

The bike light cycles through functionalities like this:

![FSM Diagram](/Midterm/img/fsm_flow.png "FSM Diagram")

#### System Block Diagram

Below is the high-level system schematic. The input signal from the button is conditioned (debounced using an input conditioner), which triggers the one-hot ring counter to cycle to the next mode. This mode, outputted as a 4-bit one-hot encoded state, is decoded by the one-hot multiplexor, which allows the correct signal to pass through based on the current state.

![System Diagram](/Midterm/img/systemdiagram.png "System Diagram")

Total Cost

| Subcomponent  | Cost Per      | # Used | Total |
|:-------------:|:-------------:|:------:|:-----:|
| Input Cond.   |    111        |    1   |  111  |
| Ring Counter  |    43         |    1   |  43   |
| One-hot MUX   |    17         |    1   |  17   |
| Freq Divider  |    169        |    1   |  169  |
| | | | Total: 340 | 

#### System Components

##### Input Conditioner
1. Specification

  The input conditioner takes in the input signal from the button, and sterilizes it to debounce the signal and ensure that a button press was indeed a button press. Additionally, instead of passing through the raw signal, this design implements a conditioner that passes only a positive edge indicator which lasts one clock cycle. This prevents the bike light from erratically cycling through all modes whenever the button is pressed and held down for more than one clock cycle.
  
  Assume that the button noise / bouncing decays within 1 millisecond, we will need to wait at least 2^5 clock cycles before the signal is determined to be stable. This is achieved using a binary counter that counts to 32, at which point the signal is allowed to pass through. 

2. Inputs 
  
  - `clk`: system-wide 32,768Hz clock
  - `noisysignal`: the input signal coming from the button

3. Outputs 

  - `posedge`: a one-clock length pulse indicating the conditioned button signal has a positive edge

4. Schematic

  ![Input Conditioner Schematic](/Midterm/img/inputconditioner.png "Input Conditioner Schematic")

5. Cost


| Subcomponent  | Cost Per      | # Used | Total |
|:-------------:|:-------------:|:------:|:-----:|
| PosEdge DFF   |    13         |    4   |  52   |
| 2 inp MUX     |    7          |    7   |  14   |
| 2 inp AND     |    3          |    2   |  6    |
| 5 inp AND     |    5+1=6      |    1   |  6    |
| 5 bit ADDER   |    30         |    1   |  30   |
| 2 inp XOR     |    3          |    1   |  3    |
| | | | Total: 111 | 



##### Full Bit Adder With Carryin
1. Specification

  The one-bit adder takes in two inputs, A and carryin, and computes their sum, with the additional carryout flag. It is used in the construction of a 5 bit adder that is used in the input conditioner.

2. Inputs
  
  - `carryin`: Carryin to the adder
  - `A`: Input 1-bit number

3. Outputs

  - `sum`: Result of sum
  - `carryout`: Carryout flag to be used when chaining adders together

4. Schematic

  ![Adder Schematic](/Midterm/img/adder.png "Adder Schematic")

5. Cost

| Subcomponent  | Cost Per      | # Used | Total |
|:-------------:|:-------------:|:------:|:-----:|
| 2 inp AND     |    2+1=3      |    1   |  3   |
| 2 inp OR      |    2+1=3      |    1   |  3    |
| | | | Total: 6 |

##### 5-Bit Adder
1. Specification

  The 5 bit adder is used in the input conditioner to wait for the noisy signal to settle on a stable value. It takes in a 5 bit number, adds 1 to it, and outputs that number. This is done by passing in a carryin of 1 to the first 1-bit adder (the least significant bit).

2. Inputs
  
  - `carryin`: Carryin to the adder
  - `A`: Input 1-bit number

3. Outputs

  - `sum`: Result of sum
  - `carryout`: Carryout flag to be used when chaining adders together

4. Schematic

  ![5 Bit Adder Schematic](/Midterm/img/5bitadder.png "5 Bit Adder Schematic")

5. Cost

| Subcomponent  | Cost Per      | # Used | Total |
|:-------------:|:-------------:|:------:|:-----:|
| 1 bit adder   |   6           |    5   |  30   |
| | | | Total: 30 |

##### One-Hot State Multiplexer
1. Specification

  The one-hot state multiplexer is used to decode the system state (4 bit one-hot encoded) outputted by the 4 bit ring counter. It takes all four bike signals as inputs, and passes the correct one through based on the system state.

2. Inputs
  - `State`: 4 bit one-hot encoded system state 
  - `sig_off`: Signal outputted for bike light in state 1000 - `OFF`
  - `sig_on`: Signal outputted for bike light in state 0100 - `ON`
  - `sig_blink`: Signal outputted for bike light in state 0010 - `BLINK`
  - `sig_dim`: Signal outputted for bike light in state 0001 - `DIM`

3. Outputs

  - `LED`: The signal passed to the LED to be shone out into the world. 

4. Schematic

  ![Multiplexer Schematic](/Midterm/img/multiplexer.png "Multiplexer Schematic")

5. Cost

| Subcomponent  | Cost Per      | # Used | Total |
|:-------------:|:-------------:|:------:|:-----:|
| 2 inp AND     |    2+1=3      |    4   |  12   |
| 4 inp OR      |    4+1=5      |    1   |  5    |
| | | | Total: 17 |


##### Frequency Division Unit
1. Specification

  The frequency division unit outputs two square waves at frequencies which will be used to create the `BLINK` and `DIM` functionalities of the bike light. This component leverages a T flip-flop (TFF) to divide an input frequency in half. Using many of these in series serves to divide the input clock frequency to 4Hz and 128Hz, for `BLINK` and `DIM` respectively.
  
  Here is a schematic for a T flip-flop:
  
  ![TFF Schematic](/Midterm/img/tff_schematic.gif "TFF Schematic")
  
  As noted above, chaining several T flip-flops in a row serves to divide the frequency by some amount 2^N, where N is the number of TFFs. To output 4Hz and 128Hz, we must divide the input 32768Hz by 2^13 and 2^8, which means we must use the output after 8 and 13 flip-flops to get the correct frequency square waves needed.

2. Inputs

  - `clk`: system-wide 32,768Hz clock

3. Outputs
  
  - `sig_dim`: 128Hz square wave representing `DIM` functionality
  - `sig_blink`: 4Hz square wave representing `BLINK` functionality

4. Schematic

  ![Frequency Divider Schematic](/Midterm/img/frequencydivider.png "Frequency Divider Schematic")
  
5. Cost

| Subcomponent  | Cost Per      | # Used | Total |
|:-------------:|:-------------:|:------:|:-----:|
| PosEdge DFF   |    13         |   13   |  12   |
| | | | Total: 169 |


