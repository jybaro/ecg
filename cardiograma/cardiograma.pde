/*
Comments

The Creative Commons Attribution Share-Alike license allows re-distribution and re-use of a licensed work on the conditions that the creator is appropriately credited and that any derivative work is made available under “the same, similar or a compatible license”.

How to apply

You can use the CC license chooser.

Alternatively, include a link to, or a full copy of the license you use, and something like the following:

This work is licensed under a Creative Commons Attribution Share-Alike [version number] License.



*/
import processing.serial.*;
import spacebrew.*;
Serial myPort;        // The serial port
int xPos = 1;         // horizontal position of the graph
float height_old = 0;
float height_new = 0;
float inByte = 0;
String server="sandbox.spacebrew.cc";
String name="ECG";
String description ="Client that sends and receives range messages. Range values go from 0 to 1023.";
String send;
Spacebrew sb;

void setup () {
  // set the window size:
  size(1000, 400);        

  // List all the available serial ports
  println(Serial.list());
  // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[0], 9600);
  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');
  // set inital background:
  background(0xff);
  
  sb = new Spacebrew( this );

  // declare your publishers
  sb.addPublish( "ECG_UIO", "string", send); 
   sb.connect(server, name, description );
}


void draw () {
  // everything happens in the serialEvent()
}


void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);

    // If leads off detection is true notify with blue line
    if (inString.equals("!")) { 
      stroke(0, 0, 0xff); //Set stroke to blue ( R, G, B)
      inByte = 512;  // middle of the ADC range (Flat Line)
    }
    // If the data is good let it through
    else {
      stroke(0xff, 0, 0); //Set stroke to red ( R, G, B)
      inByte = float(inString); 
     }
     
     //Map and draw the line for new data point
     inByte = map(inByte, 0, 1023, 0, height);
     height_new = height - inByte; 
     line(xPos - 1, height_old, xPos, height_new);
     height_old = height_new;
     send= str(height_new);
     sb.send("ECG_UIO",send);
      // at the edge of the screen, go back to the beginning:
      if (xPos >= width) {
        xPos = 0;
        background(0xff);
      } 
      else {
        // increment the horizontal position:
        xPos++;
      }
    
  }
}
