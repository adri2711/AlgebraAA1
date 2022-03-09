class Entity {
  final int maxSpeed = 4;
  final int minSpeed = 3;
  float radius;
  float speed; //Alpha
  boolean alive = true;
  PVector Pos;
  PVector targetPos = new PVector(width/2,height/2);
 
  void ChangeTarget(PVector newTarget) {
    targetPos = newTarget;
  }
  
  void Move() {
    //Initialize vectors
    PVector posVector = new PVector(targetPos.x - Pos.x, targetPos.y - Pos.y); //Vector between current position and target position 
    PVector nVector = new PVector(0, 0); //Normalized vector
    float magnitude = sqrt(pow(posVector.x, 2) + pow(posVector.y, 2));

    //Normalize
    nVector.x = posVector.x / magnitude; 
    nVector.y = posVector.y / magnitude; 

    //Calculate next position
    Pos.x += speed * nVector.x;
    Pos.y += speed * nVector.y;
    
    //Collision with walls
    if (Pos.x > width-radius) {
      Pos.x = width-radius;
    }
    else if (Pos.x < radius) {
      Pos.x = radius; 
    }
    if (Pos.y > height-radius) {
      Pos.y = height-radius;
    }
    else if (Pos.y < radius) {
      Pos.y = radius;
    }
  }
  
  float DistanceToEntity(Entity target) {
    PVector distVector = new PVector(target.returnPos().x-Pos.x,target.returnPos().y-Pos.y);
    return sqrt(pow(distVector.x,2)+pow(distVector.y,2));
  }
  
  PVector returnPos() {
    return Pos;
  }
  
  PVector returnTarget() {
    return targetPos;
  }
  
  float returnSpeed() {
    return speed;
  }
}
