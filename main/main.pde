/*
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
 #  ?
 PROFESOR
 #  DALADIER
 SPRITES
 # @acewaydev, @Darkeyed19 (NINJA ASSET PACK)
 # @ScatteredReality https://www.spriters-resource.com/pc_computer/eviltonight/sheet/198282/
 
 
 */

Player character = new Player(50, 150, 50, 50);
Block bloque1 = new Block(20, 300, 600, 50, "solid");
Block bloque2 = new Block(100, 250, 30, 50, "solid");
Debug debug = new Debug("bottomLeft", 250, 300);
public ArrayList<Collider> colliderList = new ArrayList<Collider>();

void setup() {
  fullScreen();
  debug.enabled = true;
  debug.init();
  bloque1.init();
  bloque2.init();
  character.init();
}

void draw() {
  background(230);
  bloque1.display();
  bloque2.display();
  character.updateDebug();
  character.move();
  character.display();
  debug.display();
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
