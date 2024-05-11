class Player {
  int hearts = 3;
  int soulScore = 0;
  //In milliseconds
  int attackInterval = 729;
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
  Clock attackClock = new Clock();
  Physics body = new Physics();
  //0: Right, 1: Up, 2: Left, 3: Down, 4: Enter
  boolean[] keyboardInput = {false, false, false, false, false, false, false};
  float attackOffset = 5;
  Collider attackZone;
  boolean isAttacking = false;



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
        attackZone.origin.x = position.x - scale.x -attackOffset - 15;
        attackZone.origin.y = position.y + scale.y/3;
      }

      if (gm.gameTimer == 0) {
        hearts = 0;
      }
      attack();
      manageAnimation();
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
    sprite.addAnimation("player/idle.png", 64);
    sprite.addAnimation("player/run.png", 64);
    sprite.addAnimation("player/runleft.png", 64);
    sprite.addAnimation("player/jump.png", 64);
    sprite.addAnimation("player/fall.png", 64);
    sprite.addAnimation("player/jumpleft.png", 64);
    sprite.addAnimation("player/fallleft.png", 64);
    sprite.addAnimation("player/attack.png", 54, 39);
    sprite.addAnimation("player/attackleft.png", 54, 39);
    sprite.addAnimation("player/idleleft.png",64);

    gui.msgList.add(0, "Pos("+position.x+","+position.y+")");
    gui.msgList.add(1, "Vel("+body.velocity.x+","+body.velocity.y+")");
    gui.msgList.add(2, "speed("+body.speed+") jumpForce("+body.jumpForce+")");
    gui.msgList.add(3, "keyInpt{"+keyboardInput[0]+","+keyboardInput[1]+","+keyboardInput[2]+","+keyboardInput[3]+"}");
    gui.msgList.add(4, "collFace{"+body.col.collisionFace[0]+","+body.col.collisionFace[1]+","+body.col.collisionFace[2]+","+body.col.collisionFace[3]+"}");
    gui.msgList.add(5, "FPS ("+frameRate+")");
    attackZone = new Collider(position.x+attackOffset, position.y, 30, 10, "mobile");
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
      if (attackClock.timeElapsed(attackInterval)) {
        isAttacking = true;
      }
    }
  }

  void manageAnimation() {
    sprite.offsetX = -25;
    sprite.offsetY = -27;
    if (isAttacking && direction == 1) {
      sprite.offsetX = -8;
      sprite.offsetY = -10;
      sprite.playNoLoop(7, 29, position);
      if (sprite.ended) {
        isAttacking = false;
        sprite.ended = false;
      }
    } else if (isAttacking && direction == -1) {
      sprite.offsetX = -29;
      sprite.offsetY = -10;
      sprite.playNoLoop(8, 29, position);
      if (sprite.ended) {
        isAttacking = false;
        sprite.ended = false;
      }
    } else if (!body.col.collisionFace[3] && body.velocity.y < 0 && direction == 1) {
      sprite.play(3, 1000, position);
    } else if (!body.col.collisionFace[3] && body.velocity.y > 0 && direction == 1) {
      sprite.play(4, 1000, position);
    } else if (!body.col.collisionFace[3] && body.velocity.y < 0 && direction == -1) {
      sprite.play(5, 1000, position);
    } else if (!body.col.collisionFace[3] && body.velocity.y > 0 && direction == -1) {
      sprite.play(6, 1000, position);
    } else if (keyboardInput[0] && body.col.collisionFace[3]) {
      sprite.play(1, 50, position);
    } else if (keyboardInput[2] && body.col.collisionFace[3]) {
      sprite.play(2, 50, position);
    } else if(direction == 1) {
      sprite.play(0, 150, position);
    }else{
      sprite.play(9, 150, position);
    }
  }
}
