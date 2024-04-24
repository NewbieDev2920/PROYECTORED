import java.io.File;
class Sprite {
  PImage test;
  Dictionary<String, PImage[]> animationList = new Hashtable<>();
  String PATH = "../assets/sprites/";
  
  void display(PVector pos) {
    image(test, pos.x, pos.y);
  }

  void init(String path) {
    PATH = PATH+path;
    test = loadImage(PATH);
    
  }

  
}
