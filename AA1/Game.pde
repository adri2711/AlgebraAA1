  boolean goUp = false;
  boolean goDown = false;
  boolean goRight = false;
  boolean goLeft = false;

void SetupStage1() { 
  int ellipseCounter = 0;
  player = new Player(5, 5);
  player.SetPos(new PVector(width/2, player.returnRadius()*2));

  for (int i = 0; i < enemyNum; i++) {
    enemy[i] = new Enemy(i % 3);
  }

  for (int i = 0; i < obstacleNum; i++) {
    int rand = 0;  
    do {
      rand = (int)random(3);
      ellipseCounter++;
    } while (rand == 0 && ellipseCounter >= obstacleNum / 2);
    obstacle[i] = new Obstacle(rand);
  }

  object[0] = SpawnObject(new PVector(random(20, width - 20), random(20, height - 20)));

  levelBeat = false;
  bossAlive = false;
  startTime = millis();
}



void SetupStage2() {
  player.SetPos(new PVector(width/2, player.returnRadius()*2));

  for (int i = 0; i < enemyNum; i++) {
    enemy[i] = new Enemy(i % 3);
  } 

  for (int i = 0; i < objectNum; i++) {
    object[i] = SpawnObject(new PVector(random(20, width - 20), random(20, height - 20)));
  }

  for (int i = 0; i < projectileNum; i++) {
    projectile[i] = new Projectile(new PVector(0, 0), 0, 0, 0);
    projectile[i].Kill();
  }

  boss = new Boss();
  bossAlive = true;
  startTime = millis();
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
  } else {
    return SpawnObject(Pos);
  }
}



void ObstacleLoop() {
  for (int i = 0; i < obstacleNum; i++) {
    obstacle[i].DrawShape();
  }
}



void PlayerLoop() {
  PVector arrowDirection = new PVector(player.Pos.x, player.Pos.y);

  if (!goUp && !goDown && !goRight && !goLeft) {
    player.ChangeTarget(new PVector(mouseX, mouseY));
  } else {
    if (goUp) {
      arrowDirection.y--;
    }
    else if (goDown) {
      arrowDirection.y++;
    }
    if (goRight) {
      arrowDirection.x++;
    }
    else if (goLeft) {
      arrowDirection.x--;
    }    
    player.ChangeTarget(arrowDirection);
  }  
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

  gameTime = (millis() - startTime) / 1000;
  if (gameTime >= timePerLevel) {
    player.removeLife();
  }

  if (levelBeat && player.returnPos().y > height-15 && (player.returnPos().x > width/2-width/8 && player.returnPos().x < width/2+width/8)) {
    levelBeat = false;
    gameStage++;
    SetupStage2();
  }

  player.UpdateDamageCooldown();
  player.Draw();
}

void BossLoop() {
  if (boss.isAlive()) {
    if (random(0, 40) < 1) {
      boss.ChangeTarget(player.returnPos());
    }

    if (boss.AttackTime()) {
      float angle = random(0, 360);
      for (int i = 0; i < projectileNum; i++) {
        angle += 10;
        projectile[i] = new Projectile(boss.returnPos(), angle, 10, random(5, 8));
      }
    }

    //player collision
    if (boss.CheckCollision(player) && player.returnDamageCooldown() == 0) {
      player.Damage();
    }  

    boss.Move();
    boss.Draw();
  }
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
        if (random(0, 10) < 1) {
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



void ProjectileLoop() {
  for (int i = 0; i < projectileNum; i++) {
    if (projectile[i].isAlive()) {
      projectile[i].UpdateProjectileTarget();
      projectile[i].Move();
      projectile[i].Draw();

      //player collision
      if (projectile[i].CheckCollision(player)) {
        projectile[i].Kill();
        if (player.returnDamageCooldown() == 0) {
          player.Damage();
        }
      }
    }
  }
}



void ObjectLoop() {
  int i = 0;
  int objectsRemaining = 0;
  boolean score = false;
  do {
    if (object[i].isAlive()) {
      object[i].Draw();
      objectsRemaining++;

      if (object[i].CheckCollision(player)) {
        player.AddScore();
        object[i].Kill();
        score = true;
        if (gameStage == 3) {
          attackTime = 12;
          boss.Damage();
        }
      }
    }    

    i++;
  } while (i < objectNum && gameStage == 3);

  if (attackTime > 0) {
    player.AttackEffect(boss.returnPos());
    attackTime--;
  }

  if (score && !bossAlive && objectsRemaining <= 1) {
    levelBeat = true;
  }

  if (levelBeat) {
    fill(100, 220, 100);
    stroke(50, 200, 50);  
    rect(width/2-width/8, height-15, width/4, 15);
  }
}



void InterfaceLoop() {
  DrawLives(player.returnLives(), 0);
  if (player.returnScore() > 0) {
    DrawScore(player.returnScore(), 0, 0);
  }
  DrawTimer();
}
