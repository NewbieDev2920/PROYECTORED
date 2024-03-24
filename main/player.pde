class Player {
  PVector position = new PVector();
  PVector velocity = new PVector();
  float speed =4;
  PVector scale = new PVector();
  //0: Right, 1: Up, 2: Left, 3: Down
  boolean[] keyboardInput = {false, false, false, false};
  String type = "player";
  int id;
  Collider col;



  Player(float x, float y, float w, float h) {
    this.position.x = x;
    this.position.y = y;
    this.scale.x = w;
    this.scale.y = h;
  }

  void display() {
    fill(25, 25, 255);
    rect(position.x, position.y, scale.x, scale.y);
  }

  void move() {
    calcVelocity();
    position.x += velocity.x;
    position.y += velocity.y;
    col.origin.x = position.x + col.centerGap.x;
    col.origin.y = position.y + col.centerGap.y;
    col.checkCollision();
  }

  void calcVelocity() {

    if (keyboardInput[0] && keyboardInput[2]) {
      velocity.x = 0;
    } else if (keyboardInput[0]) {
      velocity.x = speed;
    } else if (keyboardInput[2]) {
      velocity.x = -speed;
    } else {
      velocity.x = 0;
    }

    if (keyboardInput[1] && keyboardInput[3]) {
      velocity.y = 0;
    } else if (keyboardInput[1]) {
      velocity.y = -speed;
    } else if (keyboardInput[3]) {
      velocity.y = speed;
    } else {
      velocity.y = 0;
    }
  }

  void init() {
    col = new Collider(position.x, position.y, scale.x, scale.y, "mobile");
    col.centerCollider(position, scale);
    col.borderThickness = 0.2;
  }
}
