# Analog to Digital Converter

The ADC is an electrical circuit, which converts data from Analog to Digital.

In this repository I have created a synthesizeable macromodel of the ADC circuit.
I've used the following diagram as a reference for my design:

<img width="493" height="608" alt="image" src="https://github.com/user-attachments/assets/0fc1ec79-54dc-4de9-b692-f6a38278c3a6" />

The circuit relies on comparators, and voltage deviders in order to calculate the voltage each bit represents.
An important characteristic of the ADC is it's resolution, which we can calculate with the following formula:

$$ \frac{V_{ref}}{2^n} $$

Where `V_ref` is the refernece voltage we give to the ADC, in this design that is 1.2 volts and `2^n` is the number of bits we want to display.
This formula gives us the step of the ADC. Which is a number that represents how many volts you need to go from one bit to the next.

In this design our step is 0.075V or 75mV. So the first comparator's threshold is 0-0.075V, the second one has a threshold of 0.076-0.150V, and so on.

A smaller reference voltage means that our step will be smaller, which also increases the accuracy of the conversion in the ADC.
Because the step is smaller, we can detect smaller changes in voltage giving us a higher resolution as well.

In our design we needed to create a 16 bit ADC, so `n` is equal to 4.

The circuit we have chosen has an additional benefit. Since all of the comparators are wired up in parallel, this means
that when we apply enough voltage to have the output of the (for example) 8th comparator go high, each comparator in the chain
below the 8th comparator will also go high. 

We can setup the decoder to use thermometer code. Thermometer code works, by assigning each a unique binary output to a 16-bit string 0s and 1s. Example below:

0000 0000 0000 0001 - Correspondes to a 4-bit 0000;
0000 0000 0000 0011 - Correspondes to a 4-bit 0001;
0000 0000 0000 0111 - Correspondes to a 4-bit 0010;
0000 0000 0000 1111 - Correspondes to a 4-bit 0011;
0000 0000 0001 1111 - Correspondes to a 4-bit 0100;

And so on for subsequent bits.

The code itself is simple. We use a generate block to instantiate 16 comparators. The comparator has the following port list:

``` verilog
input real positive_in,
input real negative_in,
output reg comparator_out
```

Inside the generate block, we give the positive input of the comparator our step (multiplied by the index of that comparator). 
This ensures each comparator's threshold is increased accordingly.

The comparator's output is then tied to a bus, where each comparator drives a singular bit of that bus.

We pass that bus to the decoder, and the output of that decoder is our digital output.
