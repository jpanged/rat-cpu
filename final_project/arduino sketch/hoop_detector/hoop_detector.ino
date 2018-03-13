// Basketball Hoop Detector - Final Project
// CPE 233 Winter 2018
// Professor Gerfen
// Russell Caletena, Josiah Pang, & Nathan Wang
// Sharp IR GP2Y0A41SK0F
// Description: This sketch acts as a debouncer for the IR
//              sensor used in our hoop detector. The Arduino
//              takes the sensor as an input and look for a
//              confirmed "shot," when is then output as a
//              digital signal to the Basys 3 as well as a
//              sound to a speaker.

// Libraries ===================================================================
#include "pitches.h" //Import pitches file for different tones
#define sensor A0 // Sharp IR GP2Y0A41SK0F (4-30cm, analog)

// Initialize variables and signals ============================================
int outPin = 2;
int led = 3;
int state = 0; // Current state
int repeat = 0; // Keeps track of time

// Music stuff =================================================================
// Notes in the melody:
int melody[] = {
  NOTE_C4, NOTE_G3, NOTE_G3, NOTE_A3, NOTE_G3, 0, NOTE_B3, NOTE_C4
};

// Note durations: 4 = quarter note, 8 = eighth note, etc.:
int noteDurations[] = {
  4, 8, 8, 4, 4, 4, 4, 4
};
// =============================================================================
// Setup =======================================================================
void setup() {
    Serial.begin(9600); // start the serial port
    pinMode(outPin, OUTPUT);
    pinMode(led, OUTPUT);
}
// Loop ========================================================================
void loop() {

    // Sensor math
    float volts = analogRead(sensor)*0.0048828125;  // value from sensor * (5/1024)
    int distance = 13*pow(volts, -1); // worked out from datasheet graph

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
                // Play coin sound =============================================
                tone(8,NOTE_B5,100);
                delay(100);
                tone(8,NOTE_E6,850);
                delay(800);
                noTone(8);
                // =============================================================
                delay(100); // Don't listen for a second after confirmed shot
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
