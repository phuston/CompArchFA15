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
1. The input conditioner takes in the input signal from the button, and sterilizes it to debounce the signal and ensure that a button press was indeed a button press. 
2. Inputs - noisysignal: the input signal coming from the button
3. Outputs - conditioned: the conditioned (debounced) button signal that will serve as an input to the one-hot FSM
4. Schematic
5. Size
