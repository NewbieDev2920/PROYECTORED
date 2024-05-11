class Loader{

    String getLoad(){
        XML loader = loadXML("../../load.xml");
        String mapPath = "../maps/"+loader.getChild("maptype").getContent()+"/"+loader.getChild("mapname").getContent();
        return mapPath;
    }
}
