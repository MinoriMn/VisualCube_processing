PShader sd;
PGraphics pg;
PImage uec_logo;
int rx, ry;

void setup(){
  size(800, 800, P3D);
  sd = loadShader("Ripple.frag");
  pg = createGraphics(width, height, P2D);
  
  uec_logo = loadImage("Vo20Pibj_400x400.png");
  uec_logo.resize(width, height);
  sd.set("logo", uec_logo);
  sd.set("r", 600.0);
  
  fill(0x00);
  noStroke();
  smooth();
  blendMode(ADD);
  
}

void draw() {  
  background(0x00);
  
  //左クリックを押しながらマウスを動かすことで立体図形を回転させることが出来る。
  if (mousePressed == true){
    rx += mouseX - pmouseX;
    ry += mouseY - pmouseY;
  }
  
  sd.set("t", millis() / 3.0); //時間情報
  sd.set("color", millis() / 1500); //色を時間で指定する
  sd.set("mouse", (float)mouseX, (float)(height - mouseY)); //マウス情報
  
  pg.beginDraw();
  pg.shader(sd);
  pg.background(0, 0);
  pg.rect(0, 0, width, height);
  pg.endDraw();
  
  //描画の準備
  translate(width / 2, height / 2);
  rotateY(radians(rx));
  rotateX(radians(ry));
  
  drawTexedBox(300, pg.get());

}

void drawTexedBox(float a, PImage img){
  float half_a = a / 2f;
  
  beginShape(QUAD);
  texture(img);
  textureMode(NORMAL);
  
  //top
  vertex(-half_a, -half_a, -half_a, 0, 0);
  vertex(half_a, -half_a, -half_a, 1, 0);
  vertex(half_a, -half_a, half_a, 1, 1);
  vertex(-half_a, -half_a, half_a, 0, 1);
  
  //bottom
  vertex(-half_a, half_a, half_a, 0, 0);
  vertex(half_a, half_a, half_a, 1, 0);
  vertex(half_a, half_a, -half_a, 1, 1);
  vertex(-half_a, half_a, -half_a, 0, 1);
  
  //side
  vertex(-half_a, -half_a, half_a, 0, 0);
  vertex(half_a, -half_a, half_a, 1, 0);
  vertex(half_a, half_a, half_a, 1, 1);
  vertex(-half_a, half_a, half_a, 0, 1);
  
  vertex(half_a, -half_a, -half_a, 0, 0);
  vertex(-half_a, -half_a, -half_a, 1, 0);
  vertex(-half_a, half_a, -half_a, 1, 1);
  vertex(half_a, half_a, -half_a, 0, 1);
  
  vertex(half_a, -half_a, half_a, 0, 0);
  vertex(half_a, -half_a, -half_a, 1, 0);
  vertex(half_a, half_a, -half_a, 1, 1);
  vertex(half_a, half_a, half_a, 0, 1);
  
  vertex(-half_a, -half_a, -half_a, 0, 0);
  vertex(-half_a, -half_a, half_a, 1, 0);
  vertex(-half_a, half_a, half_a, 1, 1);
  vertex(-half_a, half_a, -half_a, 0, 1);
  
  endShape();
}
