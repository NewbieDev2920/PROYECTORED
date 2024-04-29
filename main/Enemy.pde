class Enemy {
  //patrol, chase
  boolean[] status = {true, false};
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
      chaseSpeed = 4;
      scale.x = 20;
      scale.y = 40;
      hearts = 10;
      this.visionRange = 100;
    } else if (type == "gray") {
      patrolSpeed = 0.5;
      scale.x = 20;
      scale.y = 50;
      hearts = 1;
    } else {
      println("este tipo de enemigo no existe");
    }
    col = new Collider(position.x, position.y, scale.x, scale.y, "mobile");
    col.centerCollider(position, character.scale);
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
        fill(255, 255, 0);
        rect(position.x, position.y, scale.x, scale.y);
        shoot(5000);
      }
      checkWounds();
    }
  }

  void shoot(int interval) {
    if (shootingClock.timeElapsed(interval)) {
      Proyectile kunai = new Proyectile();
      kunai.init("lineal", position, character.position, 5);
      gm.bulletList.add(kunai);
    }
  }

  void patrol() {
    if (status[0]) {
      //Ronda de vigilancia
      if (position.x >= centralPoint.x + patrolRadius) {
        if (patrolClock.timeElapsed(1000)) {
          direction = -1;
          position.x -= patrolSpeed;
        }
      } else if (position.x <= centralPoint.x - patrolRadius) {
        if (patrolClock.timeElapsed(1000)) {
          direction = 1;
          position.x += patrolSpeed;
        }
      } else {

        if (direction == 1) {
          position.x += patrolSpeed;
        } else {
          position.x -= patrolSpeed;
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
    int offset = 15;
    if (status[1]) {
      if (position.x > character.position.x + offset) {
        position.x -= chaseSpeed;
      } else if (position.x < character.position.x - offset) {
        position.x += chaseSpeed;
      }
    }
  }

  void attack() {
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
    if (col.playerAttackCollided && character.keyboardInput[5]) {
      hearts--;
    }

    if (hearts <= 0) {
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
