class GameManager {
  boolean playOnce = true;
  public float gameSpeedMultiplier = 1;
  boolean soulHeartGivingAllowed = true;
  int gameTimer;
  int shopTimer;
  PVector spawnPoint;
  public ArrayList<Collectable> soulList = new ArrayList<Collectable>();
  public ArrayList<Obstacle> spikeList = new ArrayList<Obstacle>();
  public ArrayList<Collectable> heartList = new ArrayList<Collectable>();
  public ArrayList<Enemy> enemyList = new ArrayList<Enemy>();
  public ArrayList<Proyectile> bulletList = new ArrayList<Proyectile>();

  FinishLine finishLine = new FinishLine();

  void updateTimer(String currentScene) {
    if (currentScene == "game") {
      gameTimer = 100-(millis()/1000)+shopTimer;
      if ((millis()/1000+shopTimer) % 15 == 0) {
        gameSpeedMultiplier += 0.001;
      }
    } else if (currentScene == "shop") {
      shopTimer = millis()/1000;
    }
  }


  void checkStatus() {
    if (character.hearts <= 0) {
      if(playOnce){
         audio.gameMusic.pause();
         audio.play("gameover");
         gui.currentScene = "dead"; 
         playOnce = false;
      }
    }

    if (character.soulScore % 10 == 0 && soulHeartGivingAllowed && character.hearts < 3) {
      character.hearts++;
      soulHeartGivingAllowed = false;
    } else if (character.soulScore % 10 != 0) {
      soulHeartGivingAllowed = true;
    }
  }

  void initalConfiguration() {
    //Para empezar o hacer retry
  }

  void specialsUpdate() {

    finishLine.checkInteraction();


    for (int i = 0; i < soulList.size(); i++) {
      soulList.get(i).checkInteraction();
    }

    for (int i = 0; i < spikeList.size(); i++) {
      spikeList.get(i).checkInteraction();
    }

    for (int i = 0; i < heartList.size(); i++) {
      heartList.get(i).checkInteraction();
    }

    try {
      for ( int i = 0; i < enemyList.size(); i++) {
        enemyList.get(i).move();
        enemyList.get(i).checkInteraction();
      }
    }
    catch(Exception e) {
      println("Reduccion de lista de enemigos");
    }


    for (int i = 0; i < bulletList.size(); i++) {
      bulletList.get(i).move();
      bulletList.get(i).checkInteraction();
    }
  }
}
