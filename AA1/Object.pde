class Object extends Entity {
  int colors[] = new int [3];  
  int colorTimer = 0;
  final int colorSpeed = 7;
  
  Object(PVector Pos) {
    radius = 12;
    this.Pos = Pos.copy();
    
    colors[0] = 0;
    colors[1] = 250;
    colors[2] = 250;
  }
  
  void Draw() {
    colors[colorTimer / 250] += colorSpeed;
    colors[((colorTimer / 250) + 1) % 3] -= colorSpeed;
    
    colorTimer += colorSpeed;
    if (colorTimer >= 750-colorSpeed) {
      colorTimer = 0;
    }
    
    strokeWeight(2);
    stroke(colors[2],colors[0],colors[1]);
    fill(colors[0],colors[1],colors[2]);
    ellipse(Pos.x, Pos.y, radius*2, radius*2);
  }
  
}
