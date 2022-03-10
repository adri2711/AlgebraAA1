void DrawLives(int lives, int offset) {
  int GUIScale = ceil(width/270.0);
  int space = width/16;
  imageMode(CENTER);
  image(heart,offset+space,height-space,8*GUIScale,8*GUIScale);
  if (lives > 1) {
    DrawLives(lives-1, offset+8*GUIScale);
  }
}

void DrawScore(int score,int x_offset,int y_offset) {
  int GUIScale = ceil(width/270.0);
  int space = width/16;
  fill(50,200,50);
  stroke(50,200,50);
  ellipse(width-(space+x_offset), height-(space+y_offset), GUIScale*4, GUIScale*4);
  if (score > 1) {
    if (score % 8 == 1) {
      DrawScore(score-1, 0, (int)(y_offset+8*GUIScale));
    }
    else {
      DrawScore(score-1, x_offset+8*GUIScale, y_offset);
    }
  }
}
