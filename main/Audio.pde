import processing.sound.*;
class Audio{
  SoundFile walk, jump, playerHurted, gameMusic1, gameMusic2, enemyDeath, gameover, victory, pickup;
  String audioPath = "../assets/audio/";

  void init() {
    walk = new SoundFile(main.this,audioPath+"walk.wav");
    jump = new SoundFile(main.this,audioPath+"jump.wav");
    playerHurted = new SoundFile(main.this,audioPath+"playerhurted.wav");
    gameMusic1 = new SoundFile(main.this, audioPath+"gamemusic1.mp3");
    gameMusic2 = new SoundFile(main.this, audioPath+ "gamemusic2.mp3");
    enemyDeath = new SoundFile(main.this, audioPath+"enemydeath.wav");
    gameover = new SoundFile(main.this, audioPath+"gameover.wav");
    victory = new SoundFile(main.this, audioPath+"victory.wav");
    pickup = new SoundFile(main.this, audioPath+"pickup.wav");
  }

  void play(String sound) {
    if (sound.equals("walk")) {
      walk.play();
    } else if (sound.equals("jump")) {
      jump.play();
    } else if (sound.equals("hurted")) {
      playerHurted.play();
    }
    else if(sound.equals("gameMusic1")){
      gameMusic1.play();
      gameMusic1.amp(0.3);
    }else if(sound.equals("gameMusic2")){
      gameMusic2.play();
      gameMusic2.amp(0.3);
    }
    else if(sound.equals("enemydeath")){
      enemyDeath.play(); 
    }
    else if(sound.equals("gameover")){
      gameover.play(); 
    }
    else if(sound.equals("victory")){
      victory.play(); 
    }else if(sound.equals("pickup")){
       pickup.play();
       pickup.amp(1);
    }
  }
}
