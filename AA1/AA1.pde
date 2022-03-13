final int obstacleNum = 12;
final int objectNum = 4;
Enemy[] enemy;
Obstacle[] obstacle = new Obstacle[obstacleNum];
Object[] object = new Object[objectNum];
Player player;
PImage heart;
int gameStage = 0;
int numOfEnemies[];
int enemyNum;
int playButtonDiameter;
int countOfInputs;

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
      background(0,0,0);
      Start(numOfEnemies, playButtonDiameter);
    break;
    
    case 1:
      background(10,30,40);
      ObstacleLoop();
      PlayerLoop();
      EnemyLoop();
      ObjectLoop();
      InterfaceLoop();
    break;
    
    case 2:
      background(40,5,20);
      ObstacleLoop();
      PlayerLoop();
      BossLoop();
      EnemyLoop();
      ObjectLoop();
      InterfaceLoop();
    break;
  }
}
