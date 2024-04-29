class Physics {
  PVector position = new PVector(35, 0);
  PVector velocity = new PVector();
  PVector acceleration = new PVector();
  float gravityAcceleration = 0.2;
  float speed = 5;
  float jumpForce = 5;
  boolean jumping = false;
  Clock jumpClock = new Clock();
  Clock walkAudioClock = new Clock();
  Collider col;

  void init() {
    col = new Collider(position.x, position.y, character.scale.x, character.scale.y, "mobile");
    col.centerCollider(position, character.scale);
    col.borderThickness = 0.2;
  }

  void displayRect() {
    fill(250, 20, 20);
    rect(position.x, position.y,character.scale.x, character.scale.y);
  }

  void calcVel() {

    if (character.keyboardInput[0] && character.keyboardInput[2]) {
      velocity.x = 0;
    } else if (character.keyboardInput[0] && !col.collisionFace[0]) {
      velocity.x = speed;
      character.direction = 1;
      if(walkAudioClock.timeElapsed(500)){
        audio.play("walk");  
      }
      
    } else if (character.keyboardInput[2] && !col.collisionFace[2]) {
      velocity.x = -speed;
      character.direction = -1;
      if(walkAudioClock.timeElapsed(500)){
        audio.play("walk");  
      }
    } else {
      velocity.x = 0;
    }


    if (character.keyboardInput[1] && !col.collisionFace[1] && col.collisionFace[3]) {
        jumping = true;
        audio.play("jump");
    }
    
    if(col.collisionFace[1]){
       velocity.y = 1;
       jumping = false;
    }
    
    if (col.collisionFace[3]) {
      velocity.y = 0;
    }
    else {
      acceleration.y = gravityAcceleration;
    }
  }

  void move() {
    col.checkCollision();
    calcVel();
    jump();
    position.add(velocity);
    velocity.add(acceleration);
    col.origin.x = position.x + col.centerGap.x;
    col.origin.y = position.y + col.centerGap.y;
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
