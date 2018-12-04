class Orchestre {
  ArrayList<Ellipse> ellipses;
  Orchestre() {
    ellipses = new ArrayList<Ellipse>();
    for (float x=50; x<width; x= x+100) {
      for (float y=50; y<height; y= y+100) {
        float map = (x>width/2)?map(x,width/2,width,100,height-300):map(x,50,width/2,height-300,100);
        if (y<map || y<map) {
          ellipses.add(new Ellipse(x,y));
        }
      }
    }
  }

  void update(float direction, float volume) {
    for(Ellipse e: ellipses){
      float selection = map(direction,-10,10,0,width);
      float selectionVertical = map(volume,0,60,height-400,0);
      if(e.getX()>selection-100 && e.getX() < selection+100 && e.getY() > selectionVertical){
          e.selected(volume);
      }
      e.update();
    }
  }
}
