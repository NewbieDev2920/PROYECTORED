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
  File file = new File(".");
  String[] fileList = file.list();
  for(String name : fileList){
    println(name);
  }
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
    
  }
}
