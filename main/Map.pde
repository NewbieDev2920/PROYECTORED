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
  Dictionary<String, PImage> tileSheets = new Hashtable<>();
  //ArrayList<PImage> tileSheets = new ArrayList<PImage>();
  //String[] firstIDs;
  ArrayList<XML> tsxFiles = new ArrayList<XML>();
  static final String SPRITEPATH = "../assets/sprites/map/";
  String[] solidPseudoMatrix;
  String[] decorationPseudoMatrix;

  Map(String type) {
    this.type = type;
    if (type != "campaign") {
      this.type = "custom";
    }
  }

  void paint() {
    //POSIBLE ERRROR DE TILE MAL DIBUJADO
    String ID;
    PImage sprite;
    for (int i = 0; i < mapHeight; i++) {
      for (int j = 0; j < mapWidth; j++) {
        ID = solidPseudoMatrix[i*(mapWidth-1)+j+i];
        if (!ID.equals("0")) {
          sprite = tileDict.get(ID);
          image(sprite, tileWidth*j, tileHeight*i);
        }
      }
    }
  }

  void addCollision() {
    PVector position = new PVector();
    PVector scale = new PVector();
    for (XML obj : colObjects) {
      position.x = obj.getFloat("x");
      position.y = obj.getFloat("y");
      scale.x = obj.getFloat("width");
      scale.y = obj.getFloat("height");
      Collider col = new Collider(position.x, position.y, scale.x, scale.y, "static");
      col.centerCollider(position, scale);
      col.calcCenterPoint();
      colliderList.add(col);
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

    objectGroup = xml.getChildren("objectgroup");
    for (int i = 0; i < objectGroup.length; i++) {
      if (objectGroup[i].getString("name").equals("COLISIONES")) {
        colObjects = objectGroup[i].getChildren();
      }
    }
    addCollision();
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
        print(solidPseudoMatrix);
      } else if (layers[i].getString("name").equals("DECORACION")) {
        decorationPseudoMatrix = layers[i].getChild("data").getContent().split(",");
      } else {
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
          //EL PROBLEMA ESTA EN EL PIMAGE.GET()
          for (int k = 0; k < tileSheets.size(); k++) {
            PImage tileSheet = tileSheets.get(keys.get(k));
            int[] pos = mapIdtoSheetId(ID, tileSheet);
            tileSprite = tileSheet.get(tileWidth*(pos[0]-1), tileHeight*pos[1], tileWidth, tileHeight);
            tileDict.put(ID, tileSprite);
            /*if (k == keys.size()-1) {
             tileSprite = tileSheets.get(keys.get(k)).get(tileWidth*j, tileHeight*i, tileWidth, tileHeight);
             tileDict.put(ID, tileSprite);
             } else if (Integer.parseInt(ID) >= Integer.parseInt(keys.get(k)) && Integer.parseInt(ID) <= Integer.parseInt(keys.get(k+1))) {
             tileSprite = tileSheets.get(keys.get(k)).get(tileWidth*j, tileHeight*i, tileWidth, tileHeight);
             tileDict.put(ID, tileSprite);*/
          }
        }
      }
    }
  }

  int[] mapIdtoSheetId(String tileid, PImage sheet) {
    int integer = 0;
    try{
      integer = Integer.parseInt(tileid);
    }
    catch(Exception e){
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
