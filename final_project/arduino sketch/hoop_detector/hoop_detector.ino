// Basketball Hoop Detector - Final Project
// CPE 233 Winter 2018
// Professor Gerfen
// Russell Caletena, Josiah Pang, & Nathan Wang
// Sharp IR GP2Y0A41SK0F 
// Description: This sketch acts as a debouncer for the IR
//              sensor used in our hoop detector. The Arduino
//              takes the sensor as an input and look for a 
//              confirmed "shot," when is then output as a
//              digital signal. 

#define sensor A0 // Sharp IR GP2Y0A41SK0F (4-30cm, analog)
int state = 0; // Current state
int outPin = 2;
int repeat = 0;

void setup() {
    Serial.begin(9600); // start the serial port
    pinMode(outPin, OUTPUT);
}

void loop() {

    // 5v
    float volts = analogRead(sensor)*0.0048828125;  // value from sensor * (5/1024)
    int distance = 13*pow(volts, -1); // worked out from datasheet graph
    //delay(100); // slow down serial port

    //Serial.println(distance);

    // Make sure basketball falls inside the hoop
    // (Check distance range)
    if (distance >= 4 && distance <= 16){
        // Make sure a basketball is triggering the sensor
        // (Check time range)
        if (state == 1) { // Sensor still triggered on next clock
            repeat += 1;
            
            // Output only when confirmed hoop
            if (repeat >= 87 && repeat <= 747) {
                Serial.println("SCORE!");
                digitalWrite(outPin, HIGH);
                delay(1000); // Don't listen for a second after confirmed shot
    }
        }
        else {
            //Serial.println(repeat);
            repeat = 0;
        }
        state = 1;
    }
    else {
        state = 0;
        digitalWrite(outPin, LOW);
    }

    
  //Serial.println(state);   // print the distance
}
