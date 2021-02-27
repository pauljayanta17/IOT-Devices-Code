#define led5 D5
#define led2 D2
#define led3 D3
#define led4 D4
#include<ESP8266WiFi.h>
#include<String.h>
WiFiClient client;
WiFiServer server(80);
void setup() {
  // put your setup code here, to run once:
  pinMode(led5,OUTPUT);
  pinMode(led2,OUTPUT);
  pinMode(led3,OUTPUT);
  pinMode(led4,OUTPUT);
  Serial.begin(9600);
  WiFi.begin("127.0.0.1","*.*.??@Jay171$211561");
  while(WiFi.status()!=WL_CONNECTED){
    Serial.print("..");
    delay(200);
  }
  Serial.println("NODE MCU is connected");
  Serial.println(WiFi.localIP());
  server.begin();
}

void loop() {
  // put your main code here, to run repeatedly:
  client=server.available();
  String message;
  if(client==1){
    message = client.readStringUntil('\n');
    Serial.println(message);
  }
  message.trim();
  if(message == "GET /on HTTP/1.1"){
    digitalWrite(led2,HIGH);
  }
  if(message =="GET /off HTTP/1.1"){
    digitalWrite(led2,LOW);
  }
  
}
   /*
    digitalWrite(led2,HIGH);
  delay(500);
  digitalWrite(led2,LOW);
  delay(500);
  digitalWrite(led3,HIGH);
  delay(500);
  digitalWrite(led3,LOW);
  delay(500);
  digitalWrite(led4,HIGH);
  delay(500);
  digitalWrite(led4,LOW);
  delay(500);
  digitalWrite(led5,HIGH);
  delay(500);
  digitalWrite(led5,LOW);
  delay(500);
  digitalWrite(led2,HIGH);
  digitalWrite(led3,HIGH);
  digitalWrite(led4,HIGH);
  digitalWrite(led5,HIGH);
  delay(2000);
  digitalWrite(led2,LOW);
  digitalWrite(led3,LOW);
  digitalWrite(led4,LOW);
  digitalWrite(led5,LOW);
  delay(1000);
  //another sequence
  digitalWrite(led2,HIGH);
  delay(500);
  digitalWrite(led2,LOW);
  delay(1000);
  digitalWrite(led2,HIGH);
  digitalWrite(led3,HIGH);
  delay(500);
   digitalWrite(led2,LOW);
  digitalWrite(led3,LOW);
  delay(1000);
  digitalWrite(led2,HIGH);
  digitalWrite(led3,HIGH);
  digitalWrite(led4,HIGH);
  delay(500);
  digitalWrite(led2,LOW);
  digitalWrite(led3,LOW);
  digitalWrite(led4,LOW);
  delay(1000);
  digitalWrite(led2,HIGH);
  digitalWrite(led3,HIGH);
  digitalWrite(led4,HIGH);
  digitalWrite(led5,HIGH);
  delay(500);
   digitalWrite(led2,LOW);
  digitalWrite(led3,LOW);
  digitalWrite(led4,LOW);
  digitalWrite(led5,LOW);
  delay(1000);
  //another sequences 2
  digitalWrite(led2,HIGH);
  delay(200);
  digitalWrite(led2,LOW);
  delay(200);
  digitalWrite(led3,HIGH);
  delay(200);
  digitalWrite(led3,LOW);
  delay(200);
  digitalWrite(led4,HIGH);
  delay(200);
  digitalWrite(led4,LOW);
  delay(200);
  digitalWrite(led5,HIGH);
  delay(200);
  digitalWrite(led5,LOW);
  delay(200);
  */  
