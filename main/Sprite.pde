import java.io.File; //<>//
class Sprite {
  int offsetX = 0;
  int offsetY= 0;
  Clock spriteClock = new Clock();
  File directory;
  ArrayList<PImage[]> animationColl = new ArrayList<PImage[]>();
  ArrayList<Integer> animationCollIndex = new ArrayList<Integer>();
  PImage defaultImg;
  PImage NULL;
  String PATH = "../assets/sprites/";
  boolean ended = false;

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
    animationCollIndex.add(0);
  }

  void addAnimation(String path, int snapWidth, int snapHeight) {
    path = PATH+path;
    PImage image = loadImage(path);
    PImage cuttedImage;
    PImage[] spriteList = new PImage[image.width/snapWidth];
    for (int i = 1; i <= image.width/snapWidth; i++) {
      cuttedImage = image.get(snapWidth*(i-1), 0, snapWidth, snapHeight);
      spriteList[i-1] = cuttedImage;
    }
    animationColl.add(spriteList);
    animationCollIndex.add(0);
  }

  void play(int animationIndex, int interval, PVector position) {
    int index = animationCollIndex.get(animationIndex);
    PImage[] spriteList = animationColl.get(animationIndex);
    image(spriteList[index], position.x + offsetX, position.y + offsetY);
    if (spriteClock.timeElapsed(interval)) {
      if (index == spriteList.length-1) {
        animationCollIndex.set(animationIndex, 0);
      } else {
        animationCollIndex.set(animationIndex, index+1);
      }
    }
  }

  void playNoLoop(int animationIndex, int interval, PVector position) {
    int index = animationCollIndex.get(animationIndex);
    PImage[] spriteList = animationColl.get(animationIndex);
    image(spriteList[index], position.x + offsetX, position.y + offsetY);
    if (spriteClock.timeElapsed(interval)) {
      if (index == spriteList.length-1) {
        animationCollIndex.set(animationIndex, index);
        ended = true;
      } else {
        animationCollIndex.set(animationIndex, index+1);
      }
    }
  }
}
