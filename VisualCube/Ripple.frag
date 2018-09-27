varying vec4 vertTexCoord;
uniform sampler2D logo;//UECのロゴ画像

uniform float t;//時間
uniform int color;//色を決定するため変数
uniform float r;//波紋の半径
uniform vec2 mouse;

const float PI = 3.1416;

float map(float x, float in_min, float in_max, float out_min, float out_max) {
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

void main()
{
  vec2 p = vertTexCoord.st;
  vec4 col = texture2D(logo, p);

  float dis = length(gl_FragCoord.xy - mouse);

  if(dis < r){
    float extinction = (cos(map(dis, 0.0, r, 0.0, PI)) + 1.0) / 2.0; //減衰率、mouseからの距離disにより 0.0 ~ 1.0 の値を与える。
    float wave = (sin(radians(dis - t)) + 1.0) * extinction / 2.0 * 0.5 + 0.6;//波の高さ
    col.w = wave;
    float cl = 1.0 - extinction * 0.3;//青色発光
    switch(color % 4){
      case 0://青緑
        col.x *= cl; break;
      case 1://緑
        col.xy *= cl; break;
      case 2://黄
        col.z *= cl; break;
      default://白
        break;
    }
  }else{
    col.w = 0.6;
  }

  gl_FragColor = vec4(col);

}
