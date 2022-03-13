void SetupStage1() {
  
  for (int i = 0; i < enemyNum; i++) {
    enemy[i] = new Enemy(i % 3);
  }

  for (int i = 0; i < obstacleNum; i++) {
    obstacle[i] = new Obstacle(i % 3);
  }
  
  object[0] = SpawnObject(new PVector(random(20,width),random(20,height)));
}



void SetupStage2() {
  
}



Object SpawnObject(PVector Pos) {
  boolean inObject = false;
  Object object = new Object(Pos);
  
  int i = 0;
  while (i < obstacleNum && !inObject) {
    if (obstacle[i].CheckIfSpawnInside(object) != 'n') {
      inObject = true;
    }
    i++;
  }
  
  if (!inObject) {
    return object;
  }
  else {
    return SpawnObject(new PVector(random(20,width),random(20,height)));
  }
}



void ObstacleLoop() {
  for (int i = 0; i < obstacleNum; i++) {
    obstacle[i].DrawShape();
  }
}



void PlayerLoop() {
  //movement
  player.ChangeTarget(new PVector(mouseX, mouseY));
  player.Move();
  
  //wall collision
  if (player.returnPos().x > width - player.returnRadius()) {
    player.Collide('h');
  }
  if (player.returnPos().x < player.returnRadius()) {
    player.Collide('h');
  }
  if (player.returnPos().y > height - player.returnRadius()) {
    player.Collide('v');
  }
  if (player.returnPos().y < player.returnRadius()) {
    player.Collide('v');
  }
  
  //obstacle collision
  for (int j = 0; j < obstacleNum; j++) {
    if (obstacle[j].CheckCollision(player) != 'n') {
      player.Collide(obstacle[j].CheckCollision(player));
    }
  }
  
  player.UpdateDamageCooldown();
  player.Draw();  
}



void BossLoop() {
  
}



void EnemyLoop() {
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
        if (random(0,10) < 1) {
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
        enemy[i].Collide('h');
      }
      if (enemy[i].returnPos().x < enemy[i].returnRadius()) {
        enemy[i].Collide('h');
      }
      if (enemy[i].returnPos().y > height - enemy[i].returnRadius()) {
        enemy[i].Collide('v');
      }
      if (enemy[i].returnPos().y < enemy[i].returnRadius()) {
        enemy[i].Collide('v');
      }
  

      //Draw    
      enemy[i].Draw();
    }
  }  
}



void ObjectLoop() {
  int i = 0;
  do {
    if (object[i].isAlive()) {
      object[i].Draw();
      
      if (object[i].CheckCollision(player)) {
        player.AddScore();
        object[i].Kill();
      }
    }    
    
    i++;
  } while(i < objectNum && gameStage == 2);
}



void InterfaceLoop() {
  DrawLives(player.returnLives(), 0);
  if (player.returnScore() > 0) {
    DrawScore(player.returnScore(), 0, 0);
  }
}
