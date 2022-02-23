final int enemyNum = 10;
Enemy[] enemy = new Enemy[enemyNum];
Player player;

void setup() {
  size(1920, 1080);
  background(1);
  strokeWeight(10);
  
  player = new Player(10,5,7);
  
  for (int i = 0; i < enemyNum; i++) {
    enemy[i] = new Enemy(i%3);
  }
}

void draw() {
  background(1);
  
  //Handle player
  player.Move(new PVector(mouseX,mouseY));
  player.Draw();
  
  //Handle enemies
  for (int i = 0; i < enemyNum; i++) { 
    enemy[i].Move(player.returnPos());
    enemy[i].CheckCollision(player);
    enemy[i].Draw();
  }
  
}
