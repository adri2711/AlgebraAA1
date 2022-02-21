class Enemy {
  int type; // 0: attack 1: run 2: wander 
  final int maxSpeed = 5;
  final int minSpeed = 3;
  float speed; //Alpha
  final float collisionMargin = 19; //Epsilon
  PVector Pos;

  Enemy(int type) {
    this.type = type;
    
    speed = random(minSpeed,maxSpeed);
    if (type == 1) {
      speed = -(speed/2);
    }
    
    int temp = int(random(0,4));
    switch (temp) {
      case 0:
        Pos = new PVector(width/2,height/4);
        break;
      case 1:
        Pos = new PVector(width/4,height/2);
        break;
      case 2:
        Pos = new PVector(3*width/4,height/2);
        break;
      case 3:
        Pos = new PVector(width/2,3*height/4);
        break;
    }
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

  void CheckCollision(PVector targetPos) {
    if (abs(Pos.x - targetPos.x) < collisionMargin && abs(Pos.y - targetPos.y) < collisionMargin) {
      stroke(255, 20, 100);
    } else {
      stroke(150, 50, 50);
    }
  }

  void Draw() {
    ellipse(Pos.x, Pos.y, 10, 10);
  }
  
  float returnSpeed() {
    return speed;
  }
}
