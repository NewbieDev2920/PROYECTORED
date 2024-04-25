class FinishLine{
   PVector position = new PVector();
   PVector scale = new PVector();
   Collider col;
   Sprite sprite = new Sprite();
   String spritePath;
   //Tipos level y boss
   String type;
   
   void init(String type, float x, float y, float w, float h){
     this.type = type;
     this.position.x = x;
     this.position.y = y;
     this.scale.x = w;
     this.scale.y = h;
     if(type == "level"){
       //test temporal
       this.spritePath = "test/levelfinishline.png";
     }
     else if(type == "boss"){
       
     }
     else{
        println("This type of FinishLine doesn't exists") ;
     }
    sprite.init(spritePath);
    col = new Collider(position.x, position.y, scale.x, scale.y, "interactable");
    col.objectType = "finishline";
    col.centerCollider(position, scale);
    col.calcCenterPoint();
    colliderList.add(col);
   }
   
   void checkInteraction(){
      sprite.display(position);
      if(col.playerCollided){
        effect();
      }
   }
   
   void effect(){
     if(type == "level"){
       character.isInvincible = true;
       gui.currentScene = "victory";
     }
     else if(type == "boss"){
       
     }
   }
   
}
