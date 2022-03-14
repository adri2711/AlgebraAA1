class Boss extends Entity {
  private int colors[] = new int [3];  
  private int colorTimer = 0;
  final int colorSpeed = 7;
  private int health;
  final int attackCooldown = 50;
  private int attackCombo = 0;
  private int attackTimer = attackCooldown*2;

  Boss() {

    health = 4;
    Pos = new PVector(width / 2, height - height / 6);
    radius = 27;
    speed = 3;
    
    colors[0] = 100;
    colors[1] = 50;
    colors[2] = 50;    
  }

  boolean AttackTime() {
    attackTimer--;
    if (attackTimer == 0) {
      attackCombo++;
      if (attackCombo < 3) {
        attackTimer = attackCooldown;
      }
      else {
        attackTimer = attackCooldown*3;
        attackCombo = 0;
      }
      
      return true;
    }
    return false;
  }  
  
  void Damage() {
    health--;
    if (health == 0) {
      alive = false;
      bossAlive = false;
    }
  }

  void Draw() {
    colors[colorTimer / 125] += colorSpeed;
    colors[((colorTimer / 125) + 1) % 3] -= colorSpeed;

    colorTimer += colorSpeed;
    if (colorTimer >= 375-colorSpeed) {
      colorTimer = 0;
    }

    strokeWeight(2);
    stroke(colors[1], colors[2], colors[0]);
    fill(colors[0], colors[1], colors[2]);
    ellipse(Pos.x, Pos.y, radius*2, radius*2);
  }
}
