// Sharp IR GP2Y0A41SK0F Distance Test
// http://tinkcore.com/sharp-ir-gp2y0a41-skf/

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

    if (distance >= 4 && distance <= 16){
        if (state == 1) {
            repeat += 1;
        }
        else {
            Serial.println(repeat);
            repeat = 0;
        }
        state = 1;
        digitalWrite(2, HIGH);
    }
    else {
        state = 0;
        digitalWrite(2, LOW);
    }
  //Serial.println(state);   // print the distance
}
