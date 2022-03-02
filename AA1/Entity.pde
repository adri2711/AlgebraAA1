class Entity {
  final int maxSpeed = 4;
  final int minSpeed = 3;
  float radius;
  float speed; //Alpha
  PVector Pos;
  
  void Move(PVector targetPos) {
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
    else if (Pos.x < 0) {
      Pos.x = 0; 
    }
    if (Pos.y > height-radius) {
      Pos.y = height-radius;
    }
    else if (Pos.y < 0) {
      Pos.y = 0;
    }
  }
  
  PVector returnPos() {
    return Pos;
  }
}
