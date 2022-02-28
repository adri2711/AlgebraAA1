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
    stroke(50,100,200);
    ellipse(Pos.x, Pos.y, 15, 15);
    
    stroke((100-health)*2,health*2,50);
    line(Pos.x-20,Pos.y+20,Pos.x-20+health/2.5,Pos.y+20);
  }
  
  float returnSpeed() {
    return speed;
  }
  
  PVector returnPos() {
    return Pos;
  }
}
