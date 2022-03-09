class Enemy extends Entity{
  int type; // 0: attack 1: run 2: wander 
  final float collisionMargin = 19; //Epsilon

  Enemy(int type) {
    this.type = type;
    radius = 10.0;
    
    speed = random(minSpeed,maxSpeed);
    if (type == 1) {
      speed = -(speed*0.7);
    }
    else if (type == 2) {
      speed /= 2;
    }
    
    if (type == 1) {
      Pos = new PVector(width/2,height/2);
    }
    else {
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
  }

  boolean CheckCollision(Entity target) {
    float magnitude = DistanceToEntity(target);
    return (magnitude < target.radius+radius);
  }

  void Draw() {
    if (type == 0) {
      stroke(200, 20, 50);
      fill(200, 20, 50);
    }
    else if (type == 1) {
      stroke(80, 200, 100);
      fill(80, 200, 100);
    }
    else {
      stroke(200, 150, 20);
      fill(200, 150, 20);
    }
    
    strokeWeight(5);
    ellipse(Pos.x, Pos.y, radius, radius);
  }
  
  void Kill() {
    alive = false;
  }
  
  void SetSpeed(float speed) {
    this.speed = speed;
  }
  
  boolean isAlive() {
    return alive;
  }
  
  float returnSpeed() {
    return speed;
  }
  
  int returnType() {
    return type;
  }
}
