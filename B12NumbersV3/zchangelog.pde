/*
    B12NumbersV3
    Beta version of a clock in base 12.
    by Nayan Sawyer
    started Mar 2022
    version 1.0.0.1 May 20 2022
    
    Characters are a variation of Kaktovik Inupiaq numerals
    reversed and in base 12 instead of 20. I take no credit 
    for the design.
    Includes method relay code by Quark - see https://forum.processing.org/two/discussion/13093/how-to-call-function-by-string-content.html
    for more details. Also includes the library exp4j for evaluating mathematical expressions.
    
    // DONE put everything back into seperate tabs
    // DONE fully document everything
    // TODO add throwing exceptions to all contructors
    // TODO add error message to calculator rather than having it do nothing when it doesn't work
    // TODO add helper function to B12Expression.convert() so that conversion handles float/int determination on its own
    // TODO refactor the base code to have ints and floats seperate from the digit and display code, and use a single object to convert a number to digits
    // MAYBE add additional operations like power, log, and trig functions
    // MAYBE add other button highlight options like transparency
    
    BUGTRACKER
    - something fishy with button highlight colors
    - lazy positioning with ClockApp. Should move Stopwatch too
    - B12Float and B12Int return their digits in opposite orders
    - B12Float still uses mode DECIMAL
    - Time48 does not check its inputs in some constructors
    - renderPriority in Button is only half implemented
    - negative signs when timer ends (not urgent)
    - B12Digit.setValue() does not check input and only accepts ints
    - B12Digit.getValue() returns int not byte
    
    changelog 1.0.0.1
    - Some bug fixes, made more things private, and fixed 
    timer
    
    changelog 1.0.0.0
    - Finished project to fully working state. Still lots of 
    bugs to squash, and structural problems with the base 
    code of the gui elements. But I don't have time to perfect
    all of it at the moment. I will probably come back to it
    in the future.
    Put everything back into seperate files
    Finished documentation for final project submission
    
    changelog 0.2.1.3
    - Finished timer. All clock apps are now complete. Some 
    assembly required :P
    
    changelog 0.2.1.2
    - Finished Stopwatch
    
    changelog 0.2.1.1
    - Finished clock implementation
    
    changelog 0.2.1.0
    - Changes to the base code and the beginning of the clock
    applications. File condensing (will be reversed)
    
    changelog 0.2.0.0
    - Evaluating expressions has been fully implemented using
    exp4j. Various things have been added to the base classes
    to support this.
    
    changelog 0.1.5.8
    - Tweaks for first beta release for class presentation
    
    changelog 0.1.5.7
    - Presentation display setup done.
    
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
