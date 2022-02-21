class Player {
  int health;
  int lives;
  float speed; //Alpha
  PVector Pos;
  
  Player(int health, int lives, float speed) {
    this.health = health;
    this.lives = lives;
    this.speed = speed;
    Pos = new PVector(width/2,15);
  }

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
  } 
  
  void Draw() {
    stroke(50,200,50);
    ellipse(Pos.x, Pos.y, 10, 10);
  }
  
  float returnSpeed() {
    return speed;
  }
  
  PVector returnPos() {
    return Pos;
  }
}
