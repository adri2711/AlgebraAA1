final int enemyNum = 10;
final int obstacleNum = 5;
Enemy[] enemy = new Enemy[enemyNum];
Obstacle[] obstacle = new Obstacle[obstacleNum];
Player player;

void setup() {
  size(1080, 720);
  background(1);
  strokeWeight(10);
  
  player = new Player(100,5,7);
  
  for (int i = 0; i < enemyNum; i++) {
    enemy[i] = new Enemy(i%3);
  }
    
  for (int i = 0; i < obstacleNum; i++) {
    obstacle[i] = new Obstacle(i%3);
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
    
  //Handle obstacles
  for (int i = 0; i < obstacleNum; i++) { 

  }
  
}
