class Collectable {
  boolean enabled = true;
  PVector position = new PVector();
  PVector scale = new PVector();
  Collider col;
  Sprite sprite = new Sprite();
  String spritePath = "collectables/";
  String type;

  void init(String type, float x, float y, float w, float h) {
    this.type = type;
    this.position.x = x;
    this.position.y = y;
    this.scale.x = w;
    this.scale.y = h;
    if (type == "soul") {
      spritePath = spritePath+type+".png";
      gm.soulList.add(this);
    } else if (type == "heart") {
      //../assets/sprites/gui/red.png
      spritePath = spritePath+type+".png";
      gm.heartList.add(this);
    }
    sprite.init(spritePath);
    col = new Collider(position.x, position.y, scale.x, scale.y, "interactable");
    col.objectType = "collectable";
    col.centerCollider(position, scale);
    col.calcCenterPoint();
    colliderList.add(col);
  }

  void checkInteraction() {
    if (enabled) {
      sprite.display(position);
      if (col.playerCollided) {
        effect();
      }
    }
  }

  void effect() {
    if (type == "soul") {
      character.soulScore++;
      enabled = false;
      gm.soulList.remove(this);
    }
    else if(type == "heart"){
      if(character.hearts < 3){
        character.hearts++;
        enabled = false;
        gm.heartList.remove(this);
      }
      
    }
  }
}
