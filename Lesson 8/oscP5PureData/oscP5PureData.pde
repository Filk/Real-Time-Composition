
import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress myRemoteLocation;

float valorDoPureData;

void setup() {
  size(400,400);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,3000);
  
  myRemoteLocation = new NetAddress("127.0.0.1",4000);
}


void draw() 
{
  background(0);  
  fill(255);
  ellipse(width/2,height/2, valorDoPureData, valorDoPureData);
}

void mousePressed() {
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessage = new OscMessage("/toPureData");
  myMessage.add((int)random(300,800)); /* add an int to the osc message */
  myMessage.add("ola"); /* add an int to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation); 
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) 
{
  if(theOscMessage.checkAddrPattern("/fromPureData")==true) 
  {
    /* check if the typetag is the right one. */
    if(theOscMessage.checkTypetag("f")) 
    {
      /* parse theOscMessage and extract the values from the osc message arguments. */
      valorDoPureData = theOscMessage.get(0).floatValue();  
    }  
  }
}