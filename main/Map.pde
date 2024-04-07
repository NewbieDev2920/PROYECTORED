import processing.data.XML; //<>//
import java.util.*;

class Map {
  int mapWidth, mapHeight, tileWidth, tileHeight;
  //campaign or custom
  String type;
  XML xml;
  XML[] objectGroup;
  XML[] colObjects;
  ArrayList<PImage> tileSheets = new ArrayList<PImage>();
  ArrayList<XML> tsxFiles = new ArrayList<XML>();
  static final String SPRITEPATH = "../assets/sprites/";
  String[][] solidMatrix;
  String[][] decorationMatrix;

  Map(String type) {
    this.type = type;
    if (type != "campaign") {
      this.type = "custom";
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

    solidMatrix = new String[mapWidth][mapHeight];
    decorationMatrix = new String[mapWidth][mapHeight];

    objectGroup = xml.getChildren("objectgroup");
    for (int i = 0; i < objectGroup.length; i++) {
      if (objectGroup[i].getString("name").equals("COLISIONES")) {
        colObjects = objectGroup[i].getChildren();
      }
    }
    addCollision();
  }

  void loadTiles() {
    String prePath = "custom";

    if (type == "campaign") {
      prePath = "../maps/campaign/";
    } else if (type == "custom") {
      prePath = "../maps/custom/";
    }

    XML[] xmlTileSets = xml.getChildren("tileset");
    String tsxPath;
    for (int i = 0; i < xmlTileSets.length; i++) {
      tsxPath = xmlTileSets[i].getString("source");
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
      println(newPath);
      sheet = loadImage(SPRITEPATH+(new String(newPath)));
      println(SPRITEPATH+(new String(newPath)));
      tileSheets.add(sheet);
    }
  }

  void loadMapMatrix() {
    XML[] layers =  xml.getChildren("layer");
    String[] data;
    for (int i = 0; i < layers.length; i++) {
      if (layers[i].getString("name").equals("SOLIDOS")) {
        data = layers[i].getChild("data").getContent().split(",");

        for (int j = 0; j < mapHeight; j++) {
          for (int k = 0; k < mapWidth; k++) {
            solidMatrix[k][j] = data[k+j];
          }
        }
      } else if (layers[i].getString("name").equals("DECORACION")) {
        data = layers[i].getChild("data").getContent().split(",");

        for (int j = 0; j < mapHeight; j++) {
          for (int k = 0; k < mapWidth; k++) {
            decorationMatrix[k][j] = data[k+j];
          }
        }
      } else {
        println("This type of layer doesn't exists");
      }
    }
    println("w"+mapWidth);
    println("h"+mapHeight);
    for (int i = 0; i < mapHeight; i++) {
      for (int j = 0; j < mapWidth; j++) { 
      print(solidMatrix[i][j]);
      }
    }
  }
}
