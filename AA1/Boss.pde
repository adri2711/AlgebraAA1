class Boss extends Entity{

  private int health;
  
  Boss(){
  
    health = 4;
    Pos = new PVector(width / 2, height - height / 6);
    radius = 20;  
  }

  boolean AttackTime(){
    return millis() % 4000 == 0;
  
  }  
}
