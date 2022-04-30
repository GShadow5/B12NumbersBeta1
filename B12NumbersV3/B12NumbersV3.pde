/*
    B12NumbersV3
    Beta version of a clock in base 12.
    by Nayan Sawyer
    started Mar 2022
    version 0.1.3 April 29 2022
    
    Characters are a variation of Kaktovik Inupiaq numerals
    reversed and in base 12 instead of 20. I take no credit 
    for the design.
    
    changelog 0.1.3 
    - Deprecated B12Char by rolling it's code into B12Digit. 
    Makes for easier to handle arrays, and will hopefully 
    make implementing the math functionality much easier.
    It appears that only Clock may need true refactoring to 
    make the most of this change. B12Int and B12Float seem 
    to be fine with simply swithing out the reference.
*/

public static int DECIMAL = 65;

Clock clock; //<>//
B12Digit p;
B12Digit t;

void setup(){
  size(400,400);
  clock = new Clock(new STime48());
  println("waiting");
  p = new B12Digit('+');
  t = new B12Digit('/');
}

void draw(){
  background(196);
  translate(width/2,height/2);
  scale(2);
  point(0,0);
  clock.display();
  //p.display();
  t.display();
}

void mouseClicked(){
  clock.setTime(new Time48(16,0,0));
  
  // Decide which element is on top at mouse position (maybe by state?)
  method("");
  
}
