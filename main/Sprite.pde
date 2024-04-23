import java.io.File;
class Sprite {
  
  Dictionary<String, PImage[]> animationList = new Hashtable<>();
  String PATH = "../assets/sprites/";
  
  void display(PVector pos) {
    rect(pos.x, pos.y, 15, 15);
  }

  void init(String path) {
    this.PATH = PATH+path;
    println(PATH);
    /*File file = new File(PATH);
    for(String f : file.list()){
     println(f);
     }*/
  }

  
}
