import java.io.File;
class Sprite {
  PImage test;
  PImage NULL;  
  Dictionary<String, PImage[]> animationList = new Hashtable<>();
  String PATH = "../assets/sprites/";
  
  void display(PVector pos) {
    
    try{
      image(test, pos.x, pos.y);
    }
    catch(Exception e){
       rect(pos.x, pos.y, 20, 20); //<>//
    }
  
  }

  void init(String path) {
    this.PATH = this.PATH+path;
    NULL = loadImage("null.png");
    test = loadImage(PATH);
    println(test);  
    println(PATH);
  }

  
}
