import processing.sound.*; //<>//
import java.io.File;
PImage background;
PImage splash;
SoundFile music;
Button play = new Button(437, 162, 101, 40, "play");
Button settings = new Button(412, 206, 158, 30, "settings");
Button credits = new Button(414, 243, 156, 27, "credits");
Button howToPlay = new Button(414, 280, 156, 27, "howToPlay"); // New button
String currentScene = "mainmenu";

void setup() {
  size(982, 572);
  background(0);
  splash = loadImage("splashscreen.jpg");
  image(splash, width/2-150, height/2-150);
  delay(3000);
  background = loadImage("menubackground.jpeg");
  music = new SoundFile(this, "menuMusic.mp3");
  music.play();
}

void draw() {
  if (currentScene == "mainmenu") {
    image(background, 13, 0);
    play.display();
    settings.display();
    credits.display();
    howToPlay.display(); // Display new button

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
    fill(50);
    rect(width/4, 160, width/2, width/2);
    listButtons(browseMaps(), 0, 0, 80);
  } else if (currentScene == "settings") {
    fill(255, 255, 0);
    rect(width/4, 157, width/2, width/2);
  } else if (currentScene == "credits") {
    fill(50);
    rect(width/4, 157, width/2, width/2);
    fill(240, 20, 20);
    text("DESARROLLADORES : ALEJANDRO CUELLO, CARLOS DE LA ROSA, DALADIER", width/4+50, 157+50);
    text("SPRITES : @acewaydev, @Darkeyed19 @ @ScatteredReality", width/4+50, 157+100);
    text("MUSICA : LUCA FRANCINI", width/4+50, 157+150);
  } else if (currentScene == "howToPlay") {
    fill(50);
    rect(width/4, 157, width/2, width/2);
    fill(240, 20, 20);
    text("HOW TO PLAY: Here you can add the instructions for the game.", width/4+50, 157+50);
  }
}

void listButtons(String[] buttonTexts, float positionX, float positionY, int space) {
  for (int i = 1; i < buttonTexts.length; i++) {
    fill(0);
    rect(positionX, positionY+i*space, 100, 50);
    fill(255);
    text(buttonTexts[i], positionX+5, positionY+i*space+50/2);
  }
}

String[] browseMaps() {
  File file = new File("../../PROYECTOALGO2/maps/campaign");
  String[] fileList = file.list();
  return fileList;
}

void display() {
  fill(255, 0, 0);
  //rect(position.x, position.y, scale.x, scale.y);
  fill(0);
  //text(text, textPos.x, textPos.y);
}
