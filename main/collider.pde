class Collider {
  //borderThickness in percentage
  float borderThickness;
  PVector origin = new PVector();
  PVector scale = new PVector();
  PVector centerGap = new PVector();
  PVector deltaTarget = new PVector();
  //Tipo mobile o tipo static
  String type;
  //Por ahora solo rectangulo, sin embargo se puede añadir circunferencia.
  String shape = "rectangle";

  Collider(float x, float y, float w, float h, String type) {
    this.origin.x = x;
    this.origin.y = y;
    this.scale.x = w;
    this.scale.y = h;
    this.type = type;
  }

  void checkCollision() {
    if (type == "mobile") {
      for (int i = 0; i < colliderList.size(); i++) {
        Collider target = colliderList.get(i);
        boolean lateralFace = origin.x + scale.x > target.origin.x && origin.x < target.origin.x + target.scale.x;
        boolean frontalFace = origin.y + scale.y > target.origin.y && origin.y < target.origin.y + target.scale.y;
        if (lateralFace && frontalFace) {
          //detectar las componentes y asi detectar el lado de colision.

          deltaTarget.y = target.origin.y - origin.y;
          deltaTarget.x = target.origin.x - origin.x;
        }
      }
    } else {
      println("Los colliders tipo static no pueden utilizar el metodo checkCollision()");
    }
  }

  void centerCollider(PVector objectPos, PVector objectScale) {
    //Metodo para ajustar el collider al centro de un objeto.
    centerGap.x = objectPos.x - origin.x + objectScale.x/2 - scale.x/2;
    centerGap.y = objectPos.y - origin.y + objectScale.y/2 - scale.y/2;
  }
}
