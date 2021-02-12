class Tracing{
  
  //PVector[] shapesVerticies;
  ArrayList<PVector> intersectionPoints;
  PVector origin;
  float angle;
  float initial_angle;
  int l;
  PVector[] debugData;
  
  Tracing(int x, int y,float angle){
    origin = new PVector(x,y);
    this.angle = angle;
    initial_angle = angle;
    intersectionPoints = new ArrayList<PVector>();
  }
  
  void updateAngle(){
    PVector end = PVector.sub(new PVector(mouseX,mouseY),origin);
    end.normalize();    
    angle = end.heading()+initial_angle;
  }
  
  void computeMarching(){
    PVector current = origin.copy();   
    float record;
    int counter = 0;
    while(counter < 100){
      record = 99999;
      if(debugData != null && debugData.length > 0){
        for(PVector v : debugData){
          float d = signedDistance(current,v);
          if(d < record){
            record = d;
          }
        }
      }
      if(record < 1){
        intersectionPoints.add(current.copy());
        break; 
      }      
      PVector v = PVector.fromAngle(angle);
      v.setMag(record);
      
      push();
      translate(current.x,current.y);
      noFill();
      stroke(255,0,0,50);
      circle(0,0,2*record);
      pop();
      
      current.add(v);
      if(offscreen(current)){
        break;  
      }
      push();
      stroke(255,0,0,100);
      line(origin.x,origin.y,current.x,current.y);
      pop();
      counter++;
    }
    //showTrace(record);
  }
  
  void showEdges(){
    if(intersectionPoints != null && intersectionPoints.size() > 0){
      for(PVector v : intersectionPoints){
        push();
        translate(v.x,v.y);
        stroke(255);
        strokeWeight(3);
        point(0,0);
        pop();
      }
    }
  }
  
  private void showTrace(float r){
    push();
    translate(origin.x,origin.y);
    PVector v = PVector.fromAngle(origin.heading());
    v.setMag(r);
    stroke(255,0,255);
    strokeWeight(3);
    point(0,0);
    //RAY
    strokeWeight(1);
    line(0,0,v.x,v.y);
    //RAY
    noFill();
    stroke(255,0,0);
    circle(0,0,2*r);
    pop();
  }
  
  //private PVector calculateRayPosition(){
  //  PVector end = PVector.sub(new PVector(mouseX,mouseY),origin);
  //  end.normalize();    
  //  return end.setMag(l);
  //}
  
  //void addShapesVerticies(Shape[] shapes){
  //  if(shapes != null && shapes.length != 0){
  //    int verticiesSum = 0;
  //    for(Shape s : shapes){
  //      verticiesSum += s.verticies.size();
  //    }
  //    shapesVerticies = new PVector[verticiesSum];
  //    int index = 0;
  //    for(Shape s : shapes){
  //      for(int i = 0; i < s.verticies.size(); i++){
  //        shapesVerticies[index] = s.verticies.get(i);
  //        shapesVerticies[index].z = s.index;
  //        index++;
  //      }
  //    }
  //  }
  //}
  
  void addDebugCirclesData(PVector[] data){
    if(data != null && data.length > 0){
      debugData = data;
    }
  }
  
  //void debugVeritices(){
  //  if(shapesVerticies != null && shapesVerticies.length != 0){
  //    for(PVector v : shapesVerticies){
  //      push();
  //      translate(v.x,v.y);
  //      stroke(255,0,255);
  //      strokeWeight(3);
  //      point(0,0);
  //      pop();
  //    }
  //  }
  //}
  
  private float signedDistance(PVector ray, PVector object){
    float d = dist(ray.x,ray.y,object.x,object.y);    
    return d-(object.z*0.5);
  }
  
  private boolean offscreen(PVector v){
    if(v.x < 0 || v.x > width || v.y < 0 || v.y > height){
      return true;  
    }else{
      return false;
    }
  }
  
}
