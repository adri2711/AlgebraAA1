PVector PlayerPos,NPCPos;

void setup() {
  size(1920, 1080);
  background(1);
  strokeWeight(10);
  
  NPCPos = new PVector(random(width), random(height));
  PlayerPos = new PVector(mouseX,mouseY);
}

void draw() {
  background(1);
  float speed = 0.03; //Alpha
  float collisionMargin = 19; //Epsilon
  PVector NPCPosNormalised = new PVector(NPCPos.x - PlayerPos.x,NPCPos.y - PlayerPos.y);
  NPCPosNormalised.x = NPCPosNormalised.x / sqrt(pow(NPCPosNormalised.x,2)+pow(NPCPosNormalised.y,2)); 
  NPCPosNormalised.y = NPCPosNormalised.y / sqrt(pow(NPCPosNormalised.x,2)+pow(NPCPosNormalised.y,2)); 
  
  PlayerPos.x = mouseX;
  PlayerPos.y = mouseY;
  
  NPCPos.x = PlayerPos.x + speed * NPCPos.x;
  
  if (abs(NPCPos.x - PlayerPos.x) < collisionMargin && abs(NPCPos.y - PlayerPos.y) < collisionMargin) {
    stroke(255,20,100);
  }
  else {
    stroke(150,50,50);
  }
  ellipse(NPCPosNormalised.x,NPCPosNormalised.y,10,10);
  
  stroke(100,200,50);
  ellipse(PlayerPos.x,PlayerPos.y,10,10);

}
