class Obstacle {
  PVector position = new PVector();
  PVector scale = new PVector();
  Collider col;
  String spritePath;
  String type;

  void init(String type, float x, float y, float w, float h) {
    this.type = type;
    this.position.x = x;
    this.position.y = y;
    this.scale.x = w;
    this.scale.y = h;
    if (type == "spike") {
      //sprite momentaneo
      gm.spikeList.add(this);
    }
    else if(type ==  "deathzone"){
       gm.spikeList.add(this);  
    }
    else if(type == "enemybody"){
      
    }
    col = new Collider(position.x, position.y, scale.x, scale.y, "interactable");
    col.objectType = "obstacle";
    col.centerCollider(position, scale);
    col.calcCenterPoint();
    colliderList.add(col);
  }

  void checkInteraction() {
    if (col.playerCollided) {
      effect();
    }
  }

  void effect() {
    if (type == "spike") {
      if (!character.isInvincible) {
        character.hearts--;
        character.isInvincible = true;
      }
    }
    if(type == "deathzone"){
       character.hearts = 0; 
    }
  }
}
