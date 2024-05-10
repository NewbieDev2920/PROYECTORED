import processing.data.XML;
class GameLoader {

  String mapType = "";
  String mapName = "";
  String soulAccumulation = "";
  String finalText = "<mappath>../maps/"+mapType+"/"+mapName+"</mappath><souls>"+soulAccumulation+"</souls>";
  
  void saveLoad(String mapType, String mapName, String souls){
      this.mapType = mapType;
      this.mapName = mapName;
      this.soulAccumulation = souls;
      String finalText = "<loader>\n"+"  <maptype>"+mapType+"</maptype>\n"+"  <mapname>"+mapName+"</mapname>\n"+"  <souls>"+soulAccumulation+"</souls>\n"+"</loader>";
      XML loader = parseXML(finalText);
      saveXML(loader, "load.xml");
  }
}
