# B12NumbersBeta1
The characters are designed after the ingenious Kaktovik Iñupiaq numerals, which were created by a group of middle schoolers in Kaktovik Alaska, to represent the base 20 counting system in Iñupiaq, their Inuit language.

I take no credit for the design of the characters. I have merely co-opted the design for the development of this project because it is elegant and convenient to use for compound base number systems, and looks nothing like the Arabic numeral system.

The project is currently in the stage where I am building all of the component parts, so the code does not yet do much when run.

The time system is now complete with robust syncing and offset features. The base 12 time system works slightly differently from our regular base 60 time.

    Hours are still 24, but because it's in base 12, 10 is noon.
    Minutes: there are now 48 minutes in an hour
    Seconds: there are now 48 seconds in a minute

The number system is such that horizontal ticks on top represent multiples of four, and vertical ticks represent multiples of one. Decimal 11 is 2 horizontal ticks, and 3 vertical ticks. However, since the project is in an alpha state, I will not go into great detail at this point.

The calculator input system is now working. For an early beta demo see [releases](https://github.com/GShadow5/B12NumbersBeta1/releases)
