class Projectile extends Entity {
  float angle;
  
  Projectile(PVector Pos, float angle, float speed) {
    this.speed = speed;
    this.angle = angle;
    this.Pos = Pos.copy();
    radius = 2;
    
  }
  
  void UpdateProjectileTarget() {
    ChangeTarget(new PVector(cos(radians(angle))+Pos.x,sin(radians(angle))+Pos.y));
  }
  
  void Draw() {
    strokeWeight(5);
    stroke(200,100,250);
    fill(200,100,250);
    ellipse(Pos.x, Pos.y, radius*2, radius*2);
  }
}
