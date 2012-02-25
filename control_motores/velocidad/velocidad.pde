/**
 * ControlP5 TextLabel
 * by andreas schlegel, 2009
 */
/**
*
*Declaración de objetos
*
**/

import controlP5.*;
import processing.serial.*;

Serial arduino; //Creamos un objeto tipo serial y lo llamamos arduino
ControlP5 controlP5;


/**
*
*Declaración de variables
*
**/
int velocidad = 0;
int speed = 0;

void setup() {
  size(400,400);
  frameRate(30);
  String portName = Serial.list()[0];
  arduino = new Serial(this, portName, 57600);
  
  
  controlP5 = new ControlP5(this);
  controlP5.setControlFont(new ControlFont(createFont("Georgia",20), 20));
  //Slider
  controlP5.addSlider("velocidad",-100,100,0,20,100,10,100);

}



void draw() {
  background(100);
  speed = int(map(velocidad,-100,100,0,180)); //mapeamos el valor de -100 a 100 a valores de servo de 0 a 180
  arduino.write(speed); // lo mandamos por el puerto serie
}

