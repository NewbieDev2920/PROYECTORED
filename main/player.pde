class Player {
  int animationStatus[];
  int hearts = 3;
  int soulScore = 0;
  //1: Derecha, -1: Izquierda
  int direction = 1;
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
  boolean[] keyboardInput = {false, false, false, false, false, false, false};
  float attackOffset = 30;
  Collider attackZone;



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
      body.col.checkEnemyInteraction();
      attackZone.checkPlayerAttack();
      position.x = body.position.x;
      position.y = body.position.y;
      if (direction == 1) {
        attackZone.origin.x = position.x + scale.x + attackOffset;
        attackZone.origin.y = position.y + scale.y/3;
      } else {
        attackZone.origin.x = position.x - attackOffset;
        attackZone.origin.y = position.y + scale.y/3;
      }
      
      if(gm.gameTimer == 0){
         hearts = 0; 
      }
      attackZone.display(0,255,0);
      attack();
      sprite.play(0,150,position);
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
    body.init(position);
    sprite.init("player/default.png");
    sprite.addAnimation("player/idle.png",32);
    gui.msgList.add(0, "Pos("+position.x+","+position.y+")");
    gui.msgList.add(1, "Vel("+body.velocity.x+","+body.velocity.y+")");
    gui.msgList.add(2, "speed("+body.speed+") jumpForce("+body.jumpForce+")");
    gui.msgList.add(3, "keyInpt{"+keyboardInput[0]+","+keyboardInput[1]+","+keyboardInput[2]+","+keyboardInput[3]+"}");
    gui.msgList.add(4, "collFace{"+body.col.collisionFace[0]+","+body.col.collisionFace[1]+","+body.col.collisionFace[2]+","+body.col.collisionFace[3]+"}");
    gui.msgList.add(5, "FPS ("+frameRate+")");
    attackZone = new Collider(position.x+attackOffset, position.y, 25, 10, "mobile");
    attackZone.borderThickness = 0.2;
  }

  void updateDebug() {
    gui.msgList.set(0, "Pos("+position.x+","+position.y+")");
    gui.msgList.set(1, "Vel("+body.velocity.x+","+body.velocity.y+")");
    gui.msgList.set(2, "speed("+body.speed+") jumpForce("+body.jumpForce+")");
    gui.msgList.set(3, "keyInpt{"+keyboardInput[0]+","+keyboardInput[1]+","+keyboardInput[2]+","+keyboardInput[3]+"}");
    gui.msgList.set(4, "collFace{"+body.col.collisionFace[0]+","+body.col.collisionFace[1]+","+body.col.collisionFace[2]+","+body.col.collisionFace[3]+"}");
    gui.msgList.set(5, "FPS ("+frameRate+")");
  }

  void attack() {
    if (keyboardInput[5]) {
        attackZone.display(255,0,0);
    }
  }
}
