class Player extends Entity {
  int health;
  int lives;
  
  Player(int health, int lives, float speed) {
    this.health = health;
    this.lives = lives;
    this.speed = speed;
    radius = 15;
    Pos = new PVector(width/2,radius*2);
  }
  
  void Draw() {
    stroke(50,200,50);
    ellipse(Pos.x, Pos.y, 15, 15);
  }
  
  float returnSpeed() {
    return speed;
  }
  
  PVector returnPos() {
    return Pos;
  }
}
