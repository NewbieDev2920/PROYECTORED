import java.io.File; //<>//
class Sprite {
  int spriteIndex = 0;
  Clock spriteClock = new Clock();
  File directory;
  ArrayList<PImage[]> animationColl = new ArrayList<PImage[]>();
  PImage defaultImg;
  PImage NULL;
  String PATH = "../assets/sprites/";

  void display(PVector pos) {

    try {
      image(defaultImg, pos.x, pos.y);
    }
    catch(Exception e) {
      rect(pos.x, pos.y, 20, 20);
    }
  }

  void init(String path) {
    defaultImg = loadImage(PATH+path);
    NULL = loadImage("null.png");
  }

  void addAnimation(String path, int snapWidth) {
    path = PATH+path;
    PImage image = loadImage(path);
    PImage cuttedImage;
    PImage[] spriteList = new PImage[image.width/snapWidth];
    for (int i = 1; i <= image.width/snapWidth; i++) {
      cuttedImage = image.get(snapWidth*(i-1), 0, snapWidth, snapWidth);
      spriteList[i-1] = cuttedImage;
    }
    animationColl.add(spriteList);
  }

  void play(int animationIndex, int interval, PVector position) {
    PImage[] spriteList = animationColl.get(animationIndex);
    image(spriteList[spriteIndex], position.x, position.y);
     if (spriteClock.timeElapsed(interval)) {
      if (spriteIndex == spriteList.length-1) {
        spriteIndex = 0;
      } else {
        spriteIndex++;
      }
    }
  
  }
}
