class GUI {
  PFont font;
  PImage[] sprites = new PImage[3];
  boolean debugEnabled = false;
  PVector debugPos = new PVector();
  PVector debugScale = new PVector();
  PVector gameDataPos = new PVector();
  PVector gameDataScale = new PVector();
  PImage deadImage;
  PImage victoryImage;
  PImage shopImage;
  public ArrayList<String> msgList = new ArrayList<String>();
  //1: Retry, 2: Return to menu
  Clock buttonClock = new Clock();
  int deadButtonHover = 1;
  //1: Continue, 2: Retry, 3: Return to menu
  int victoryButtonHover = 1;
  // Falta shopButtonHover
  float gap = 10;
  String currentScene = "shop";


  GUI(float w, float h, float w2, float h2) {
    this.debugScale.x = w;
    this.debugScale.y = h;
    this.gameDataScale.x = w2;
    this.gameDataScale.y = h2;
  }

  void updatePosition(PVector characterPosition) {
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
    deadImage = loadImage("../assets/sprites/gui/death.png");
    victoryImage = loadImage("../assets/sprites/gui/victory.png");
    shopImage = loadImage("../assets/sprites/gui/shop.png");
    font = createFont("Arial",32);
    textFont(font);
  }

  void debugDisplay() {
    if (debugEnabled) {
      fill(0, 0, 0, 127);
      rect(debugPos.x, debugPos.y, debugScale.x, debugScale.y);
      textSize(7);
      for (int i = 0; i < msgList.size(); i++) {
        fill(12, 250, 12);
        text(msgList.get(i), debugPos.x+8, debugPos.y+gap*(i+1));
      }
    }
  }

  void displayGameData(int hearts, int souls) {
    fill(0, 0, 0, 127);
    rect(gameDataPos.x, gameDataPos.y, gameDataScale.x, gameDataScale.y);
    rect(gameDataPos.x, gameDataPos.y-90, gameDataScale.x/2, gameDataScale.y);
    switch(hearts) {
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
    textSize(20);
    text(String.valueOf(souls), gameDataPos.x+gap+160, gameDataScale.y/2+gameDataPos.y+5);
    text(String.valueOf(gm.gameTimer), gameDataPos.x+gap, gameDataScale.y/2+gameDataPos.y-90);
  }

  void deadScreen() {
    background(0);
    image(deadImage, character.position.x-deadImage.width/2, character.position.y-deadImage.height/2);
    switch(deadButtonHover) {
    case 1:
      drawButton("Retry", character.position.x-deadImage.width/2, character.position.y+500, 400, 200, true);
      drawButton("Return to menu", character.position.x-deadImage.width/2+500, character.position.y+500, 400, 200, false);
      if (character.keyboardInput[0]) {
        deadButtonHover++;
      }

      if (character.keyboardInput[4]) {
        //Vuelve a jugar el jugador
      }
      break;

    case 2:
      drawButton("Retry", character.position.x-deadImage.width/2, character.position.y+500, 400, 200, false);
      drawButton("Return to menu", character.position.x-deadImage.width/2+500, character.position.y+500, 400, 200, true);
      if (character.keyboardInput[2]) {
        deadButtonHover--;
      }

      if (character.keyboardInput[4]) {
        //El jugador vuelve al menu
      }
      break;

    default:
      println("ERROR");
      break;
    }
  }

  void victoryScreen() {
    background(0);
    image(victoryImage, character.position.x-victoryImage.width/2, character.position.y-victoryImage.height/2);
    switch(victoryButtonHover) {
    case 1:
      drawButton("Continue", character.position.x-victoryImage.width/2, character.position.y+500, 400, 200, true);
      drawButton("Retry", character.position.x-victoryImage.width/2+500, character.position.y+500, 400, 200, false);
      drawButton("Return to menu", character.position.x-victoryImage.width/2+1000, character.position.y +500, 400, 200, false);
      if (character.keyboardInput[0] && buttonClock.timeElapsed(300)) {
        victoryButtonHover++;

      }
      break;

    case 2:
      drawButton("Continue", character.position.x-victoryImage.width/2, character.position.y+500, 400, 200, false);
      drawButton("Retry", character.position.x-victoryImage.width/2+500, character.position.y+500, 400, 200, true);
      drawButton("Return to menu", character.position.x-victoryImage.width/2+1000, character.position.y +500, 400, 200, false);
      if (character.keyboardInput[0] && buttonClock.timeElapsed(300)) {
        victoryButtonHover++;
    
      }

      if (character.keyboardInput[2] && buttonClock.timeElapsed(300)) {
        victoryButtonHover--;
    
      }
      break;

    case 3:
      drawButton("Continue", character.position.x-victoryImage.width/2, character.position.y+500, 400, 200, false);
      drawButton("Retry", character.position.x-victoryImage.width/2+500, character.position.y+500, 400, 200, false);
      drawButton("Return to menu", character.position.x-victoryImage.width/2+1000, character.position.y +500, 400, 200, true);
      if (character.keyboardInput[2] && buttonClock.timeElapsed(300)) {
        victoryButtonHover--;

      }
      break;
    }
  }

  void shopScreen() {
    background(0);
    image(shopImage, character.position.x-shopImage.width/2, character.position.y-shopImage.width/2);
    textSize(50);
    drawButton("PRESS ENTER", character.position.x-shopImage.width/2, character.position.y+400, 400, 200, true);
    if (character.keyboardInput[4]) {
      currentScene = "game";
    }
  }

  void drawButton(String text, float x, float y, float w, float h, boolean hover) {
    int buttonTextGap = 5;
    fill(105);
    rect(x, y, w, h);
    if (hover) {
      fill(240, 45, 45);
    } else {
      fill(237);
    }
    text(text, x+buttonTextGap, y+h/2);
  }
}
