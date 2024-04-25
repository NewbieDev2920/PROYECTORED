class GUI {
  PImage[] sprites = new PImage[3];
  boolean debugEnabled = false;
  PVector debugPos = new PVector();
  PVector debugScale = new PVector();
  PVector gameDataPos = new PVector();
  PVector gameDataScale = new PVector();
  public ArrayList<String> msgList = new ArrayList<String>();
  float gap = 10;
  String currentScene = "game";


  GUI(float w, float h, float w2, float h2) {
    this.debugScale.x = w;
    this.debugScale.y = h;
    this.gameDataScale.x = w2;
    this.gameDataScale.y = h2;
  }
  
  void updatePosition(PVector characterPosition){
    debugPos.x = characterPosition.x + 280;
    debugPos.y = characterPosition.y + 120;
    gameDataPos.x = characterPosition.x - 400;
    gameDataPos.y = characterPosition.y + 160;
  }

  void init() {
    if (debugEnabled) {
      println("GUI.debugEnabled = true");
      textSize(8);
    } else {
      println("GUI.debugEnabled = false");
    }
    sprites[0] = loadImage("../assets/sprites/gui/red.png");
    sprites[1] = loadImage("../assets/sprites/gui/white.png");
    sprites[2] = loadImage("../assets/sprites/gui/soul.png");
  }

  void debugDisplay() {
    if (debugEnabled) {
      fill(0,0,0, 127);
      rect(debugPos.x, debugPos.y, debugScale.x, debugScale.y);
      for (int i = 0; i < msgList.size(); i++) {
        fill(12, 250, 12);
        text(msgList.get(i), debugPos.x+8, debugPos.y+gap*(i+1));
      }
    }
  }
  
  void displayGameData(int hearts, int souls){
     fill(0,0,0, 127); 
     rect(gameDataPos.x, gameDataPos.y, gameDataScale.x, gameDataScale.y);
     switch(hearts){
        case 1:
         image(sprites[0], gameDataPos.x+gap, gameDataScale.y/2+gameDataPos.y-17);
         image(sprites[1], gameDataPos.x+gap+40, gameDataScale.y/2+gameDataPos.y-17);
         image(sprites[1], gameDataPos.x+gap+80, gameDataScale.y/2+gameDataPos.y-17);
        break;
        
        case 2:
         image(sprites[0], gameDataPos.x+gap, gameDataScale.y/2+gameDataPos.y-17);
         image(sprites[0], gameDataPos.x+gap+40, gameDataScale.y/2+gameDataPos.y-17);
         image(sprites[1], gameDataPos.x+gap+80, gameDataScale.y/2+gameDataPos.y-17);
        break;
        
        case 3:
         image(sprites[0], gameDataPos.x+gap, gameDataScale.y/2+gameDataPos.y-17);
         image(sprites[0], gameDataPos.x+gap+40, gameDataScale.y/2+gameDataPos.y-17);
         image(sprites[0], gameDataPos.x+gap+80, gameDataScale.y/2+gameDataPos.y-17);
        break;
         
        default:
         image(sprites[1], gameDataPos.x+gap, gameDataScale.y/2+gameDataPos.y-17);
         image(sprites[1], gameDataPos.x+gap+40, gameDataScale.y/2+gameDataPos.y-17);
         image(sprites[1], gameDataPos.x+gap+80, gameDataScale.y/2+gameDataPos.y-17);
        break;
     }
     image(sprites[2], gameDataPos.x+gap+120, gameDataScale.y/2+gameDataPos.y-17);
     text(String.valueOf(souls), gameDataPos.x+gap+160, gameDataScale.y/2+gameDataPos.y+5);
  }
}
