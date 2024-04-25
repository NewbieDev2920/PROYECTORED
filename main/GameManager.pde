class GameManager {
  void centerCamera(Player character) {
    
    
  }
  
  void checkStatus(){
    if(character.hearts <= 0){
      gui.currentScene = "dead";
    }
  }
  
  void initalConfiguration(){
     //Para empezar o hacer retry 
  }
}
