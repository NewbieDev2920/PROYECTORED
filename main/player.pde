class Player {
  int hearts = 3;
  int soulScore = 0;
  boolean isInvincible = false;
  Sprite sprite = new Sprite();
  PVector position = new PVector();
  PVector velocity = new PVector();
  PVector scale = new PVector();
  float speed =4;
  //Distance/frames (60 frames = 1s)
  float jumpForce = 7;
  boolean jumping;
  int time;
  Clock jumpClock = new Clock();
  Clock invincibleClock = new Clock();

  //0: Right, 1: Up, 2: Left, 3: Down, 4: Enter
  boolean[] keyboardInput = {false, false, false, false, false};
  Collider col;



  Player(float x, float y, float w, float h) {
    this.position.x = x;
    this.position.y = y;
    this.scale.x = w;
    this.scale.y = h;
  }

  void display() {
    fill(25, 25, 255);
  }

  void move() {
    if (gui.currentScene == "game") {
      calcVelocity();
      applyGravity();
      position.x += velocity.x;
      jump();
      position.y += velocity.y;
      col.origin.x = position.x + col.centerGap.x;
      col.origin.y = position.y + col.centerGap.y;
      col.checkCollision();
      col.checkInteraction();
      sprite.display(position);
      checkInvincibleEffect();
    }
  }

  void calcVelocity() {

    if (keyboardInput[0] && keyboardInput[2]) {
      velocity.x = 0;
    } else if (keyboardInput[0] && !col.collisionFace[0]) {
      velocity.x = speed;
    } else if (keyboardInput[2] && !col.collisionFace[2]) {
      velocity.x = -speed;
    } else {
      velocity.x = 0;
    }

    if (keyboardInput[1] && keyboardInput[3]) {
      velocity.y = 0;
    } else if (keyboardInput[1] && !col.collisionFace[1]) {
      //Jump, resolver problema de colliders al saltar
      if (character.col.collisionFace[3]) {
        character.jumping = true;
      }
    } else if (keyboardInput[3] && !col.collisionFace[3]) {
      velocity.y = speed;
    } else {
      velocity.y = 0;
    }
  }

  void applyGravity() {
    if (!col.collisionFace[3]) {
      velocity.y = 5;
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
    col = new Collider(position.x, position.y, scale.x, scale.y, "mobile");
    col.centerCollider(position, scale);
    col.borderThickness = 0.2;
    sprite.init("player/default.png");
    gui.msgList.add(0, "Pos("+position.x+","+position.y+")");
    gui.msgList.add(1, "Vel("+velocity.x+","+velocity.y+")");
    gui.msgList.add(2, "speed("+speed+") jumpForce("+jumpForce+")");
    gui.msgList.add(3, "keyInpt{"+keyboardInput[0]+","+keyboardInput[1]+","+keyboardInput[2]+","+keyboardInput[3]+"}");
    gui.msgList.add(4, "collFace{"+col.collisionFace[0]+","+col.collisionFace[1]+","+col.collisionFace[2]+","+col.collisionFace[3]+"}");
    gui.msgList.add(5, "FPS ("+frameRate+")");
  }

  void updateDebug() {
    gui.msgList.set(0, "Pos("+position.x+","+position.y+")");
    gui.msgList.set(1, "Vel("+velocity.x+","+velocity.y+")");
    gui.msgList.set(2, "speed("+speed+") jumpForce("+jumpForce+")");
    gui.msgList.set(3, "keyInpt{"+keyboardInput[0]+","+keyboardInput[1]+","+keyboardInput[2]+","+keyboardInput[3]+"}");
    gui.msgList.set(4, "collFace{"+col.collisionFace[0]+","+col.collisionFace[1]+","+col.collisionFace[2]+","+col.collisionFace[3]+"}");
    gui.msgList.set(5, "FPS ("+frameRate+")");
  }

  void jump() {
    if (jumping) {
      velocity.y = -jumpForce;
    } else {
      jumpClock.updateTime();
    }

    if (jumpClock.timeElapsed(250) || col.collisionFace[1]) {
      jumping = false;
    }
  }
}
