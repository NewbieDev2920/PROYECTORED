/* //<>//
 ---------------------------
 | PROYECTO ALGORITMIA 2   |
 | VIDEOJUEGO ESTILO SONIC |
 | VIDEOJUEGO NINJA        |
 ---------------------------
 **************************
 CREDITOS
 **************************
 DESARROLLADORES
 #  ALEJANDRO CUELLO
 #  CARLOS DE LA ROSA
 #  MARIA ANGEL MARTINEZ
 PROFESOR
 #  DALADIER
 SPRITES
 # @acewaydev, @Darkeyed19 (NINJA ASSET PACK)
 # @ScatteredReality https://www.spriters-resource.com/pc_computer/eviltonight/sheet/198282/
 
 ------------------------
 ASPECTOS A DESARROLLAR
 ------------------------
 $ Mejorar el sistema de colisiones
 $ Añadir animaciones
 $ Añadir sistema de audio
 $ Mapa pulir
 
 */

//Paquetes
//------------------------------------------------------------

//------------------------------------------------------------



//Inicializacion de objetos
//------------------------------------------------------------
GameManager gm = new GameManager();
Player character = new Player(2, 2, 30, 31);
GUI gui = new GUI(120, 100, 190, 60);
public ArrayList<Collider> colliderList = new ArrayList<Collider>();
public ArrayList<Collectable> soulList = new ArrayList<Collectable>();
public ArrayList<Obstacle> obstacleList = new ArrayList<Obstacle>();
Map map = new Map("campaign");
Collectable soul1 = new Collectable();
Collectable soul2 = new Collectable();
Obstacle spike1 = new Obstacle();
FinishLine door = new FinishLine();

PImage testImage;
//------------------------------------------------------------

void setup() {
  textSize(8);
  fullScreen(P3D);
  noSmooth();
  noStroke();
  map.init("../maps/campaign/newmap.tmx");
  map.loadTileSheets();
  map.loadMapMatrix();
  map.loadTiles();
  //mapFile = new Ptmx(this, "tileddemo1.tmx");
  //gm.addCollidersToMap(mapFile);
  gui.debugEnabled = true;
  gui.init();
  character.init();
  soul1.init("soul", 600, 200, 16, 16);
  soul2.init("soul", 700,200,16,16);
  spike1.init("spike", 400, 200, 16, 16);
  door.init("level",800, 200, 16, 16);
}

void draw() {
  if (gui.currentScene == "game") {
    background(179, 215, 255);
    //mapFile.draw();
    map.paint();
    character.updateDebug();
    soul1.checkInteraction();
    soul2.checkInteraction();
    spike1.checkInteraction();
    door.checkInteraction();
    character.move();
    character.display();
    gm.centerCamera(character);
    gm.checkStatus();
    gui.updatePosition(character.position);
    gui.debugDisplay();
    gui.displayGameData(character.hearts, character.soulScore);
    camera(character.position.x, character.position.y, 400, character.position.x, character.position.y, 0, 0, 1, 0);
  }
  else if(gui.currentScene == "dead"){
    gui.deadScreen();
    camera(character.position.x, character.position.y, 1500, character.position.x, character.position.y, 0, 0, 1, 0);
  }
  else if(gui.currentScene == "victory"){
    gui.victoryScreen();
    camera(character.position.x, character.position.y, 1500, character.position.x, character.position.y, 0, 0, 1, 0);
  }
  else if(gui.currentScene == "shop"){
    gui.shopScreen();
    camera(character.position.x, character.position.y, 1500, character.position.x, character.position.y, 0, 0, 1, 0);
    
  }
  else{
     println("Scene: "+gui.currentScene+" doesn't exists"); 
  }
}

//--------------------------------------------------
//HANDLE INPUT
//--------------------------------------------------
void keyPressed() {
  if (key == 'd' || keyCode == RIGHT) {
    character.keyboardInput[0] = true;
  } else if (key == 'w' || keyCode == UP) {
    character.keyboardInput[1] = true;
  } else if ( key == 'a' || keyCode == LEFT) {
    character.keyboardInput[2] = true;
  } else if (key == 's' || keyCode == DOWN) {
    character.keyboardInput[3] = true;
  }
  else if(keyCode == ENTER){
     character.keyboardInput[4] = true; 
  }
}

void keyReleased() {
  if (key == 'd' || keyCode == RIGHT) {
    character.keyboardInput[0] = false;
  } else if (key == 'w' || keyCode == UP) {
    character.keyboardInput[1] = false;
  } else if (key == 'a' || keyCode == LEFT) {
    character.keyboardInput[2] = false;
  } else if (key == 's' || keyCode == DOWN) {
    character.keyboardInput[3] = false;
  }
  else if(keyCode == ENTER){
      character.keyboardInput[4] = false;
  }
}
//--------------------------------------------------
