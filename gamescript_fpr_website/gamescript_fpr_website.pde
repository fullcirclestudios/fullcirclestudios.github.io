//script fpr marble fall

Player player;
Platform platform;
Platform ground;
Score score;
Marble marble;

void setup(){
  size(600,600);
  rectMode(CENTER);
  noStroke();
  
  player=new Player(width/2, height/2);
  ground=new Platform(width/2, 565);
  score = new Score(player.x, player.y);
  marble = new Marble(random(0, width));
}

void draw(){
    background(0);
    fill(0,255,255);
    ground.display();
    player.display();
    player.update();
    marble.display();
    marble.update();
    
    score.display(player.x, player.y);
    score.update();
    
    if(objectIntersection(player, ground)){
      player.groundCheck(ground.y, ground.h);
    } 
    
    if (objectCollision(marble, ground)){
      marble.groundCheck(0,-marble.h/2, random(marble.w/2, width-marble.w/2));
      marble.grounded=false;
    }
    
    if (objectMurder(marble, player)){
      marble.groundCheck(0,-marble.h/2, random(marble.w/2, width-marble.w/2));
      marble.grounded=false;
      score.deathTime=millis();
      
    }
}

boolean objectIntersection(Player player, Platform platform){
    float distx= abs(player.x - platform.x);
    float disty= abs(player.y - platform.y);
    float combinedHalfHeight= (player.h+platform.h)/2;
    float combinedHalfWidth= (player.w+platform.w)/2;
    
    if (distx <= combinedHalfWidth) {
        if (disty <= combinedHalfHeight) {
            return true;
        }
    }
    return false;
}

boolean objectCollision(Marble marble, Platform platform){
    float distx= abs(marble.x - platform.x);
    float disty= abs(marble.y - platform.y);
    float combinedHalfHeight= (marble.h+platform.h)/2;
    float combinedHalfWidth= (marble.w+platform.w)/2;
    
    if (distx <= combinedHalfWidth) {
        if (disty <= combinedHalfHeight) {
            return true;
        }
    }
    return false;
}

boolean objectMurder(Marble marble, Player player){
    float distx= abs(marble.x - player.x);
    float disty= abs(marble.y - player.y);
    float combinedHalfHeight= (marble.h+player.h)/2;
    float combinedHalfWidth= (marble.w+player.w)/2;
    
    if (distx <= combinedHalfWidth) {
        if (disty <= combinedHalfHeight) {
            return true;
        }
    }
    return false;
}

void keyPressed()
{
  player.setKey(key, true);
}

void keyReleased () {
  player.setKey(key, false);
}

class Player
{
  float x,y, w, h;
  color c;
  boolean isUpward, isLeftward, isRightward;
  boolean grounded;
  float g;
  float dy, dx=8;
  float speed;

  Player(float xpos, float ypos)
  {
      x=xpos;
      y=ypos;
      w=65;
      h=65;
      c= color(255,0,200);
      grounded=false;
      g=0.6;
      speed=0;
  }
  
  void display()
  {
      fill(c);
      rect(x,y,w,h, 10);
  }

  void update()
  {
    x+=speed;
    if (isLeftward && x>0) {
       speed=-dx;
     }
     
     if (isRightward && x<600) {
       speed=+dx;}
    
     if (isUpward && grounded) {
       dy-=10;
       grounded=false;
     }
     if (!grounded){dy+=g;}
     y+=dy;
     speed*=0.65;
  }

  void groundCheck(float newY, float newH){
    dy=0;
    grounded=true;
    y=newY-newH/2-h/2;
  }

  boolean setKey(char k, boolean b)
  {
      switch(k)
      {
      case 'w':
        return isUpward = b;
      case 'a':
        return isLeftward = b;
      case 'd':
        return isRightward = b;
      default:
        return b;
      }
  }
}
    
class Platform 
{
  float x, y, w, h, r;
  
  Platform(float xpos, float ypos)
  {
    x=xpos;
    y=ypos;
    w=width;
    h=30;
    r=20;
  }
  
  void display(){
    fill(0,255,255);
    rect(x,y,w,h,r);
  }
}

class Score {
  int s;
  float x;
  float y;
  float time;
  float deathTime=0;
  
  float tSize = 64;
  
  Score (float xpos, float ypos) {s=0; x=xpos; y=ypos; time=millis();}
  void display (float x, float y)
  {
    fill(0,255,255);
    textSize(tSize);
    textAlign(CENTER,CENTER);
    text(s, x, y);

  }
  
  void update ()
  {
    time=millis()-deathTime;
  s =  round(time/1000);
  tSize= 64/str(s).length();
  }
}

class Marble {
  float x,y,w,h;
  float dy;
  float g, speed;
  boolean grounded;
  Marble (float xpos)
  {
  x=xpos;
  y=10;
  w=25; 
  h=25;
  grounded=false;
  g=0.6;
  speed=0;
}
  void display(){
    fill(255,255,0);
    ellipse(x,y,w,h);
    
  }
  void update(){
    if(!grounded)
    
    {
    dy+=g;
    }
    y+=dy;
  }
    void groundCheck(float newY, float newH, float newX){
    dy=0;
    grounded=true;
    y=newY-newH/2-h/2;
    x=newX;
}
}
