class Obstacle{
  
  int shape;
  
  Obstacle(int shape){
    this.shape = shape;
    
  
  }
  
  PVector[] DrawShapes(int sides, int num){
    
    PVector point1 = new PVector(random(width),random(height));
    PVector points[] = new PVector[sides];
    points[0] = point1;
    
    for(int i = 1; i < sides; i++){
        points[i] = new PVector(random(points[i-1].x - num), random(points[i-1].y + num));
    }    
    return points;     
  }
  
  void SelectShape(){
    
    PVector points[];
  
    switch(shape){
      case '0':
          strokeWeight(random(15, 30));
          point(random(width + 1), random(height + 1));
          break;
          
      case '1':
          points = DrawShapes(3, 15);
          translate(random(width + 1), random(height + 1));
          rotate(random(361));
          triangle(points[0].x, points[0].y, points[1].x, points[1].y, points[2].x, points[2].y);
          //Triangle
          break;
          
      case '2':
          //points = DrawShapes(4, 15);
          translate(random(width + 1), random(height + 1));
          rotate(random(361));
          rect(0,0, random(180), random(180));
          break;    
    }  
  }  
}
