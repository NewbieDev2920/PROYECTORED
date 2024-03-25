class Debug{
 boolean enabled = false;
 //topRight, topLeft, bottomLeft, bottomRight
  String position;
  PVector scale = new PVector();
 ArrayList<String> msgList = new ArrayList<String>();
 
 Debug(String position, float w, float h){
   this.position = position;
   this.scale.x = w;
   this.scale.y = h;
 }
 
 void init(){
   PVector pos = new PVector();
  if(enabled){
    fill(100);
    if(position == "topRight"){
      pos.x = width-scale.x;
      pos.y = 0;
    }
    else if(position == "topLeft"){
      pos.x = 0;
      pos.y = 0;
    }
    else if(position == "bottomLeft"){
      pos.x = 0;
      pos.y = height-scale.y;
    }
    else if(position == "bottomRight"){
      pos.x = width-scale.x;
      pos.y = height-scale.y;
    }
    else{
       print("Error, unknown position for: "+ position); 
    }
    
  }
  else{
   println("Debug.enabled = false"); 
  }
 }
 
 void addItem(String msg){
   
 }
 
}
