class GameManager {
  StringDict[] objList;
  void addCollidersToMap(Ptmx mapFile) {
    objList = mapFile.getObjects(1);
    for (StringDict obj : objList) {
      float x = Float.parseFloat(obj.get("x"));
      float y = Float.parseFloat(obj.get("y"));
      float w = Float.parseFloat(obj.get("width"));
      float h = Float.parseFloat(obj.get("height"));
      Collider col = new Collider(x, y, w, h, "static");
      colliderList.add(col);
      col.calcCenterPoint();
    }
  }

  void centerCamera(Player character) {
    
    
  }
}
