class Enemy extends Entity{
  int type; // 0: attack 1: run 2: wander 
  final float collisionMargin = 19; //Epsilon

  Enemy(int type) {
    this.type = type;
    radius = 10.0;
    
    speed = random(minSpeed,maxSpeed);
    if (type == 1) {
      speed = -(speed/2);
    }
    
    int temp = int(random(1,4));
    switch (temp) {
      case 1:
        Pos = new PVector(radius*2,height/2);
        break;
      case 2:
        Pos = new PVector(width-radius*2,height/2);
        break;
      case 3:
        Pos = new PVector(width/2,height-radius*2);
        break;
    }
  }

  void CheckCollision(Entity target) {
    PVector colVector = new PVector(target.returnPos().x-Pos.x,target.returnPos().y-Pos.y);
    float magnitude = sqrt(pow(colVector.x,2)+pow(colVector.y,2));
    
    if (magnitude < target.radius+radius) {
      stroke(255, 20, 100);
      fill(255, 20, 100);
    } else {
      stroke(150, 50, 50);
      fill(150, 50, 50);
    }
    
  }

  void Draw() {
    strokeWeight(5);
    ellipse(Pos.x, Pos.y, 10, 10);
  }
  
  float returnSpeed() {
    return speed;
  }
  
  int returnType() {
    return type;
  }
}
