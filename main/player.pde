class Player {
  int hearts = 3;
  int soulScore = 0;
  boolean isInvincible = false;
  Sprite sprite = new Sprite();
  PVector position = new PVector();
  PVector scale = new PVector();
  //Distance/frames (60 frames = 1s)
  int time;
  Clock jumpClock = new Clock();
  Clock invincibleClock = new Clock();
  Physics body = new Physics();
  //0: Right, 1: Up, 2: Left, 3: Down, 4: Enter
  boolean[] keyboardInput = {false, false, false, false, false};



  Player(float x, float y, float w, float h) {
    this.position.x = x;
    this.position.y = y;
    this.scale.x = w;
    this.scale.y = h;
  }

  void move() {
    if (gui.currentScene == "game") {
      body.move();
      body.col.checkInteraction();
      position.x = body.position.x;
      position.y = body.position.y;
      sprite.display(position);
      checkInvincibleEffect();
    }
  }

  void checkInvincibleEffect() {
    if (isInvincible) {

      if (invincibleClock.timeElapsed(1000)) {
        isInvincible = false;
      }
    }
  }

  void init() {
    body.init();
    sprite.init("player/default.png");
    gui.msgList.add(0, "Pos("+position.x+","+position.y+")");
    gui.msgList.add(1, "Vel("+body.velocity.x+","+body.velocity.y+")");
    gui.msgList.add(2, "speed("+body.speed+") jumpForce("+body.jumpForce+")");
    gui.msgList.add(3, "keyInpt{"+keyboardInput[0]+","+keyboardInput[1]+","+keyboardInput[2]+","+keyboardInput[3]+"}");
    gui.msgList.add(4, "collFace{"+body.col.collisionFace[0]+","+body.col.collisionFace[1]+","+body.col.collisionFace[2]+","+body.col.collisionFace[3]+"}");
    gui.msgList.add(5, "FPS ("+frameRate+")");
    
  }

  void updateDebug() {
    gui.msgList.set(0, "Pos("+position.x+","+position.y+")");
    gui.msgList.set(1, "Vel("+body.velocity.x+","+body.velocity.y+")");
    gui.msgList.set(2, "speed("+body.speed+") jumpForce("+body.jumpForce+")");
    gui.msgList.set(3, "keyInpt{"+keyboardInput[0]+","+keyboardInput[1]+","+keyboardInput[2]+","+keyboardInput[3]+"}");
    gui.msgList.set(4, "collFace{"+body.col.collisionFace[0]+","+body.col.collisionFace[1]+","+body.col.collisionFace[2]+","+body.col.collisionFace[3]+"}");
    gui.msgList.set(5, "FPS ("+frameRate+")");
  }
}
