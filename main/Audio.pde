import processing.sound.*;
class Audio{
  SoundFile walk, jump, playerHurted, gameMusic, enemyDeath, gameover;
  String audioPath = "../assets/audio/";

  void init() {
    walk = new SoundFile(main.this,audioPath+"walk.wav");
    jump = new SoundFile(main.this,audioPath+"jump.wav");
    playerHurted = new SoundFile(main.this,audioPath+"playerhurted.wav");
    gameMusic = new SoundFile(main.this, audioPath+"driftkilla.mp3");
    enemyDeath = new SoundFile(main.this, audioPath+"enemydeath.wav");
    gameover = new SoundFile(main.this, audioPath+"gameover.wav");
  }

  void play(String sound) {
    if (sound.equals("walk")) {
      walk.play();
    } else if (sound.equals("jump")) {
      jump.play();
    } else if (sound.equals("hurted")) {
      playerHurted.play();
    }
    else if(sound.equals("gameMusic")){
      gameMusic.play(); 
    }
    else if(sound.equals("enemydeath")){
      enemyDeath.play(); 
    }
    else if(sound.equals("gameover")){
      gameover.play(); 
    }
  }
}
