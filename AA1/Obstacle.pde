class Obstacle {

  int sides;
  float strokeWeight;
  float rotation;
  PVector position[];
  float translatePosition[];
  float randomSize[];

  Obstacle(int sides) {
    this.sides = sides;
    this.SelectShape();
  }

  void SelectShape() {

    switch(sides) {
    case 0:
      strokeWeight = random(15, 60);
      position = new PVector[1];
      position[0] = new PVector(random(width), random(height));
      break;

    case 1:
      position = new PVector[3];
      position = DrawShapes(50);
      /*translatePosition = new float[2];
      translatePosition[0] = random(width);
      translatePosition[1] = random(height);   */       
      rotation = random(361);          
      break;

    case 2:         
      randomSize = new float[2];
      randomSize[0] = random(180);
      randomSize[1] = random(180);
      translatePosition = new float[2];
      translatePosition[0] = random(width - randomSize[0]);
      translatePosition[1] = random(height - randomSize[1]);
      rotation = random(361);
      break;
    }
  }  

  PVector[] DrawShapes(int num) {

    PVector point1 = new PVector(random(width - num), random(height - num));
    PVector points[] = new PVector[3];
    points[0] = point1;

    for (int i = 1; i < 3; i++) {
      points[i] = new PVector(random((points[0].x + num) - (points[0].x - num) + 1) + (points[0].x - num), random((points[0].y + num) - (points[0].y - num) + 1) + (points[0].y - num));
    }    
    return points;
  }


  void DrawShape() {

    switch(sides) {
    case 0:
      strokeWeight(strokeWeight);
      point(position[0].x, position[0].y);
      break;

    case 1:
      //translate(translatePosition[0], translatePosition[1]);
      rotate(rotation);
      triangle(position[0].x, position[0].y, position[1].x, position[1].y, position[2].x, position[2].y);
      break;

    case 2:
      translate(translatePosition[0], translatePosition[1]);   
      rotate(rotation);
      rect(0, 0, randomSize[0], randomSize[1]);
      break;
    }
  }
}
