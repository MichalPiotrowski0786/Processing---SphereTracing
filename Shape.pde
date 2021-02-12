class Shape{
  
  ArrayList<PVector> verticies;
  PVector translation;
  int index;
  
  Shape(int index, PVector translation){
    verticies = new ArrayList<PVector>();
    this.index = index;
    this.translation = translation;
  }
  
  void addVertex(int x, int y){
    verticies.add(new PVector(translation.x+x,translation.y+y));
  }
  
  void drawShape(color fill, color stroke){
    if(verticies != null){
      push();
      fill(fill);
      stroke(stroke);
      beginShape();
      for(PVector v : verticies){
        vertex(v.x,v.y);
      }
      endShape(CLOSE);
      pop();
    }
  }   
  
}
