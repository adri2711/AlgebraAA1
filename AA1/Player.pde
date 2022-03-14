class Player extends Entity {
  final int maxHealth = 100;
  int health;
  int lives;
  int score;
  int damageCooldown;
  
  Player(int lives, float speed) {
    this.health = maxHealth;
    this.lives = lives;
    this.speed = speed;
    score = 0;
    damageCooldown = 0;
    radius = 10;
    Pos = new PVector(width/2,radius*2);
  }
  
  void Damage() {
    damageCooldown = 50;
    health -= maxHealth / 4;
    if (health < 0) {
      removeLife();
    }
  }
  
  void UpdateDamageCooldown() {
    if (damageCooldown > 0) {
      damageCooldown--;
    }
  }
  
  void AddScore() {
    score++;
  }
  
  void removeLife() {
    lives--;
    health = maxHealth;
    score = 0;
    if (lives > 0) {
      gameStage = 5;
    }
    else {
      lives = 5;      
      gameStage = 6;
    }
  }
  
  void Draw() {
    //draw player
    strokeWeight(5);
    stroke(50,100,200);
    fill(50,100,200);
    ellipse(Pos.x, Pos.y, radius*2, radius*2);
    
    //draw hp bar
    stroke((100-health)+120,health+120,50);
    fill((100-health)+120,health+120,50);    
    line(Pos.x-20,Pos.y+20,Pos.x-20+health/2.5,Pos.y+20);
  }
  
  int returnDamageCooldown() {
    return damageCooldown;
  }
  
  int returnLives() {
    return lives;  
  }
  
  int returnScore() {
    return score;
  }
}
