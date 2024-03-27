class Block {
  PVector position = new PVector();
  PVector scale = new PVector();
  //Tipo solid o tipo decoration
  String type;
  Collider col;


  Block(float x, float y, float w, float h, String type) {
    if (type == "solid") {
      this.col = new Collider(x, y, w, h, "static");
      this.type = "solid";
    } else {
      this.type = "decoration";
    }
    this.position.x =  x;
    this.position.y = y;
    this.scale.x = w;
    this.scale.y = h;
  }

  void display() {
    fill(100);
    rect(position.x, position.y, scale.x, scale.y);
  }

  void init() {
    if (type == "solid") {
      colliderList.add(col);
      col.centerCollider(position, scale);
      col.calcCenterPoint();
    } else {
    }
  }
}
