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
  float speed = 7; //Alpha
  float collisionMargin = 19; //Epsilon
  
  //Obtain player position
  PlayerPos.x = mouseX;
  PlayerPos.y = mouseY;
  
  //Initialize vectors
  PVector posVector = new PVector(PlayerPos.x - NPCPos.x,PlayerPos.y - NPCPos.y);
  PVector nVector = new PVector(0,0);
  float magnitude = sqrt(pow(posVector.x,2) + pow(posVector.y,2));

  //Normalize
  nVector.x = posVector.x / magnitude; 
  nVector.y = posVector.y / magnitude; 
  
  //Calculate next NPC position
  NPCPos.x = NPCPos.x + speed * nVector.x;
  NPCPos.y = NPCPos.y + speed * nVector.y;
  
  //Calculate collision
  if (abs(NPCPos.x - PlayerPos.x) < collisionMargin && abs(NPCPos.y - PlayerPos.y) < collisionMargin) {
    stroke(255,20,100);
  }
  else {
    stroke(150,50,50);
  }
  
  //Draw
  ellipse(NPCPos.x,NPCPos.y,10,10);
  stroke(100,200,50);
  ellipse(PlayerPos.x,PlayerPos.y,10,10);

}
