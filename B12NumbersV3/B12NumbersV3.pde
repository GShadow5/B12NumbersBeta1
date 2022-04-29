/*
    B12NumbersV3
    Beta version of a clock in base 12.
    by Nayan Sawyer
    started Mar 2022
    version 0.1.2 April 4 2022
    
    Characters are a variation of Kaktovik Inupiaq numerals
    reversed and in base 12 instead of 20. I take no credit 
    for the design.
*/

public static int DECIMAL = 65;

Clock clock;

void setup(){
  size(400,400);
  clock = new Clock(new STime48());
  println("waiting");
}

void draw(){
  background(196);
  translate(width/2,height/2);
  scale(1);
  point(0,0);
  clock.display();
}

void mouseClicked(){
  clock.setTime(new Time48(16,0,0));
}
