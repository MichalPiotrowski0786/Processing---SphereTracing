//Shape[] shapes;
PVector[] circlesData;
Tracing[] traces;
boolean isClicked = false;

void settings(){
  size(1800,800);
}

void setup(){
  background(51);
  frameRate(144);
  //addShapes();
  traces = new Tracing[3];
  initDebugCircles(25);
  for(int i = 0; i < traces.length; i++){
    float angle = radians(i);
    traces[i] = new Tracing(width/2,height/2,angle);
    traces[i].addDebugCirclesData(circlesData);
  }
}

void draw(){
  background(0);
  //showShapes();
  showDebugCirlces(isClicked);
  if(traces != null && traces.length > 0){
    for(int i = 0; i < traces.length; i++){
      traces[i].computeMarching();
      traces[i].updateAngle();
      traces[i].showEdges();
    }
  }
}

void mouseClicked(){
  isClicked ^= true;
}

//void addShapes(){
//  shapes = new Shape[3];
//  PVector center = new PVector(width/2,height/2);
  
//  shapes[0] = new Shape(0,center);
//  shapes[0].addVertex(-50,-50);
//  shapes[0].addVertex(50,-50);
//  shapes[0].addVertex(0,50);
  
//  shapes[1] = new Shape(1,center);
//  shapes[1].addVertex(250,-250);
//  shapes[1].addVertex(350,-250);
//  shapes[1].addVertex(350,-150);
//  shapes[1].addVertex(250,-150);
  
//  shapes[2] = new Shape(2,center);
//  shapes[2].addVertex(-850,300);
//  shapes[2].addVertex(-800,300);
//  shapes[2].addVertex(-800,350);
//  shapes[2].addVertex(-850,350);
//}

//void showShapes(){
//  if(shapes != null && shapes.length != 0){
//    for(Shape s : shapes){
//      s.drawShape(color(255),color(255,0,0));
//    }
//  }
//}

void showDebugCirlces(boolean isLit){
  if(circlesData != null && circlesData.length != 0){
    if(isLit){
      for(PVector v : circlesData){
        push();
        fill(51);
        noStroke();
        circle(v.x,v.y,v.z);
        pop();
      }
    }
  }
}

void initDebugCircles(int n){
  circlesData = new PVector[n]; 
  for(int i = 0; i < n; i++){
    int x = (int)random(100,width-100);
    int y = (int)random(100,height-100);
    float r = random(25,50);
    
    circlesData[i] = new PVector(x,y,r);
  }
}
