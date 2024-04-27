import processing.sound.*;
class Audio{
  SoundFile walk, jump, playerHurted;
  String audioPath = "../assets/audio/";

  void init() {
    walk = new SoundFile(main.this,audioPath+"walk.wav");
    jump = new SoundFile(main.this,audioPath+"jump.wav");
    playerHurted = new SoundFile(main.this,audioPath+"playerhurted.wav");
  }

  void play(String sound) {
    if (sound.equals("walk")) {
      walk.play();
    } else if (sound.equals("jump")) {
      jump.play();
    } else if (sound.equals("hurted")) {
      playerHurted.play();
    }
  }
}
