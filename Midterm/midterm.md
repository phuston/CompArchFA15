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
  In this mode, the bike light cycles between 'on' and 'off' at a frequency of __Hz
4. Dim
  In this mode, the bike light is on, but operates at a lower brightness than in normal 'on' mode.

The bike light cycles through functionalities like this:

![FSM Diagram](/Midterm/img/fsm_flow.png "FSM Diagram")

#### System Block Diagram

Block diagram will go here.

#### System Components

##### Input Conditioner
1. Specification

The input conditioner takes in the input signal from the button, and sterilizes it to debounce the signal and ensure that a button press was indeed a button press. 

2. Inputs 

  - `noisysignal`: the input signal coming from the button

3. Outputs 

  - `conditioned`: the conditioned (debounced) button signal that will serve as an input to the one-hot FSM

4. Schematic
5. Cost

##### N-Ring Counter
1. Specification

The n-ring counter serves the purpose of keeping track of which mode the bike light is in. It does this by holding this information in a one-hot encoded state. (ex. 1000 is ON, 0100 is OFF, 0010 is BLINK, 0001 is DIM)

2. Inputs

  - `clk`: clocked input used to determine when to shift the one-hot encoded state
  - `Enable`: controls whether the one-hot encoded signal will shift on a positive clock edge

3. Outputs
  
  - `Q[3:0]` - One-hot encoded output representing the state of the bike light
  
4. Schematic
5. Cost

##### Up-Counter
1. Specification

The up-counter component is used to facilitate the timing of the `BLINK` and `DIM` functionalities of the bike light. Functionally, it is a binary counter that resets when it reaches the limit given the number of bits. Applying simple logic to the output bits will facilitate the process of timing the LED output.

2. Inputs

  - `clk`: system-wide clock used to dtermine when to increment the count

3. Outputs
  
  - `Out[11:0]`: state of the counter - a binary number

4. Schematic
5. Cost
  N D flip-flops + N XOR Gates + 1 AND Gate


##### One-Hot State 'Decoder'
1. Specification

The one-hot state 'decoder' is used to make sense of the system state outputted by the N-stage ring counter. It takes all four bike signals as inputs, and passes the correct one through based on the system state.

2. Inputs

  - `SignalA`: Signal outputted for bike light in state 1000 - `ON`
  - `SignalB`: Signal outputted for bike light in state 0100 - `OFF`
  - `SignalC`: Signal outputted for bike light in state 0010 - `BLINK`
  - `SignalD`: Signal outputted for bike light in state 0001 - `DIM`

3. Outputs

  - `LED`: The signal passed to the LED to be shone out into the world. 

#### Blink Logic Unit
1. Specification

The blink logic unit (henceforth referred to as BLU) applies a simple logic to the output of the binary up-counter to output an oscillating signal at TODO Hz.
  
4. Schematic
5. Cost


#### Dim Logic Unit
1. Specification

The blink logic unit (henceforth referred to as DLU) applies a simple logic to the output of the binary up-counter to output an oscillating signal at TODO Hz. This signal, when outputted to the LED, is a PWM that makes the LED appear 'dimmer'.
  
4. Schematic
5. Cost
