void Start(int numOfEnemies[], int playButtonDiameter) {
  fill(255);
  textSize(30);
  text("(at least 3, backspace to delete last number)", width / 2 - 350, height / 3 + 65);
  textSize(60);
  text("Write number of enemies", width / 6 - 17, height / 3);

  fill(220, 80, 100);
  if (numOfEnemies[1] != 0 || (numOfEnemies[0] != 0 && numOfEnemies[1] == 0 && countOfInputs == 2)) {
    text(numOfEnemies[0], width / 2 - 38, height / 2 + 65);
    text(numOfEnemies[1], width / 2, height / 2 + 65);
  } else if (numOfEnemies[0] != 0) {
    text(numOfEnemies[0], width / 2, height / 2 + 65);
  }
  strokeWeight(3);
  stroke(150, 255, 255);
  fill(200);
  ellipse(width / 2, height - height / 5, playButtonDiameter, playButtonDiameter);
  fill(0);
  text("PLAY", width / 2 - 72, height - height / 5 + 20);
}

void keyPressed() {
  if (gameStage == 0) {
    if (key >= 48 && key <= 57) {
      for (int i = countOfInputs; i < numOfEnemies.length; i++) {
        if (countOfInputs < 2) {
          numOfEnemies[i] = Integer.parseInt(String.valueOf(key));
          i = numOfEnemies.length;
          if (numOfEnemies[0] * 10 + numOfEnemies[1] != 0) {
            countOfInputs++;
          }
        }
      }
    } else if (key == 8) {
      for (int i = numOfEnemies.length - 1; i >= 0; i--) {
        if ((numOfEnemies[i] != 0 && countOfInputs == 1) || countOfInputs == 2) {
          numOfEnemies[i] = 0;
          i = 0;
          if (countOfInputs > 0) {
            countOfInputs--;
          }
        }
      }
    }
    if (countOfInputs == 2) {
      enemyNum = numOfEnemies[0] * 10 + numOfEnemies[1];
    } else {
      enemyNum = numOfEnemies[0];
    }
  } else {
    if (keyCode == UP || keyCode == 'W') {
      goUp = true;
    }
    if (keyCode == DOWN || keyCode == 'S') {
      goDown = true;
    }
    if (keyCode == RIGHT || keyCode == 'D') {
      goRight = true;
    }
    if (keyCode == LEFT || keyCode == 'A') {
      goLeft = true;
    }
  }
}

void keyReleased() {

  if (gameStage != 0) {
    if (keyCode == UP || keyCode == 'W') {
      goUp = false;
    }
    if (keyCode == DOWN || keyCode == 'S') {
      goDown = false;
    }
    if (keyCode == RIGHT || keyCode == 'D') {
      goRight = false;
    }
    if (keyCode == LEFT || keyCode == 'A') {
      goLeft = false;
    }
  }
}

void mousePressed() {
  fill(255);
  if (gameStage == 0) {
    if (sqrt(pow(width / 2 - mouseX, 2) + pow((height - height / 5) - mouseY, 2)) <= playButtonDiameter / 2 && enemyNum > 2) {
      enemy = new Enemy[enemyNum];
      SetupStage1();
      gameStage = 1;
    }
  }
}

void DrawLives(int lives, int offset) {
  int GUIScale = ceil(width/270.0);
  int space = width/16;
  imageMode(CENTER);
  image(heart, offset+space, height-space, 8*GUIScale, 8*GUIScale);
  if (lives > 1) {
    DrawLives(lives-1, offset+8*GUIScale);
  }
}

void DrawScore(int score, int x_offset, int y_offset) {
  int GUIScale = ceil(width/270.0);
  int space = width/16;
  strokeWeight(2);
  fill(100, 220, 100);
  stroke(50, 200, 50);
  ellipse(width-(space+x_offset), height-(space+y_offset), GUIScale*4, GUIScale*4);
  if (score > 1) {
    if (score % 8 == 1) {
      DrawScore(score-1, 0, (int)(y_offset+8*GUIScale));
    } else {
      DrawScore(score-1, x_offset+8*GUIScale, y_offset);
    }
  }
}

void DrawTimer() {
  textSize(45);
  fill(50, 100, 200);
  text("Time: " + (timePerLevel - gameTime), 3*width/7, height - 40);
}

void DeathScreen() {
  background(20);
  fill(255);
  textSize(70);
  fill(250, 100, 100);
  text("YOU DIED", width/3, height / 2);
}

void LoadScreen() {
  background(50);
  fill(255);
  textSize(50);
  fill(200, 60, 170);
  text("Collect " + objectNum + " orbs to defeat the boss", width/8, height / 2);
}

void FinalScreen(Player pj) {
  background(50);
  fill(255);
  textSize(70);
  fill(50, 200, 200);
  text("YOU WON!", width/3, height / 2);

  textSize(45);
  fill(50, 100, 200);
  text("score: " + pj.returnScore(), 3*width/7, height / 2 + 100);
}

void GameOverScreen() {
  background(0);
  fill(255);
  textSize(60);
  fill(250, 50, 50);
  text("GAME OVER", width/3, height / 2);
}
