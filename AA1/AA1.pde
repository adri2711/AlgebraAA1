PImage heart;
final int obstacleNum = 12;
final int objectNum = 4;
final int projectileNum = 12;
final int timePerLevel = 20;
Enemy[] enemy;
Obstacle[] obstacle = new Obstacle[obstacleNum];
Object[] object = new Object[objectNum];
Player player;
Boss boss;
Projectile[] projectile = new Projectile[projectileNum];
int startTime;
int gameTime;
int attackTime;

int gameStage = 0;
boolean bossAlive = false;
boolean levelBeat = false;
int numOfEnemies[];
int enemyNum;
int playButtonDiameter;
int countOfInputs;
int screenTime = 4;

void setup() {
  size(1080, 720);
  heart = loadImage("heart.png");
  player = new Player(5, 5);
  numOfEnemies = new int [2];
  playButtonDiameter = 170;
}

void draw() {

  switch (gameStage) {
  case 0:
    background(0, 0, 0);
    Start(numOfEnemies, playButtonDiameter);
    break;

  case 1:
    background(10, 30, 40);
    ObstacleLoop();
    EnemyLoop();
    ObjectLoop();
    PlayerLoop();
    InterfaceLoop();
    break;

  case 2:
    LoadScreen();
    screenTime++;
    if (screenTime > 200) {
      gameStage++;
      SetupStage2();
      screenTime = 0;
    }
    break;

  case 3:
    background(40, 5, 20);
    ObstacleLoop();
    BossLoop();
    ProjectileLoop();
    EnemyLoop();
    ObjectLoop();
    PlayerLoop();
    InterfaceLoop();
    break;    

  case 4:
    FinalScreen(player);
    screenTime++;
    if (screenTime > 500) {
      gameStage = 0;
      screenTime = 0;
    }
    break;

  case 5:
    DeathScreen();
    screenTime++;
    if (screenTime > 200) {
      gameStage = 1;
      SetupStage1();
      screenTime = 0;
    }      
    break;

  case 6:
    GameOverScreen();
    screenTime++;
    if (screenTime > 500) {
      gameStage = 0;
      screenTime = 0;
    }        
    break;
  }
}
