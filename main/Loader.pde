class Loader{

    String getLoad(){
        XML loader = loadXML("../menu/menu/load.xml");
        String mapPath = "../maps/"+loader.getChild("maptype").getContent()+"/"+loader.getChild("mapname").getContent();
        return mapPath;
    }
}
