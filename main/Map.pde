import processing.data.XML; //<>// //<>// //<>// //<>//
import java.util.*;


class Map {
  Dictionary<String, PImage> tileDict = new Hashtable<>();
  int mapWidth, mapHeight, tileWidth, tileHeight;
  //campaign or custom
  String type;
  XML xml;
  XML[] objectGroup;
  XML[] colObjects;
  XML[] specialObjects;
  XML[] enemyObjects;
  Dictionary<String, PImage> tileSheets = new Hashtable<>();
  //ArrayList<PImage> tileSheets = new ArrayList<PImage>();
  //String[] firstIDs;
  ArrayList<XML> tsxFiles = new ArrayList<XML>();
  static final String SPRITEPATH = "../assets/sprites/map/";
  String[] solidPseudoMatrix;
  String[] decorationPseudoMatrix;
  String[] backgroundPseudoMatrix;

  Map(String type) {
    this.type = type;
    if (type != "campaign") {
      this.type = "custom";
    }
  }

  void paint() {
    String ID;
    PImage sprite;
    
     for (int i = 0; i < mapHeight; i++) {
      for (int j = 0; j < mapWidth; j++) {
        ID = backgroundPseudoMatrix[i*(mapWidth-1)+j+i];
        if (!ID.equals("0")) {
          sprite = tileDict.get(ID);
          image(sprite, tileWidth*j, tileHeight*i);
        }
      }
    }
    
    for (int i = 0; i < mapHeight; i++) {
      for (int j = 0; j < mapWidth; j++) {
        ID = solidPseudoMatrix[i*(mapWidth-1)+j+i];
        if (!ID.equals("0")) {
          sprite = tileDict.get(ID);
          image(sprite, tileWidth*j, tileHeight*i);
        }
      }
    }

    for (int i = 0; i < mapHeight; i++) {
      for (int j = 0; j < mapWidth; j++) {
        ID = decorationPseudoMatrix[i*(mapWidth-1)+j+i];
        if (!ID.equals("0")) {
          sprite = tileDict.get(ID);
          image(sprite, tileWidth*j, tileHeight*i);
        }
      }
    }
  }

  void addCollision() {
    float x, y, w, h;
    for (XML obj : colObjects) {
      x = obj.getFloat("x");
      y = obj.getFloat("y");
      w = obj.getFloat("width");
      h = obj.getFloat("height");
      Collider col = new Collider(x, y, w, h, "static");
      col.centerCollider(new PVector(x, y), new PVector(w, h));
      col.calcCenterPoint();
      colliderList.add(col);
    }
  }

  void addSpecialObjects() {
    float x, y, w, h;
    String name;
    for (XML obj : specialObjects) {
      name = obj.getString("name");
      x = obj.getFloat("x");
      y = obj.getFloat("y");
      w = obj.getFloat("width");
      h = obj.getFloat("height");
      if ("spawnpoint".equals(name)) {
        gm.spawnPoint = new PVector(x, y);
      } else if ("deathzone".equals(name)) {
        Obstacle o = new Obstacle();
        o.init("deathzone", x, y, w, h);
      } else if ("finish".equals(name)) {
        gm.finishLine.init("level", x, y, w, h);
      } else if ("spike".equals(name)) {
        Obstacle o = new Obstacle();
        o.init("spike", x, y, w, h);
      } else if ("soul".equals(name)) {
        //Se le reduce 8 de anchura y altura, debido a que el tile esta a 16 en Tiled
        int probability = int(random(2));
        if (probability == 1) {
          Collectable c = new Collectable();
          c.init("soul", x, y, w-8, h-8);
        }
      } else if ("heart".equals(name)) {
        Collectable c = new Collectable();
        c.init("heart", x, y, w-8, h-8);
      } else {
        println("OBJETO ESPECIAL NO ENCONTRADO("+name+"), PORFAVOR REVISAR PROYECTO DE TILED");
      }
    }
  }

  void addEnemyObjects() {
    float x, y, w, h;
    String name;
    for (XML obj : enemyObjects) {
      int probability = int(random(3));
      name = obj.getString("name");
      x = obj.getFloat("x");
      y = obj.getFloat("y");
      w = obj.getFloat("width");
      h = obj.getFloat("height");
      if (probability == 1 || probability == 2) {
        if ("black".equals(name)) {
          Enemy e = new Enemy();
          e.init("black", new PVector(x, y), 160);
          gm.enemyList.add(e);
        } else if ("gray".equals(name)) {
          Enemy e = new Enemy();
          e.init("gray", new PVector(x, y), 160);
          gm.enemyList.add(e);
        } else if ("wizard".equals(name)) {
          Enemy e = new Enemy();
          e.init("wizard", new PVector(x, y), 5);
          gm.enemyList.add(e);
        }
        else if("witch".equals(name)){
          Enemy e = new Enemy();
          e.init("witch", new PVector(x,y),5);
          gm.enemyList.add(e);
        }
        else if("tocho".equals(name)){
          Enemy e = new Enemy();
          e.init("tocho", new PVector(x,y),160);
          gm.enemyList.add(e);
        }
      }
    }
  }

  void init(String XMLpath) {

    xml = loadXML(XMLpath);

    mapWidth = xml.getInt("width");
    mapHeight = xml.getInt("height");
    tileWidth = xml.getInt("tilewidth");
    tileHeight = xml.getInt("tileheight");

    solidPseudoMatrix = new String[mapWidth*mapHeight];
    decorationPseudoMatrix = new String[mapWidth*mapHeight];
    backgroundPseudoMatrix = new String[mapWidth* mapHeight];

    objectGroup = xml.getChildren("objectgroup");
    for (int i = 0; i < objectGroup.length; i++) {
      if (objectGroup[i].getString("name").equals("COLISIONES")) {
        colObjects = objectGroup[i].getChildren();
      } else if (objectGroup[i].getString("name").equals("ESPECIAL")) {
        specialObjects = objectGroup[i].getChildren();
      } else if (objectGroup[i].getString("name").equals("ENEMIGOS")) {
        enemyObjects = objectGroup[i].getChildren();
      } else {
        println("CAPA DE OBJETOS NO ENCONTRADA, PORFAVOR REVISAR PROYECTO DE TILED");
      }
    }
    addCollision();
    addSpecialObjects();
    addEnemyObjects();
  }

  void loadTileSheets() {
    String prePath = "custom";

    if (type == "campaign") {
      prePath = "../maps/campaign/";
    } else if (type == "custom") {
      prePath = "../maps/custom/";
    }

    XML[] xmlTileSets = xml.getChildren("tileset");
    String[] firstIDs = new String[xmlTileSets.length];
    String tsxPath;
    for (int i = 0; i < xmlTileSets.length; i++) {
      tsxPath = xmlTileSets[i].getString("source");
      firstIDs[i] = xmlTileSets[i].getString("firstgid");
      tsxFiles.add(loadXML(prePath+tsxPath));
    }

    PImage sheet;
    char[] cuttingPath;
    boolean cutted = false;
    int stringI;
    String newPath;
    for (int i = 0; i < tsxFiles.size(); i++) {
      cutted = false;
      cuttingPath = tsxFiles.get(i).getChild("image").getString("source").toCharArray();
      stringI = cuttingPath.length-1;
      while (!cutted) {
        if (cuttingPath[stringI] == '/') {
          cutted = true;
          stringI++;
        } else {
          stringI--;
        }
      }
      newPath = tsxFiles.get(i).getChild("image").getString("source").substring(stringI, cuttingPath.length);

      sheet = loadImage(SPRITEPATH+(new String(newPath)));

      tileSheets.put(firstIDs[i], sheet);
    }
  }

  void loadMapMatrix() {
    XML[] layers =  xml.getChildren("layer");
    for (int i = 0; i < layers.length; i++) {
      if (layers[i].getString("name").equals("SOLIDOS")) {
        solidPseudoMatrix = layers[i].getChild("data").getContent().split(",");
      } else if (layers[i].getString("name").equals("DECORACION")) {
        decorationPseudoMatrix = layers[i].getChild("data").getContent().split(",");
      }
      else if(layers[i].getString("name").equals("FONDO")){
         backgroundPseudoMatrix = layers[i].getChild("data").getContent().split(","); 
      }
      else {
        println("This type of layer doesn't exists");
      }
    }
  }

  void loadTiles() {
    //POSIBLE ERROR DE TILE INCORRECTO
    PImage tileSprite;
    String ID;
    println("---");
    ArrayList<String> keys = Collections.list(tileSheets.keys());
    for (int i = 0; i < mapHeight; i++) {
      for (int j = 0; j < mapWidth; j++) {
        ID = solidPseudoMatrix[i*(mapWidth-1)+j+i];
        if (!ID.equals("0")) {
          println(ID);
          for (int k = 0; k < tileSheets.size(); k++) {
            PImage tileSheet = tileSheets.get(keys.get(k));
            int[] pos = mapIdtoSheetId(ID, tileSheet);
            tileSprite = tileSheet.get(tileWidth*(pos[0]-1), tileHeight*pos[1], tileWidth, tileHeight);
            tileDict.put(ID, tileSprite);
          }
        }
      }
    }

    for (int i = 0; i < mapHeight; i++) {
      for (int j = 0; j < mapWidth; j++) {
        ID = decorationPseudoMatrix[i*(mapWidth-1)+j+i];
        if (!ID.equals("0")) {
          println(ID);
          for (int k = 0; k < tileSheets.size(); k++) {
            PImage tileSheet = tileSheets.get(keys.get(k));
            int[] pos = mapIdtoSheetId(ID, tileSheet);
            tileSprite = tileSheet.get(tileWidth*(pos[0]-1), tileHeight*pos[1], tileWidth, tileHeight);
            tileDict.put(ID, tileSprite);
          }
        }
      }
    }
    
     for (int i = 0; i < mapHeight; i++) {
      for (int j = 0; j < mapWidth; j++) {
        ID = backgroundPseudoMatrix[i*(mapWidth-1)+j+i];
        if (!ID.equals("0")) {
          println(ID);
          for (int k = 0; k < tileSheets.size(); k++) {
            PImage tileSheet = tileSheets.get(keys.get(k));
            int[] pos = mapIdtoSheetId(ID, tileSheet);
            tileSprite = tileSheet.get(tileWidth*(pos[0]-1), tileHeight*pos[1], tileWidth, tileHeight);
            tileDict.put(ID, tileSprite);
          }
        }
      }
    }
  }

  int[] mapIdtoSheetId(String tileid, PImage sheet) {
    int integer = 0;
    try {
      integer = Integer.parseInt(tileid);
    }
    catch(Exception e) {
      println("papi que cule error ya?");
    }


    int linebreak = sheet.width/tileWidth;
    int row = (int)Math.floor(integer/linebreak);
    int column = (int)(integer-row*linebreak);
    int[] pos = new int[2];
    pos[0] = column;
    pos[1] = row;

    return pos;
  }
}
