/*
  CREDITOS
 Music by <a href="https://pixabay.com/es/users/lucafrancini-19914739/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=197737">Luca Francini</a> from <a href="https://pixabay.com//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=197737">Pixabay</a> 
 */

import processing.sound.*;
import java.io.File;
 //<>//
PImage background;
PImage splash;
SoundFile music;
Button play = new Button(437, 162, 101, 40, "play");
Button settings = new Button(412, 206, 158, 30, "settings");
Button credits = new Button(414, 243, 156, 27, "credits");
String currentScene = "mainmenu";


void setup() {
  //fullScreen();
  size(982, 572);
  background(0);
  splash = loadImage("splashscreen.jpg");
  image(splash,width/2-150,height/2-150);
  delay(3000);
  background = loadImage("menubackground.jpeg");
  music = new SoundFile(this, "menuMusic.mp3");
  music.play();
}

void draw() {
  if (currentScene == "mainmenu") {
    image(background, 0, 0);
    if (play.clicked()) {
      println("play");
      currentScene = "browser";
    } else if (settings.clicked()) {
      println("settings");
      currentScene = "settings";
    } else if (credits.clicked()) {
      println("credits");
      currentScene = "credits";
    }
  }
  else if(currentScene == "browser"){
    fill(50);
    rect(width/4,157,width/2, width/2);
    listButtons(browseMaps());
  }
  else if(currentScene == "settings"){
    fill(255,255,0);
    rect(width/4,157,width/2, width/2);
 
  }
  else if(currentScene == "credits"){
    fill(50);
    rect(width/4,157,width/2, width/2);
    fill(240,20,20);
    text("DESARROLLADORES : ALEJANDRO CUELLO, CARLOS DE LA ROSA, DALADIER",width/4+50,157+50);
    text("SPRITES : @acewaydev, @Darkeyed19 @ @ScatteredReality",width/4+50,157+100);
    text("MUSICA : LUCA FRANCINI",width/4+50,157+150);
  }
}

String[] browseMaps(){
   File file = new File("../../PROYECTOALGO2/maps/campaign");
   String[] fileList = file.list();
   return fileList;
}

void listButtons(String[] list){
  float gap = 55;
  for(int i = 0; i < list.length; i++){
    Button mapButton = new Button(width/4+gap, 157+gap*i, 200, 50, list[i]);
    mapButton.text = list[i];
    mapButton.display();
  }
}
