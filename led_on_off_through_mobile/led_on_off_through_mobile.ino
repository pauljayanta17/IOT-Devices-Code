#include<ESP8266WiFi.h>
//#include<ESP8266WebServer.h>
//#include<WiFiClient.h>
#define led2 D2
#define led3 D3
#define led4 D4
#define led5 D5
WiFiClient client;
WiFiServer server(80);
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  WiFi.softAP("MyWiFi","12345678");
  Serial.println("NODEMCU Started ");
  Serial.println(WiFi.softAPIP());
  server.begin();
  pinMode(led2,OUTPUT);
  pinMode(led3,OUTPUT);
  pinMode(led4,OUTPUT);
  pinMode(led5,OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  client = server.available();
  String message;
  if(client ==1){
    message=client.readStringUntil('\n');
    Serial.println(message);
  }
  message.trim();
  if(message == "GET /led1on HTTP/1.1"){
    digitalWrite(led2,HIGH);
  }
  if(message =="GET /led1off HTTP/1.1"){
    digitalWrite(led2,LOW);
  }
  if(message == "GET /led2on HTTP/1.1"){
    digitalWrite(led3,HIGH);
  }
  if(message =="GET /led2off HTTP/1.1"){
    digitalWrite(led3,LOW);
  }
   if(message == "GET /led3on HTTP/1.1"){
    digitalWrite(led4,HIGH);
  }
  if(message =="GET /led3off HTTP/1.1"){
    digitalWrite(led4,LOW);
  }
   if(message == "GET /led4on HTTP/1.1"){
    digitalWrite(led5,HIGH);
  }
  if(message =="GET /led4off HTTP/1.1"){
    digitalWrite(led5,LOW);
  }
  client.println("HTTP/1.1 200 OK");
  client.println("Content-Type: text/html");
  client.println("");
  client.println("<!DOCTYPE HTML>");
  client.println("<html>");
  client.println("<head>");
  client.println("<title>Web Page</title>");
  client.println("</head>");
  client.println("<body>");
  client.println("<a href=\"led1on\"\"><button>LED1 ON</button></a>");
  client.println("<a href=\"led1off\"\"><button>LED1 OFF</button></a><br>");
  client.println("<br>");
  client.println("<a href=\"led2on\"\"><button>LED2 ON</button></a>");
  client.println("<a href=\"led2off\"\"><button>LED2 OFF</button></a>");
  client.println("<br>");
  client.println("<a href=\"led3on\"\"><button>LED3 ON</button></a>");
  client.println("<a href=\"led3off\"\"><button>LED3 OFF</button></a>");
  client.println("<br>");
  client.println("<a href=\"led4on\"\"><button>LED4 ON</button></a>");
  client.println("<a href=\"led4off\"\"><button>LED4 OFF</button></a>");
  client.println("</body>");
  client.println("</html>");
  
}
