class Enemy {
  int hearts;
  int patrolRadius;
  int chaseRadius;
  int attackRadius;
  int direction = 1;
  float gravityAcceleration = 0.2;
  float speed;
  Sprite sprite;
  PVector centralPoint = new PVector();
  PVector position = new PVector();
  PVector velocity = new PVector();
  PVector acceleration = new PVector();
  PVector scale = new PVector();
  String type;
  Obstacle harmfulBody = new Obstacle();
  Clock patrolClock = new Clock();
  Collider col;


  void init(String type, PVector centralPoint, int patrolRadius) {
    this.type = type;
    this.centralPoint = centralPoint;
    this.patrolRadius = patrolRadius;
    this.position.x = centralPoint.x;
    this.position.y = centralPoint.y;

    if (type == "black") {
      speed = 0.5;
      scale.x = 20;
      scale.y = 15;
    } else {
      println("este tipo de enemigo no existe");
    }
    col = new Collider(position.x, position.y, scale.x, scale.y, "mobile");
    col.centerCollider(position, character.scale);
    col.borderThickness = 0.2;
  }

  void move() {
    patrol();
    col.checkCollision();
    calcVel();
    position.add(velocity);
    velocity.add(acceleration);
    col.origin.x = position.x + col.centerGap.x;
    col.origin.y = position.y + col.centerGap.y;
    fill(255, 0, 0);
    rect(position.x, position.y, scale.x, scale.y);
  }

  void patrol() {

    if (position.x >= centralPoint.x + patrolRadius) {
      if(patrolClock.timeElapsed(1000)){
          direction = -1;  
          position.x -=speed;
      }
      
    } else if (position.x <= centralPoint.x - patrolRadius) {
      if(patrolClock.timeElapsed(1000)){
          direction = 1;  
          position.x += speed;
      }
    } else {

      if (direction == 1) {
        position.x += speed;
      } else {
        position.x -=speed;
      }
    }
  }

  void chase() {
  }

  void attack() {
  }
  
  void calcVel(){
    
    if (col.collisionFace[3]) {
      velocity.y = 0;
    }
    else {
      acceleration.y = gravityAcceleration;
    } 
    
  }
  
  void checkInteraction(){
    if (col.playerCollided) {
      effect();
    }
  }
  
  void effect(){
     if (!character.isInvincible) {
        character.hearts--;
        character.isInvincible = true;
      }
  }
}
