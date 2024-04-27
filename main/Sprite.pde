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
      image(NULL, pos.x, pos.y);
    }
  }

  void init(String path) {
    PATH = PATH+path;
    NULL = loadImage("NULL.png");
    test = loadImage(PATH);
    
  }

  
}
