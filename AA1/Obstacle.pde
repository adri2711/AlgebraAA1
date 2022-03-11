class Obstacle {

  int sides;
  float diameter;
  PVector position[];
  PVector translatePosition;
  float randomSize[];
  int colors[] = new int [3];

  Obstacle(int sides) {
    this.sides = sides;
    this.SelectShape();
  }

  void SelectShape() {

    switch(sides) {
    case 0:
      diameter = random(60, 90);
      position = new PVector[1];
      position[0] = new PVector(random(width / 8, (width - width / 8)  - diameter), random(height / 8, (height - height / 8) - diameter));
      break;

    case 1:      
      int randomValue = (int)random(20, 90); 
      randomSize = new float[2];
      randomSize[0] = randomValue;
      randomSize[1] = randomValue;
      translatePosition = new PVector();
      translatePosition.x = (int)random(width / 8, (width - width / 8) - randomValue);
      translatePosition.y = (int)random(height / 8, (height - height / 8) - randomValue);  
      for(int i = 0; i < 3; i++){      
        colors[i] = (int)random(256);
      }
      break;

    case 2:         
      randomSize = new float[2];
      randomSize[0] = random(20, 90);
      randomSize[1] = random(20, 90);
      translatePosition = new PVector();
      translatePosition.x = (int)random(width / 8, (width - width / 8) - randomSize[0]);
      translatePosition.y = (int)random(height / 8, (height - height / 8) - randomSize[1]);  
      for(int i = 0; i < 3; i++){      
        colors[i] = (int)random(256);
      }
      break;
    }
  }  

  void DrawShape() {

    switch(sides) {
    case 0:
      ellipse(position[0].x, position[0].y, diameter, diameter);
      break;

    case 1:
    case 2:
      translate(translatePosition.x, translatePosition.y);   
      stroke(colors[0], colors[1], colors[2]);
      fill(colors[0], colors[1], colors[2]);
      rect(0, 0, randomSize[0], randomSize[1]);
      translate(-translatePosition.x, -translatePosition.y);
      break;
    }
  }

  char CheckCollision(Entity pj){
      
    switch(sides){
    
    case 0:
      if(sqrt(pow(position[0].x - pj.returnPos().x,2) + pow(position[0].y - pj.returnPos().y,2)) <= diameter / 2 + pj.returnRadius()){
        return 's';
      }
      break;
      
    case 1:
    case 2:
      if ((sqrt(pow(translatePosition.x - pj.returnPos().x, 2) + pow(translatePosition.y - pj.returnPos().y, 2))) <= pj.returnRadius()||
        (sqrt(pow((translatePosition.x + randomSize[0]) - pj.returnPos().x, 2) + pow(translatePosition.y - pj.returnPos().y, 2))) <= pj.returnRadius()||
        (sqrt(pow((translatePosition.x + randomSize[0]) - pj.returnPos().x, 2) + pow((translatePosition.y + randomSize[1]) - pj.returnPos().y, 2))) <= pj.returnRadius()||
        (sqrt(pow(translatePosition.x - pj.returnPos().x, 2) + pow((translatePosition.y + randomSize[1]) - pj.returnPos().y, 2))) <= pj.returnRadius()) {
        return 's';
      }
      
      else if(pj.returnPos().x + pj.returnRadius() >= translatePosition.x && pj.returnPos().x - pj.returnRadius() <= translatePosition.x + randomSize[0] && pj.returnPos().y + pj.returnRadius() >= translatePosition.y && pj.returnPos().y - pj.returnRadius() <= translatePosition.y + randomSize[1]){
        if(pj.returnPos().x + pj.returnRadius() <= translatePosition.x + pj.returnRadius() || pj.returnPos().x - pj.returnRadius() >= translatePosition.x + randomSize[0] - pj.returnRadius()){
          return 'h';
        }
        
        else if(pj.returnPos().y + pj.returnRadius() <= translatePosition.y + pj.returnRadius() || pj.returnPos().y - pj.returnRadius() >= translatePosition.y + randomSize[1] - pj.returnRadius()){
          return  'v';
        }
      }
      
      break;    
    }  
   return 'n';  
  }
  
  char CheckIfSpawnInside(Entity pj){
      
    switch (sides){
      
      case 0:
        if(sqrt(pow(position[0].x - pj.returnPos().x,2) + pow(position[0].y - pj.returnPos().y,2)) <= diameter / 2 + pj.returnRadius()){
        return 's';
      }
      break;
      
      case 1:
      case 2:
      if(pj.returnPos().x + pj.returnRadius() >= translatePosition.x && pj.returnPos().x - pj.returnRadius() <= translatePosition .x + randomSize[0] && pj.returnPos().y + pj.returnRadius() >=  translatePosition.y && pj.returnPos().y - pj.returnRadius() <= translatePosition.y + randomSize[1]){
        text('c', 40 ,120);
        return 'c';
      } 
      break;    
    }      
    return 'n';    
  }
}
