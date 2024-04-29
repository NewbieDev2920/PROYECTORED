class Proyectile {
  float speed;
  PVector origin = new PVector();
  PVector target = new PVector();
  PVector position = new PVector();
  PVector velocity = new PVector();
  PVector acceleration = new PVector();
  Collider col;
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
    if (type == "lineal") {
      calcLinealShotVel();
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
    velocity.y *= speed;
    velocity.x *= speed;
  }

  void move() {
    if (type == "lineal") {
      position.add(velocity);
      col.origin.x = position.x + col.centerGap.x;
      col.origin.y = position.y + col.centerGap.y;
      display();
    }
  }

  void display() {
    fill(255, 0, 0);
    rect(position.x, position.y, 7, 7);
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
}
