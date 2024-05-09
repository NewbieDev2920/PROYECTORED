class Proyectile {
  String proyectileSprite;
  Sprite sprite = new Sprite();
  float angle = -PI/3;
  float speed;
  float birth;
  float gravityAcceleration = 0.02;
  PVector origin = new PVector();
  PVector target = new PVector();
  PVector position = new PVector();
  PVector velocity = new PVector();
  PVector acceleration = new PVector();
  int lifeTime;
  Collider col;
  Clock lifeTimeClock = new Clock();
  //lineal
  String type;

  void init(String type, PVector origin, PVector target, float speed) {
    this.type = type;
    this.origin.x = origin.x;
    this.origin.y = origin.y;
    this.position.x = origin.x;
    this.position.y = origin.y;
    this.target.x = target.x;
    this.target.y = target.y;
    this.speed = speed;
    this.velocity.y = 0;
    this.velocity.x = 0;
    this.lifeTime = 60*1000;
    if (type == "lineal") {
      calcLinealShotVel();
    } else if (type == "parabolic") {
      velocity.x = speed*cos(angle);
      this.birth = millis();
    }
    sprite.init("player/default.png");
    
    if (proyectileSprite == "red") {
      sprite.addAnimation("enemies/proyectiles/redspell.png", 16, 32);
    }
    else if(proyectileSprite == "redleft"){
      sprite.addAnimation("enemies/proyectiles/redspellleft.png", 16, 32);
    }
    else if (proyectileSprite == "blue") {
      sprite.addAnimation("enemies/proyectiles/waterspell.png", 16, 32);
    }else if(proyectileSprite == "blueup"){
      sprite.addAnimation("enemies/proyectiles/waterspellup.png", 11, 29);
    }
    else if (proyectileSprite == "green") {
      sprite.addAnimation("enemies/proyectiles/greenspell.png", 16);
    }
    
    col = new Collider(position.x, position.y, 8, 8, "mobile");
    col.borderThickness = 0.2;
    colliderList.add(col);
  }


  void calcLinealShotVel() {
    //Calcula la velocidad del proyectil
    velocity.y = target.y-origin.y+character.scale.y/2  ;
    velocity.x = target.x-origin.x;
    velocity.normalize();
    velocity.y *= speed * gm.gameSpeedMultiplier;
    velocity.x *= speed * gm.gameSpeedMultiplier;
  }

  void calcParabolicShotVel() {
    float actualTime = millis()-birth;
    velocity.y = speed*sin(angle)+gravityAcceleration*actualTime;
  }

  void move() {
    if (type == "lineal") {
      position.add(velocity);
      col.origin.x = position.x + col.centerGap.x;
      col.origin.y = position.y + col.centerGap.y;
      checkInteraction();
      display();
    } else if (type == "parabolic") {
      position.add(velocity);
      calcParabolicShotVel();
      col.origin.x = position.x + col.centerGap.x;
      col.origin.y = position.y + col.centerGap.y;
      display();
    }
    
    checkLifeTime();
  }

  void display() {
    sprite.play(0,300, position);
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

  void checkLifeTime() {
    if (lifeTimeClock.timeElapsed(lifeTime)) {
      colliderList.remove(this.col);
      gm.bulletList.remove(this);
    }
  }

  void displaySprite() {
    if (proyectileSprite == "red") {
    } else if (proyectileSprite == "blue") {
    } else if (proyectileSprite == "green") {
    }
  }
}
