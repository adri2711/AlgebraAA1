final int enemyNum = 15;
final int obstacleNum = 12;
Enemy[] enemy = new Enemy[enemyNum];
Obstacle[] obstacle = new Obstacle[obstacleNum];
Object[] object;
Player player;
PImage heart;

void setup() {
  size(1080, 720);
  background(1);
  strokeWeight(10);

  heart = loadImage("heart.png");

  player = new Player(5, 5);

  for (int i = 0; i < enemyNum; i++) {
    enemy[i] = new Enemy(i % 3);
  }

  for (int i = 0; i < obstacleNum; i++) {
    obstacle[i] = new Obstacle(i % 3);
  }
}

void draw() {
  background(1);

  //Handle player
  player.ChangeTarget(new PVector(mouseX, mouseY));
  player.Move();
  player.UpdateDamageCooldown();
  player.Draw();

  //Handle enemies
  for (int i = 0; i < enemyNum; i++) {
    if (enemy[i].isAlive()) {
      //Wander
      if (enemy[i].returnType() == 2) {
        if (random(0, 100) < 1) {
          enemy[i].ChangeTarget(new PVector(random(0, width), random(0, height)));
        }
      }
      //Passive
      else if (enemy[i].returnType() == 1) {
        if (enemy[i].DistanceToEntity(player) < width/3) {
          enemy[i].SetSpeed(-abs(enemy[i].returnSpeed()));
          enemy[i].ChangeTarget(player.returnPos());
        } else {
          enemy[i].SetSpeed(abs(enemy[i].returnSpeed()));
          if (random(0, 100) < 1) {
            enemy[i].ChangeTarget(new PVector(random(0, width), random(0, height)));
          }
        }
      }
      //Agressive
      else {
        if (random(0, 100) < 1) {
          enemy[i].ChangeTarget(player.returnPos());
        }
      }

      enemy[i].Move();

      //Collision with player
      if (enemy[i].CheckCollision(player)) {
        if (enemy[i].returnType() == 1) {
          player.AddScore();
          enemy[i].Kill();
        } else if (player.returnDamageCooldown() == 0) {
          player.Damage();
        }
      }

      //Draw    
      enemy[i].Draw();
    }
  }

  //Handle items
  
  
  //Handle obstacles
  for (int i = 0; i < obstacleNum; i++) {
  }

  //Handle interface
  DrawLives(player.returnLives(), 0);
}
