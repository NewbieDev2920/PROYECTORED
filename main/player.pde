class Player {
  Sprite sprite = new Sprite();
  PVector position = new PVector();
  PVector velocity = new PVector();
  PVector scale = new PVector();
  float speed =5;
  //Distance/frames (60 frames = 1s)
  float jumpForce = 7;
  boolean jumping;
  int time;
 
  //0: Right, 1: Up, 2: Left, 3: Down
  boolean[] keyboardInput = {false, false, false, false};
  Collider col;



  Player(float x, float y, float w, float h) {
    this.position.x = x;
    this.position.y = y;
    this.scale.x = w;
    this.scale.y = h;
  }

  void display() {
    fill(25, 25, 255);
    image(sprite.image, position.x, position.y);
  }

  void move() {
    calcVelocity();
    applyGravity();
    position.x += velocity.x;
    jump();
    position.y += velocity.y;
    col.origin.x = position.x + col.centerGap.x;
    col.origin.y = position.y + col.centerGap.y;
    col.checkCollision();
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
      //Jump
      
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

  void init() {
    col = new Collider(position.x, position.y, scale.x, scale.y, "mobile");
    col.centerCollider(position, scale);
    col.borderThickness = 0.2;
    sprite.init();
    debug.msgList.add(0, "Pos("+position.x+","+position.y+")");
    debug.msgList.add(1, "Vel("+velocity.x+","+velocity.y+")");
    debug.msgList.add(2, "speed("+speed+") jumpForce("+jumpForce+")");
    debug.msgList.add(3, "keyInpt{"+keyboardInput[0]+","+keyboardInput[1]+","+keyboardInput[2]+","+keyboardInput[3]+"}");
    debug.msgList.add(4, "collFace{"+col.collisionFace[0]+","+col.collisionFace[1]+","+col.collisionFace[2]+","+col.collisionFace[3]+"}");
    debug.msgList.add(5, "FPS ("+frameRate+")");
  }

  void updateDebug() {
    debug.msgList.set(0, "Pos("+position.x+","+position.y+")");
    debug.msgList.set(1, "Vel("+velocity.x+","+velocity.y+")");
    debug.msgList.set(2, "speed("+speed+") jumpForce("+jumpForce+")");
    debug.msgList.set(3, "keyInpt{"+keyboardInput[0]+","+keyboardInput[1]+","+keyboardInput[2]+","+keyboardInput[3]+"}");
    debug.msgList.set(4, "collFace{"+col.collisionFace[0]+","+col.collisionFace[1]+","+col.collisionFace[2]+","+col.collisionFace[3]+"}");
    debug.msgList.set(5, "FPS ("+frameRate+")");
  }
  
  void jump(){
    if(jumping){
      velocity.y = -jumpForce;
    }
    else{
      time = millis(); 
    }
    
    if(millis() > time+150){
      jumping = false; 
    }
    
  }
  
  
  
  
}
