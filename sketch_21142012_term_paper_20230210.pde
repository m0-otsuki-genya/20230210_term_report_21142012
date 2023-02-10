//各パラメータの設定。
float baseH = 60;
float armL1 = 30;
float armL2 = 30;
float armL3 = 40;
float armW1 = 9;
float armW2 = 8;
float armW3 = 5;
float angle1 = 0;
float angle2 = 0;
float angle3 = 0;
float dif = 1.0;

float vx,vy,vz,gt,gtx,gtz;

float s1 = sin(angle1*PI/180);
float c1 = cos(angle1*PI/180);
float s2 = sin(angle2*PI/180);
float c2 = cos(angle2*PI/180);
float s3 = sin(angle3*PI/180);
float c3 = cos(angle3*PI/180);
float s23 = s2*c3+c2*s3;
float c23 = c2*c3-s2*s3;


void setup(){
  size(1200, 800, P3D);
  background(255);
}


void draw(){
  
  background(255);
    camera(200, 200, 150, 0, 0, 0, 0, 0, -1);

pushMatrix();  //以下、ロボットアームのコード。
  
  rotateZ(radians(angle1));
  translate(0,0,baseH/2);
  fill(175);
  box(10,10,baseH);
  
  translate(0,0,baseH/2);
  rotateY(radians(angle2));
  translate(0,0,armL1/2);
  fill(150);
  box(armW1,armW1,armL1);
 
  translate(0,0,armL1/2);
  rotateY(radians(angle3));
  translate(0,0,armL2/2);
  fill(125);
  box(armW2,armW2,armL2);

 popMatrix();  //以下、先端のボールの座標設定。
  
  rotateZ(radians(angle1));
  translate(0,0,baseH);
 
  rotateY(radians(angle2));
  translate(0,0,armL1);
 
  rotateY(radians(angle3));
  translate(0,0,armL2+10);
 
  sphere(2.5);


   if(keyPressed){  
     //rキーを押すことで基準姿勢へと戻る。
     if(key == 'r'){
      angle1 = 0;
      angle2 = 0;
      angle3 = 0;
　　  }

  //等速回転による投球の軌跡
   if(key == 's'){
     angle1 = angle1 + dif;
     angle2 = 90;
     angle3 = 0;
      if (angle1 > 360){
        angle1 = 0;
      } 
     rotateY(-angle2-angle3);
     for (int i = 0; i < 10; i++ ) { 
      vx = 0;
      vy = c1*(angle1*PI/180)*(s2*armL2+s23*armL3)+s1*(angle2*PI/180)*(c2*armL2+c23*armL3)+(angle3*PI/180)*armL3*s1*(s2*c1*s23-c2*s23);
      vy = vy + 5;
      vz = 0;
      gt = 1 * i; 
      translate(vx,vy,vz - gt);
      sphere(2.5);
//    delay(100);
      }
    }
   
   //以下、野球のピッチングのような投球
   if(key == 'f'){
     float y = 2 * dif;
     rotateY(radians(-y));
     angle2 = angle2 + dif;
     angle3 = angle3 + dif;
      if (angle2 > 360){
        angle2 = 0;
      }
      if (angle3 > 360){
        angle3 = 0;
      }
     vx = -s1*(angle1*PI/180)*(s2*armL2+s23*armL3)+c1*(angle2*PI/180)*(c2*armL2+c23*armL3)+(angle3*PI/180)*armL3*(c1*c23-s1*s1*s2*s23);
     vz = -(s2*armL2+s23*armL3)*(angle2*PI/180)-s23*armL3*(c1*c1+s1*s1*c2)*(angle3*PI/180); 
      for (int j = 0; j < 20; j++ ) {             
      float s2 = sin(angle2*PI/180);
      float c2 = cos(angle2*PI/180);
      float s3 = sin(angle3*PI/180);
      float c3 = cos(angle3*PI/180);
      float s23 = s2*c3+c2*s3;
      float c23 = c2*c3-s2*s3; 
      gtx = j * s23;
      gtz = j * c23;
      vx = vx + gtx;
      vz = vz - gtz;
      translate(vx + gtx ,0,vz - gtz);
      sphere(2.5);
      }       
   }

 }
}
