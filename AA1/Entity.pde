class Entity {
  final int maxSpeed = 4;
  final int minSpeed = 3;
  float radius;
  float speed; //Alpha
  boolean alive = true;
  PVector Pos;
  PVector posPrev = new PVector(width/2,height/2);
  PVector targetPos = new PVector(width/2,height/2);
 
  void ChangeTarget(PVector newTarget) {
    targetPos = newTarget.copy();
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
    posPrev = Pos.copy();
    Pos.x += speed * nVector.x;
    Pos.y += speed * nVector.y;
  }
  
  void Kill() {
    alive = false;
  }
  
  void Collide(char side) {
    switch (side) {
      case 'v':
      Pos.y = posPrev.y;
      break;
      case 'h':
      Pos.x = posPrev.x;
      break;
      case 's':
      Pos = posPrev;
      break;
    }
  }
  
  void SetPos(PVector newPos) {
    Pos = newPos.copy();
  }
  
  float DistanceToEntity(Entity target) {
    PVector distVector = new PVector(target.returnPos().x-Pos.x,target.returnPos().y-Pos.y);
    return sqrt(pow(distVector.x,2)+pow(distVector.y,2));
  }
  
  boolean CheckCollision(Entity target) {
    float magnitude = DistanceToEntity(target);
    return (magnitude < target.radius+radius);
  }
  
  boolean isAlive() {
    return alive;
  }
  
  float returnRadius() {
    return radius;
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
