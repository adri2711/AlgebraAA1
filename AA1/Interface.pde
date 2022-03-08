void DrawLives(int lives, int offset) {
  int GUIScale = ceil(width/270.0);
  int space = width/16;
  imageMode(CENTER);
  image(heart,offset+space,height-space,8*GUIScale,8*GUIScale);
  if (lives > 1) {
    DrawLives(lives-1,offset+8*GUIScale);
  }
}
