//You should implement your assign3 here.
PImage bg1, bg2, treasure, enemy, fighter, hp, start1, start2, end1, end2;
float hpX, treasureX, treasureY, enemyX, enemyY, bgFirstX, bgSecondX, fighterX, fighterY;
final int GAME_START = 1, GAME_RUN = 2, GAME_LOSE = 3;
int gameState;
boolean upPressed = false, downPressed = false, leftPressed = false, rightPressed = false;
float fighterSpeed = 5;
float enemyX2, enemyX3, enemyY2, enemyY3;


void setup () {
  size(640,480) ;  
  
  //start
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  gameState = GAME_START;
  
  //end
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
  
  //background
  bg1 = loadImage("img/bg1.png");  
  bg2 = loadImage("img/bg2.png");
  bgFirstX = 0;
  bgSecondX = -641;
  
  //treasure
  treasure = loadImage("img/treasure.png");
  treasureX = random(600); // let the picture inside the screen
  treasureY = random(440); // let the picture inside the screen
  
  //enemy 
  enemy = loadImage("img/enemy.png");
  enemyX = 0;  // the enemy will move from the leftest side
  enemyY = random(420);  // let the picture inside the screen
  enemyX2 = 0-4*61-640;
  enemyY2 = random(175); //480-61*5=175
  enemyX3 = 0-4*61*2-640*2;
  enemyY3 = random(122,297); //61*2=128; 480-61*3=297 
  
  //fighter
  fighter = loadImage("img/fighter.png");
  fighterX = 589;
  fighterY = 214.5;
 
  //hp (top)
  fill(#CC0000);
  hpX = (203-10)*20/100; //10<=hpX<=203, at least 20 points of blood 
  hp = loadImage("img/hp.png"); 
}

void draw() {
switch (gameState){
    case GAME_START:
      image(start2, 0, 0);
      //mouse detecting
      if (mouseX >= width*95/300 && mouseX <= width*215/300 &&
          mouseY >= height*390/500 && mouseY <= height*435/500){
          image(start1, 0, 0);
      }else{
        image (start2, 0, 0);
      }
      //click to start
      if (mousePressed){
        if (mouseX >= width*95/300 && mouseX <= width*215/300 && 
            mouseY >= height*390/500 && mouseY <= height*435/500){
            gameState = GAME_RUN;
          }
      }
      break;
      
    case GAME_RUN:
      //background
      image(bg1, bgFirstX, 0);
      image(bg2, bgSecondX, 0);
      bgFirstX++;
      bgSecondX++;
      
      if (bgFirstX >= 641){
        bgFirstX = -641;
      }
      if (bgSecondX >= 641){
        bgSecondX = -641;
      }
      
        
      //treasure
      image(treasure, treasureX, treasureY);
      
      //enemy
        //team1
      for(int i=0; i<5; i++){
        image(enemy, enemyX-61*i, enemyY);          
      }
      enemyX += 5; //cannot put in for loop, or the speed will change
      if(enemyX-640-61*4 >= 640){
        enemyY = random(420); 
      }
      enemyX %= (640+61*4)*3; 
  
        //team2
      for(int i=0; i<5; i++){
      image(enemy, enemyX2-61*i , enemyY2+61*i);
      }
       enemyX2 += 5;
         if(enemyX2-640-61*4 >= 640){
        enemyY2 = random(175);
        }
         enemyX2 %= (640+61*4)*3;
   
       //team3
    for(int i=0; i<3; i++){
    image(enemy, enemyX3-61*i, enemyY3-61*i);
    image(enemy, enemyX3-61*i, enemyY3+61*i);
    image(enemy, enemyX3-4*61+61*i, enemyY3-61*i);
    image(enemy, enemyX3-4*61+61*i, enemyY3+61*i);
    }
    enemyX3 += 5;
    if (enemyX3-640-61*4 >= 640){
    enemyY3 = random(122,297);
    }
    enemyX3 %= (640+61*4)*3;
    
    
      //fighter
      image(fighter, fighterX, fighterY); // the rightest, in the middle
        //derection controlling
      if (upPressed){
        fighterY -= fighterSpeed; 
      }
      if (downPressed){
        fighterY += fighterSpeed;
      }
      if (leftPressed){
        fighterX -= fighterSpeed;
      }
      if (rightPressed){
        fighterX += fighterSpeed;
      }
        //boundary controlling
      if (fighterX>589){
        fighterX = 589;
      }
      if (fighterX<0){
        fighterX = 0;
      }
      if (fighterY>429){
        fighterY = 429;
      }
      if (fighterY<0){
        fighterY = 0;
      }
      
      //hp
      fill(#CC0000);
      rectMode(CORNERS);
      rect(10,3,hpX,27); //under
      image(hp, 0, 0); //above
     
     
      
     //when fighter touches treasure, including six situations
     if (treasureX < fighterX && treasureY < fighterY && treasureX + 41 > fighterX && treasureY > fighterY){
       if(hpX<=203){hpX = hpX + (203-10)*10/100;} // add blood 10%
       treasureX = random(600); 
       treasureY = random(440);
     }
     if (treasureX < fighterX && treasureY > fighterY && treasureX + 41 > fighterX && treasureY < fighterY +51){
       if(hpX<=203){hpX = hpX + (203-10)*10/100;}
       treasureX = random(600);
       treasureY = random(440);
     }
     if (treasureX > fighterX && treasureY < fighterY && treasureX < fighterX + 51 && treasureY + 41 > fighterY){
       if(hpX<=203){hpX = hpX + (203-10)*10/100;}
       treasureX = random(600);
       treasureY = random(440);
     } 
     if (treasureX > fighterX && treasureY > fighterY && treasureX < fighterX + 51 && treasureY < fighterY +51){
       if(hpX<=203){hpX = hpX + (203-10)*10/100;}
       treasureX = random(600);
       treasureY = random(440); 
     }
     if (treasureX < fighterX && treasureX + 41 > fighterX && treasureY == fighterY){
       if(hpX<=203){hpX = hpX + (203-10)*10/100;}
       treasureX = random(600);
       treasureY = random(440); 
     }
     if (treasureX > fighterX && fighterX + 51 > treasureX && treasureY == fighterY){
       if(hpX<=203){hpX = hpX + (203-10)*10/100;}
       treasureX = random(600);
       treasureY = random(440); 
     }
  }    
}

          
 



void keyPressed(){
  if (key==CODED){
    switch(keyCode){
      case UP:
        upPressed = true;
      break;
      case DOWN:
        downPressed = true;
      break;
      case LEFT:
        leftPressed = true;
      break;
      case RIGHT:
        rightPressed = true;
      break;
    }
  }
}


void keyReleased(){
  if (key==CODED){
      switch(keyCode){
        case UP:
          upPressed = false;
        break;
        case DOWN:
          downPressed = false;
        break;
        case LEFT:
          leftPressed = false;
        break;
        case RIGHT:
          rightPressed = false;
        break;
      }
  }
}
