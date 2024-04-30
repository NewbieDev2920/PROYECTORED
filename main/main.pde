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
 $ Mejorar el sistema de colisiones (C)
 $ Diseñar y terminar el menu (A y C)
 $ diseñar y terminar el GUI (A)
 $ Añadir animaciones (M y C)
 $ Añadir sistema de audio (M)
 $ Añadir las otras capas del Mapa (C)
 $ Añadir aceleracion gravitacional (Puede que tambien de movimiento) (C)
 $ Añadir Enemigos (C)
 
 */

//Paquetes
//------------------------------------------------------------

//------------------------------------------------------------



//Inicializacion de objetos
//------------------------------------------------------------

GameManager gm = new GameManager();
public ArrayList<Collider> colliderList = new ArrayList<Collider>();
Audio audio = new Audio();
Player character;
GUI gui = new GUI(120, 100, 190, 60);
Map map = new Map("campaign");


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
  audio.init();
  gui.debugEnabled = true;
  gui.init();
  character =  new Player(gm.spawnPoint.x,gm.spawnPoint.y , 30, 31);
  character.init();
}

void draw() {
  if (gui.currentScene == "game") {
    background(12,0,22);
    map.paint();
    character.updateDebug();
    gm.specialsUpdate();
    character.move();
    gm.checkStatus();
    gui.updatePosition(character.position);
    gui.debugDisplay();
    gui.displayGameData(character.hearts, character.soulScore);
    
    camera(character.position.x, character.position.y, 600, character.position.x, character.position.y, 0, 0, 1, 0);
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
  else if(key == 'z'){
     character.keyboardInput[5] = true; 
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
  else if(key == 'z'){
     character.keyboardInput[5] = false; 
  }
}
//--------------------------------------------------
