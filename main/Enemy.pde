class Enemy {
  //patrol, chase
  boolean[] status = {true, false, false};
  int hearts;
  int patrolRadius;
  int chaseRadius;
  int attackRadius;
  int visionRange;
  //1: Derecha, -1: Izquierda
  int direction = 1;
  float gravityAcceleration = 0.2;
  float patrolSpeed;
  float chaseSpeed;
  Sprite sprite;
  PVector centralPoint = new PVector();
  PVector position = new PVector();
  PVector velocity = new PVector();
  PVector acceleration = new PVector();
  PVector scale = new PVector();
  String type;
  Obstacle harmfulBody = new Obstacle();
  Clock patrolClock = new Clock();
  Clock shootingClock = new Clock();
  Clock jumpClock = new Clock();
  Clock jumpInterval = new Clock();
  Clock waitingInterval = new Clock();
  Collider col;
  boolean jumping = false;
  boolean airAttackReady = true;
  float jumpForce = 7;
  boolean waiting = false;



  void init(String type, PVector centralPoint, int patrolRadius) {
    this.type = type;
    this.centralPoint = centralPoint;
    this.patrolRadius = patrolRadius;
    this.position.x = centralPoint.x;
    this.position.y = centralPoint.y;
    sprite = new Sprite();
    sprite.init("player/default.png");
    if (type == "black") {
      patrolSpeed = 1;
      chaseSpeed = 3.5;
      scale.x = 20;
      scale.y = 40;
      hearts = 1;
      this.visionRange = 100;
    } else if (type == "gray") {
      patrolSpeed = 0.5;
      scale.x = 20;
      scale.y = 50;
      hearts = 1;
    } else if (type == "witch") {
      patrolSpeed = 0.5;
      chaseSpeed = 0.5;
      scale.x = 20;
      scale.y = 50;
      hearts = 1;
      this.visionRange = 500;
      sprite.offsetX = -16;
      sprite.offsetY = -16;
      sprite.addAnimation("enemies/witch/idle.png", 40, 69);
      sprite.addAnimation("enemies/witch/idleleft.png", 40, 69);
    } else if (type == "wizard") {
      patrolSpeed = 0.5;
      chaseSpeed = 0.5;
      scale.x = 20;
      scale.y = 50;
      hearts = 1;
      sprite.offsetX = -15;
      sprite.offsetY = -10;
      sprite.addAnimation("enemies/wizard/idle.png", 43, 55);
      sprite.addAnimation("enemies/wizard/idleleft.png", 43, 55);
      this.visionRange = 500;
    } else if ( type == "tocho") {
      patrolSpeed = 1;
      chaseSpeed = 1.5;
      scale.x = 45;
      scale.y = 60;
      hearts = 3;
      this.visionRange = 500;
      sprite = new Sprite();
      sprite.offsetX = -16;
      sprite.offsetY = -48;

      sprite.addAnimation("enemies/tocho/walk.png", 85, 100);
      sprite.addAnimation("enemies/tocho/walkleft.png", 85, 100);
      sprite.addAnimation("enemies/tocho/idle.png", 92, 107);
      sprite.addAnimation("enemies/tocho/idleleft.png", 92, 107);
    } else {
      println("este tipo de enemigo no existe");
    }
    col = new Collider(position.x, position.y, scale.x, scale.y, "mobile");
    col.centerCollider(position, scale);
    col.borderThickness = 0.2;
  }

  void move() {
    if (hearts >= 1) {
      if (type == "black") {
        patrol();
        chase();
        col.checkCollision();
        calcVel();
        position.add(velocity);
        velocity.add(acceleration);
        col.origin.x = position.x + col.centerGap.x;
        col.origin.y = position.y + col.centerGap.y;
        fill(255, 0, 0);
        rect(position.x, position.y, scale.x, scale.y);
      } else if (type == "gray") {
        calcVel();
        col.checkCollision();
        position.add(velocity);
        velocity.add(acceleration);
        col.origin.x = position.x + col.centerGap.x;
        col.origin.y = position.y + col.centerGap.y;
        fill(255, 255, 0);
        rect(position.x, position.y, scale.x, scale.y);
        grayShoot(1000);
      } else if (type == "witch") {
        patrol();
        chase();
        attack();
        calcVel();
        col.checkCollision();
        position.add(velocity);
        velocity.add(acceleration);
        col.origin.x = position.x + col.centerGap.x;
        col.origin.y = position.y + col.centerGap.y;
        if (character.position.x >= position.x) {
          sprite.play(0, 80, position);
        } else {
          sprite.play(1, 80, position);
        }
      } else if (type == "wizard") {
        patrol();
        chase();
        attack();
        calcVel();
        col.checkCollision();
        position.add(velocity);
        velocity.add(acceleration);
        col.origin.x = position.x + col.centerGap.x;
        col.origin.y = position.y + col.centerGap.y;
        if (character.position.x >= position.x) {
          sprite.play(0, 200, position);
        } else {
          sprite.play(1, 200, position);
        }
      } else if (type == "tocho") {
        patrol();
        chase();
        attack();
        calcVel();
        jump();
        col.checkCollision();
        position.add(velocity);
        velocity.add(acceleration);
        col.origin.x = position.x + col.centerGap.x;
        col.origin.y = position.y + col.centerGap.y;
        if (direction == 1 && velocity.x != 0) {
          sprite.play(0, 300, position);
        } else if (direction == -1 && velocity.x != 0) {
          sprite.play(1, 300, position);
        } else if (direction == 1) {
          sprite.play(2, 300, position);
        } else if (direction == -1) {
          sprite.play(3, 300, position);
        }
      }
      checkWounds();
    }
  }

  void grayShoot(int interval) {
    if (shootingClock.timeElapsed(interval)) {
      Proyectile kunai = new Proyectile();
      kunai.init("parabolic", position, character.position, 5);
      gm.bulletList.add(kunai);
    }
  }

  void witchShoot(int interval) {
    if (shootingClock.timeElapsed(interval)) {
      for (int i = 0; i < 8; i++) {
        Proyectile magicBall = new Proyectile();
        magicBall.proyectileSprite = "green";
        magicBall.init("lineal", position, new PVector(position.x + 50*cos(i*QUARTER_PI), position.y + 50*sin(i*QUARTER_PI)), 3);
        gm.bulletList.add(magicBall);
      }
    }
  }

  void wizardShoot(int interval) {
    if (shootingClock.timeElapsed(interval)) {
      int offset = 50;
      int upside;
      if (int(random(2)) == 0) {
        upside = 1;
      } else {
        upside = -1;
      }
      for (int i = 0; i < 3; i++) {
        Proyectile magicBall = new Proyectile();
        if (upside == 1) {
          magicBall.proyectileSprite = "blue";
        } else {
          magicBall.proyectileSprite = "blueup";
        }
        magicBall.init("lineal", new PVector(character.position.x+i*offset, character.position.y - 400*upside), new PVector(character.position.x+i*offset, character.position.y), 4);
        gm.bulletList.add(magicBall);
      }
    }
  }

  void patrol() {
    if (status[0]) {
      //Ronda de vigilancia
      if ( (position.x >= centralPoint.x + patrolRadius) || col.collisionFace[0] ) {
        if (patrolClock.timeElapsed(1000)) {
          direction = -1;
          velocity.x = -patrolSpeed * gm.gameSpeedMultiplier;
        }
      } else if ( (position.x <= centralPoint.x - patrolRadius) || col.collisionFace[2]) {
        if (patrolClock.timeElapsed(1000)) {
          direction = 1;
          velocity.x = patrolSpeed * gm.gameSpeedMultiplier;
        }
      } else {

        if (direction == 1) {
          velocity.x = patrolSpeed * gm.gameSpeedMultiplier;
        } else {
          velocity.x = -patrolSpeed * gm.gameSpeedMultiplier;
        }
      }
      //Detectar al jugador
      if (direction == 1 && character.position.x < visionRange + position.x && character.position.x > position.x) {
        println("puede ser pa");
        status[0] = false;
        status[1] = true;
      } else if (direction == -1 && character.position.x > position.x - visionRange && character.position.x < position.x) {
        println("puede ser pa 2");
        status[0] = false;
        status[1] = true;
      }
    }
  }


  void chase() {
    //15 por ahora, despues es mas para que los enemigos ataquen por medio de su attackZone
    if (type != "wizard" && type != "witch" && type != "tocho") {
      int offset = 15;
      if (status[1]) {
        if (position.x > character.position.x + offset) {
          velocity.x = -chaseSpeed * gm.gameSpeedMultiplier;
        } else if (position.x < character.position.x - offset) {
          velocity.x = chaseSpeed * gm.gameSpeedMultiplier;
        }
      }
    } else if (type == "wizard" || type == "witch") {

      if (status[1]) {
        status[1] = false;
        status[2] = true;
        attack();
      }
    } else if (type == "tocho") {
      if (status[1]) {
        int offset = 15;
        if (jumpInterval.timeElapsed(int(random(4, 7))*1000)) {
          airAttackReady = true;
          jumping = true;
        }

        if (airAttackReady && col.collisionFace[3] && velocity.y > 3 ) {
          airAttackReady = false;
          Proyectile left = new Proyectile();
          Proyectile right = new Proyectile();
          left.proyectileSprite = "redleft";
          right.proyectileSprite = "red";
          left.init("lineal", new PVector(position.x, position.y+20), new PVector(position.x + 50*cos(PI), position.y-1), 3);
          right.init("lineal", new PVector(position.x, position.y+20), new PVector(position.x + 50*cos(0), position.y-1), 3);
          left.lifeTime = 1*1000;
          right.lifeTime = 1*1000;
          gm.bulletList.add(left);
          gm.bulletList.add(right);
          waiting = true;
        }

        if (!waiting && !col.collisionFace[0] && !col.collisionFace[2]) {
          if (position.x > character.position.x + offset && jumping) {
            velocity.x = -chaseSpeed*3 * gm.gameSpeedMultiplier;
            direction = -1;
          } else if (position.x < character.position.x - offset && jumping) {
            velocity.x = chaseSpeed*3 * gm.gameSpeedMultiplier;
            direction = 1;
          } else if (position.x > character.position.x + offset) {
            velocity.x = -chaseSpeed * gm.gameSpeedMultiplier;
            direction = -1;
          } else if (position.x < character.position.x - offset) {
            velocity.x = chaseSpeed * gm.gameSpeedMultiplier;
            direction = 1;
          }
        } else {
          if (waitingInterval.timeElapsed(2000)) {
            waiting = false;
          }
        }
      }
    }
  }

  void attack() {
    if (status[2]) {
      if (type == "wizard") {
        wizardShoot(int(random(4, 15))*1000);
      } else if (type == "witch") {
        witchShoot(int(random(4, 15))*1000);
      }
    }
  }

  void calcVel() {

    if (col.collisionFace[3]) {
      velocity.y = 0;
    } else if (!jumping && !col.collisionFace[3]) {
      acceleration.y = gravityAcceleration;
    }

    if (col.collisionFace[0]) {
      velocity.x = 0;
    }

    if (col.collisionFace[2]) {
      velocity.x = 0;
    }
  }



  void checkInteraction() {
    if (col.playerCollided) {
      effect();
    }
  }

  void effect() {
    if (!character.isInvincible) {
      character.hearts--;
      character.isInvincible = true;
    }
  }

  void checkWounds() {
    if (col.playerAttackCollided && character.keyboardInput[5] && character.attackClock.timeElapsed(character.attackInterval)) {
      hearts--;
    }

    if (hearts <= 0) {
      audio.play("enemydeath");
      gm.enemyList.remove(this);
    }
  }

  void jump() {

    if (jumping) {
      velocity.y = -jumpForce;
    }

    if (jumpClock.timeElapsed(250) || col.collisionFace[1]) {
      jumping = false;
    }
  }
}
