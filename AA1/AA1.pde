final int enemyNum = 10;
final int obstacleNum = 1;
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
    obstacle[i] = new Obstacle(1);
  }
}

void draw() {
  background(1);

  //Handle player
  player.ChangeTarget(new PVector(mouseX, mouseY));
  player.Move();
  
  //wall collision
  if (player.returnPos().x > width - player.returnRadius()) {
    player.Collide('r');
  }
  if (player.returnPos().x < player.returnRadius()) {
    player.Collide('l');
  }
  if (player.returnPos().y > height - player.returnRadius()) {
    player.Collide('d');
  }
  if (player.returnPos().y < player.returnRadius()) {
    player.Collide('u');
  }
  
  //obstacle collision
  for (int j = 0; j < obstacleNum; j++) {
    if (obstacle[j].CheckCollision(player) != 'n') {
      player.Collide(obstacle[j].CheckCollision(player));
    }
  }
  
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

      //player collision
      if (enemy[i].CheckCollision(player)) {
        if (enemy[i].returnType() == 1) {
          player.AddScore();
          enemy[i].Kill();
        } else if (player.returnDamageCooldown() == 0) {
          player.Damage();
        }
      }
      
      //wall collision
      if (enemy[i].returnPos().x > width - enemy[i].returnRadius()) {
        enemy[i].Collide('r');
      }
      if (enemy[i].returnPos().x < enemy[i].returnRadius()) {
        enemy[i].Collide('l');
      }
      if (enemy[i].returnPos().y > height - enemy[i].returnRadius()) {
        enemy[i].Collide('d');
      }
      if (enemy[i].returnPos().y < enemy[i].returnRadius()) {
        enemy[i].Collide('u');
      }
      
      //obstacle collision
      /*for (int j = 0; j < obstacleNum; j++) {
        if (obstacle[j].CheckCollision(enemy[i]) != 'n') {
          enemy[i].Collide(obstacle[j].CheckCollision(enemy[i]));
        }
      }*/
  

      //Draw    
      enemy[i].Draw();
    }
  }

  //Handle items
  
  
  //Handle obstacles
  for (int i = 0; i < obstacleNum; i++) {
    obstacle[i].DrawShape();
  }

  //Handle interface
  DrawLives(player.returnLives(), 0);
}
