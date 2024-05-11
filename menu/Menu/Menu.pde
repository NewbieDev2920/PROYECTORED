import processing.sound.*; //<>//
import java.io.File;
PImage background;
PImage splash;
SoundFile music;
Button play = new Button(437, 162, 101, 40, "play");
Button settings = new Button(412, 206, 158, 30, "settings");
Button credits = new Button(414, 243, 156, 27, "credits");
Button howToPlay = new Button(414, 280, 156, 27, "howtoplay"); // New button
Button back = new Button(120, 90, 156, 27, "return");
Button musicOff = new Button(270,400, 158,30 ,"Music Off");
Button musicOn = new Button(270,480, 158,30 ,"Music On");
String currentScene = "mainmenu";
GameLoader gameload = new GameLoader();

void setup() {
  size(982, 572, P3D);
  background(0);
  splash = loadImage("../assets/splashscreen.jpg");
  image(splash, width/2-150, height/2-150);
  delay(3000);
  background = loadImage("../assets/menubackground.jpeg");
  music = new SoundFile(this, "../assets/menuMusic.mp3");
  music.play();
}

void draw() {

  if (currentScene == "mainmenu") {
    image(background, 13, 0);
    // Display new button

    /*if (play.hovered()) {
     play.highlight();
     } else if (settings.hovered()) {
     settings.highlight();
     } else if (credits.hovered()) {
     credits.highlight();
     } else if (howToPlay.hovered()) {
     howToPlay.highlight();
     }*/

    if (play.clicked()) {
      println("play");
      currentScene = "browser";
    } else if (settings.clicked()) {
      println("settings");
      currentScene = "settings";
    } else if (credits.clicked()) {
      println("credits");
      currentScene = "credits";
    } else if (howToPlay.clicked()) {
      println("howToPlay");
      currentScene = "howToPlay";
    }
  } else if (currentScene == "browser") {
    gameload.actualMap();
    fill(255);
    rect(30, 0, 300, 50);
    fill(0);
    text("Actual map: "+gameload.actualMap, 35, 25);
    fill(50);
    rect(width/4, 160, width/2, width/2);
    listButtons(browseMaps(), 270, 100, 40);
    back.display();
    if (back.clicked()) {
      currentScene = "mainmenu";
    }
  } else if (currentScene == "settings") {
    fill(50);
    rect(width/4, 157, width/2, width/2);
    back.display();
    musicOff.display();
    musicOn.display();
    if(musicOff.clicked()){
      music.amp(0);
    }
    
    if(musicOn.clicked()){
      music.amp(1); 
    }
    if (back.clicked()) {
      currentScene = "mainmenu";
    }
    
  } else if (currentScene == "credits") {
    fill(50);
    rect(width/4, 157, width/2, width/2);
    fill(240, 20, 20);
    textSize(9);
    text("DESARROLLADORES : ALEJANDRO CUELLO, CARLOS DE LA ROSA, DALADIER", width/4+50, 200);
    text("SPRITES : @acewaydev, @Darkeyed19 @ @ScatteredReality, @Chierit, @Matzz Art", width/4+50, 230);
    text("@Bdragon1727, ClockWork Raven, Anokolisa", width/4+50, 260);
    text("MUSICA : @LUCA FRANCINI, @Gigakoops", width/4+50, 290);
    textSize(8);
    text("https://chierit.itch.io/boss-demon-slime", width/4+50, 320);
    text("https://freemusicarchive.org/music/gigakoops/blood-tastes-better-than-water", width/4+50, 350);
    text("https://clockworkraven.itch.io/rpg-icon-pack-jewels-and-gems", width/4+50, 380);
    text("https://bdragon1727.itch.io/free-effect-and-bullet-16x16", width/4+50, 410);
    text("https://anokolisa.itch.io", width/4+50, 440);
    text("https://www.storyblocks.com/audio/search/8-bit?media-type=sound-effects", width/4+50, 470);
    textSize(13);
    back.display();
    if (back.clicked()) {
      currentScene = "mainmenu";
    }
  } else if (currentScene == "howToPlay") {
    fill(50);
    rect(width/4, 157, width/2, width/2);
    fill(240, 20, 20);
    text("HOW TO PLAY: Here you can add the instructions for the game.", width/4+50, 157+50);
    back.display();
    if (back.clicked()) {
      currentScene = "mainmenu";
    }
  }
}

void listButtons(String[] buttonTexts, float positionX, float positionY, int space) {
  int j = 0;
  int it = 1;
  for (int i = 1; i < buttonTexts.length; i++) {
    if(i % 10 == 0){
       j++;
       it = 2;
    }
    else{
      it++;
    }
    fill(0);
    Button newMap = new Button(positionX+j*170, positionY+space*it, 158, 30, buttonTexts[i]);
    newMap.display();
    if (newMap.clicked()) {
      gameload.saveLoad("campaign", buttonTexts[i], "5");
    }
  }
}

String[] browseMaps() {
  File file = new File("../../PROYECTRED/game/maps/campaign");
  String[] fileList = file.list();
  return fileList;
}

void display() {
  fill(255, 0, 0);
  //rect(position.x, position.y, scale.x, scale.y);
  fill(0);
  //text(text, textPos.x, textPos.y);
}
