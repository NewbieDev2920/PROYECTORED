class GameManager {
  PVector spawnPoint;
  public ArrayList<Collectable> soulList = new ArrayList<Collectable>();
  public ArrayList<Obstacle> spikeList = new ArrayList<Obstacle>();
  public ArrayList<Collectable> heartList = new ArrayList<Collectable>();
  public ArrayList<Enemy> enemyList = new ArrayList<Enemy>();
  public ArrayList<Proyectile> bulletList = new ArrayList<Proyectile>();
  
  FinishLine finishLine = new FinishLine();
  
  void checkStatus(){
    if(character.hearts <= 0){
      gui.currentScene = "dead";
    }
  }
  
  void initalConfiguration(){
     //Para empezar o hacer retry 
  }
  
  void specialsUpdate(){

       finishLine.checkInteraction();
     
    
     for(int i = 0; i < soulList.size(); i++){
       soulList.get(i).checkInteraction();
     }
     
     for(int i = 0; i < spikeList.size(); i++){
       spikeList.get(i).checkInteraction(); 
     }
     
     for(int i = 0; i < heartList.size(); i++){
        heartList.get(i).checkInteraction(); 
     }
     
     try{
       for( int i = 0; i < enemyList.size(); i++){
       enemyList.get(i).move();
       enemyList.get(i).checkInteraction();
       }  
     }
     catch(Exception e){
       println("Reduccion de lista de enemigos");
     }
     
     
     for (int i = 0; i < bulletList.size(); i++){
       bulletList.get(i).move();
       bulletList.get(i).checkInteraction();
     }
     
  }
}
