#include<ESP8266WiFi.h>
#include<FirebaseESP8266.h>
void printResult(FirebaseData &data);
#define led0 D0
#define led1 D1
#define led2 D2
#define led3 D3
#define FIREBASE_HOST "https://led-blinking-cf5e3-default-rtdb.firebaseio.com/"
#define FIREBASE_AUTH "qoXxJpWDWSaN2i8cD30DWxkcimcf15THo0AZ09nG"
#define WIFI_SSID "127.0.0.1"
#define WIFI_PASSWORD "*.*.??@Jay171$211561"
FirebaseData firebasedata;
void setup() {
  // put your setup code here, to run once:
  pinMode(led0,OUTPUT);
  pinMode(led1,OUTPUT);
  pinMode(led2,OUTPUT);
  pinMode(led3,OUTPUT);
  Serial.begin(9600);
  WiFi.begin(WIFI_SSID,WIFI_PASSWORD);
  while(WiFi.status()!=WL_CONNECTED){
    Serial.print("..");
    delay(200);
  }
  Serial.println("NODE MCU is connected");
  Serial.println(WiFi.localIP());
  Firebase.begin(FIREBASE_HOST,FIREBASE_AUTH);
  Firebase.reconnectWiFi(true);
  delay(1000);
//  Firebase.setInt(firebasedata,"/LED_Lights/RED/RED",0);
  }


//print value

void printResult(FirebaseData &data)
{

  if (data.dataType() == "int")
    Serial.println(data.intData());
  else if (data.dataType() == "float")
    Serial.println(data.floatData(), 5);
  else if (data.dataType() == "double")
    printf("%.9lf\n", data.doubleData());
  else if (data.dataType() == "boolean")
    Serial.println(data.boolData() == 1 ? "true" : "false");
  else if (data.dataType() == "string")
    Serial.println(data.stringData());
  else if (data.dataType() == "json")
  {
    Serial.println();
    FirebaseJson &json = data.jsonObject();
    //Print all object data
    Serial.println("Pretty printed JSON data:");
    String jsonStr;
    json.toString(jsonStr, true);
    Serial.println(jsonStr);
    Serial.println();
    Serial.println("Iterate JSON data:");
    Serial.println();
    size_t len = json.iteratorBegin();
    String key, value = "";
    int type = 0;
    for (size_t i = 0; i < len; i++)
    {
      json.iteratorGet(i, type, key, value);
      Serial.print(i);
      Serial.print(", ");
      Serial.print("Type: ");
      Serial.print(type == FirebaseJson::JSON_OBJECT ? "object" : "array");
      if (type == FirebaseJson::JSON_OBJECT)
      {
        Serial.print(", Key: ");
        Serial.print(key);
      }
      Serial.print(", Value: ");
      Serial.println(value);
    }
    json.iteratorEnd();
  }
  else if (data.dataType() == "array")
  {
    Serial.println();
    //get array data from FirebaseData using FirebaseJsonArray object
    FirebaseJsonArray &arr = data.jsonArray();
    //Print all array values
    Serial.println("Pretty printed Array:");
    String arrStr;
    arr.toString(arrStr, true);
    Serial.println(arrStr);
    Serial.println();
    Serial.println("Iterate array values:");
    Serial.println();
    for (size_t i = 0; i < arr.size(); i++)
    {
      Serial.print(i);
      Serial.print(", Value: ");

      FirebaseJsonData &jsonData = data.jsonData();
      //Get the result data from FirebaseJsonArray object
      arr.get(jsonData, i);
      if (jsonData.typeNum == FirebaseJson::JSON_BOOL)
        Serial.println(jsonData.boolValue ? "true" : "false");
      else if (jsonData.typeNum == FirebaseJson::JSON_INT)
        Serial.println(jsonData.intValue);
      else if (jsonData.typeNum == FirebaseJson::JSON_FLOAT)
        Serial.println(jsonData.floatValue);
      else if (jsonData.typeNum == FirebaseJson::JSON_DOUBLE)
        printf("%.9lf\n", jsonData.doubleValue);
      else if (jsonData.typeNum == FirebaseJson::JSON_STRING ||
               jsonData.typeNum == FirebaseJson::JSON_NULL ||
               jsonData.typeNum == FirebaseJson::JSON_OBJECT ||
               jsonData.typeNum == FirebaseJson::JSON_ARRAY)
        Serial.println(jsonData.stringValue);
    }
  }
  else if (data.dataType() == "blob")
  {

    Serial.println();

    for (int i = 0; i < data.blobData().size(); i++)
    {
      if (i > 0 && i % 16 == 0)
        Serial.println();

      if (i < 16)
        Serial.print("0");

      Serial.print(data.blobData()[i], HEX);
      Serial.print(" ");
    }
    Serial.println();
  }
  else if (data.dataType() == "file")
  {

    Serial.println();

    File file = data.fileStream();
    int i = 0;

    while (file.available())
    {
      if (i > 0 && i % 16 == 0)
        Serial.println();

      int v = file.read();

      if (v < 16)
        Serial.print("0");

      Serial.print(v, HEX);
      Serial.print(" ");
      i++;
    }
    Serial.println();
    file.close();
  }
  else
  {
    Serial.println(data.payload());
  }
}








void loop() {
  // put your main code here, to run repeatedly:
//  Firebase.setFloat("Number",2.3);
//  if(Firebase.failed()){
//    Serial.print("Data write failed");
//  }
//  bool red_light = Firebase.getBool("RED");
//  if(red_light == true){
//    Serial.println("Red light is ON");
//  }
//  else{
//    Serial.println("Red light is OFF");
//  }

int val=Firebase.get(firebasedata,"/LED_Lights/RED/RED");
Serial.println(val);
  //for red
  if(Firebase.getBool(firebasedata,"/LED_Lights/RED/RED")==1){
    Serial.println("Value Read Successfully");
    Serial.println("value is "+firebasedata.ETag());
    printResult(firebasedata);
   if(firebasedata.boolData()==1){
    digitalWrite(led0,HIGH);
   }
   else if(firebasedata.boolData()==0){
    digitalWrite(led0,LOW);
   }
  }
   //for green
   if(Firebase.getBool(firebasedata,"/LED_Lights/GREEN/GREEN")==1){
    Serial.println("Value Read Successfully");
    Serial.println("value is "+firebasedata.ETag());
    printResult(firebasedata);
   if(firebasedata.boolData()==1){
    digitalWrite(led3,HIGH);
   }
   else if(firebasedata.boolData()==0){
    digitalWrite(led3,LOW);
   }
  }
   //for yellow
   if(Firebase.getBool(firebasedata,"/LED_Lights/YELLOW/YELLOW")==1){
    Serial.println("Value Read Successfully");
    Serial.println("value is "+firebasedata.ETag());
    printResult(firebasedata);
   if(firebasedata.boolData()==1){
    digitalWrite(led1,HIGH);
   }
   else if(firebasedata.boolData()==0){
    digitalWrite(led1,LOW);
   }
  }
   //for blue
   if(Firebase.getBool(firebasedata,"/LED_Lights/BLUE/BLUE")==1){
    Serial.println("Value Read Successfully");
    Serial.println("value is "+firebasedata.ETag());
    printResult(firebasedata);
   if(firebasedata.boolData()==1){
    digitalWrite(led2,HIGH);
   }
   else if(firebasedata.boolData()==0){
    digitalWrite(led2,LOW);
   }
  }
//  else if(Firebase.getBool(firebasedata,"/LED_Lights/RED/RED")==1){
//    Serial.println("Value Read Successfully");
//  
//    digitalWrite(led2,HIGH);
//  }
  
}
