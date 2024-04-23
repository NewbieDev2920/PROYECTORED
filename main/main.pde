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
import ptmx.*;
//------------------------------------------------------------



//Inicializacion de objetos
//------------------------------------------------------------
GameManager gm = new GameManager();
Player character = new Player(2, 2, 50, 50);
Debug debug = new Debug("bottomLeft", 250, 300);
public ArrayList<Collider> colliderList = new ArrayList<Collider>();
Ptmx mapFile;
Map map = new Map("campaign");

PImage testImage;
//------------------------------------------------------------

void setup() {
  textSize(8);
  fullScreen(P3D);
  smooth(0);
  map.init("../maps/campaign/testmap2.tmx");
  map.loadTileSheets();
  map.loadMapMatrix();
  map.loadTiles();
  //mapFile = new Ptmx(this, "tileddemo1.tmx");
  //gm.addCollidersToMap(mapFile);
  debug.enabled = true;
  debug.init();
  character.init();
}

void draw() {
  background(179,215,255);
  //mapFile.draw();
  map.paint();
  character.updateDebug();
  character.move();
  character.display();
  gm.centerCamera(character);
  debug.display();
  camera(character.position.x, character.position.y, 300, character.position.x, character.position.y, 0, 0, 1, 0);
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
}
//--------------------------------------------------
