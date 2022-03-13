final int enemyNum = 20;
final int obstacleNum = 12;
final int objectNum = 4;
Enemy[] enemy = new Enemy[enemyNum];
Obstacle[] obstacle = new Obstacle[obstacleNum];
Object[] object = new Object[objectNum];
Player player;
PImage heart;
int gameStage = 1;
boolean levelBeat = false;

void setup() {
  size(1080, 720);
  heart = loadImage("heart.png");
  player = new Player(5, 5);
  SetupStage1();
}

void draw() {
  switch (gameStage) {
    case 0:
    
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
