/*
    B12NumbersV3
    Beta version of a clock in base 12.
    by Nayan Sawyer
    started Mar 2022
    version 0.1.5.6 April 30 2022
    
    Characters are a variation of Kaktovik Inupiaq numerals
    reversed and in base 12 instead of 20. I take no credit 
    for the design.
    Includes method relay code be Quark - see https://forum.processing.org/two/discussion/13093/how-to-call-function-by-string-content.html
    for more details.
    
    // TODO add actual math evaluation to B12Expression
    // TODO finalize calculator design
    // MAYBE start clock widget structure
    // MAYBE add additional operations like power, log, and trig functions
    
    changelog 0.1.5.6
    - MathPad complete. Changed internal button mouseOver code
    from MethodRelay to switch statement. Added delete 
    functionality to B12Expression. Improved but did not 
    finish button text features.
    
    changelog 0.1.5.5
    - finished parsing input array to string in B12Expression.
    Added parenthesis chars to B12Digit and changed 0 char.
    
    changelog 0.1.5.4
    - updated buttons to take minimal creation arguments, and
    require the use of setters to change position, dimensions,
    etc. Changed how mathpad sets the render position of 
    buttons to allow mathPad position to be other than 0,0.
    Added parsing B12Digit array to string expression in base 
    12 to B12Expression.
    
    changelog 0.1.5.3
    - restricted button presses to left mouse button only.
    Updated button highlight color functionality. Updated all
    classes to return themselves from their setters. This 
    allows chaining set methods on one line.
    
    changelog 0.1.5.2
    - major changes to mouse handling, and MethodRelay now
    uses weak references rather than strong references so
    that there will no longer be the possibility of dangling
    objects. This allows gc to collect dead buttons, Yay!
    
    changelog 0.1.5.0
    - Quite a few changes by this point. The readme has been 
    fixed, the button class has gone through many revisions
    and now allows dynamic calls defined at object creation,
    the MathPad now works and inputs B12Digits into a 
    B12Expression, MathDisplay now works and displays the 
    contents of a B12Expression, and many miscellaneous bugs
    and inefficiencies have been fixed. I still need to get 
    better at version numbering, but it is slowly getting 
    better.
    
    changelog 0.1.4.0
    - Added MethodRelay code from Quark. Some fixes and 
    changes as well. Condesed some things into fewer files 
    for so the ide is easier to use, but they will be moved 
    back into their own files as version 1.0 approaches. 
    Everything is prep for adding gui elements (MethodRelay 
    included)
    
    changelog 0.1.3 
    - Deprecated B12Char by rolling it's code into B12Digit. 
    Makes for easier to handle arrays, and will hopefully 
    make implementing the math functionality much easier.
    It appears that only Clock may need true refactoring to 
    make the most of this change. B12Int and B12Float seem 
    to be fine with simply swithing out the reference.
*/
