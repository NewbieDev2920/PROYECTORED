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
  Collider col;
  boolean jumping;
  float jumpForce;


  void init(String type, PVector centralPoint, int patrolRadius) {
    this.type = type;
    this.centralPoint = centralPoint;
    this.patrolRadius = patrolRadius;
    this.position.x = centralPoint.x;
    this.position.y = centralPoint.y;

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
    } else if (type == "wizard") {
      patrolSpeed = 0.5;
      chaseSpeed = 0.5;
      scale.x = 20;
      scale.y = 50;
      hearts = 1;
      this.visionRange = 500;
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
        fill(255, 255, 0);
        rect(position.x, position.y, scale.x, scale.y);
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

  void wizardShoot(int interval) {
    if (shootingClock.timeElapsed(interval)) {
      for (int i = 0; i < 8; i++) {
        Proyectile magicBall = new Proyectile();
        magicBall.init("lineal", position, new PVector(position.x + 50*cos(i*QUARTER_PI), position.y + 50*sin(i*QUARTER_PI)), 3);
        gm.bulletList.add(magicBall);
      }
    }
  }

  void patrol() {
    if (status[0]) {
      //Ronda de vigilancia
      if (position.x >= centralPoint.x + patrolRadius) {
        if (patrolClock.timeElapsed(1000)) {
          direction = -1;
          position.x -= patrolSpeed * gm.gameSpeedMultiplier;
        }
      } else if (position.x <= centralPoint.x - patrolRadius) {
        if (patrolClock.timeElapsed(1000)) {
          direction = 1;
          position.x += patrolSpeed * gm.gameSpeedMultiplier;
        }
      } else {

        if (direction == 1) {
          position.x += patrolSpeed * gm.gameSpeedMultiplier;
        } else {
          position.x -= patrolSpeed * gm.gameSpeedMultiplier;
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
    if (type != "wizard") {
      int offset = 15;
      if (status[1]) {
        if (position.x > character.position.x + offset) {
          position.x -= chaseSpeed * gm.gameSpeedMultiplier;
        } else if (position.x < character.position.x - offset) {
          position.x += chaseSpeed * gm.gameSpeedMultiplier;
        }
      }
    } else if (type == "wizard") {
      if(status[1]){
        status[1] = false;
        status[2] = true;
         attack(); 
      }
    }
  }

  void attack() {
    if (status[2]) {
      if (type == "wizard") {
        wizardShoot(int(random(4, 15))*1000);
      }
    }
  }

  void calcVel() {

    if (col.collisionFace[3]) {
      velocity.y = 0;
    } else {
      acceleration.y = gravityAcceleration;
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
