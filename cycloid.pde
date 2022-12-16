int border = 250;
//Pixel to real-life ratio
float scaleRatio = 21.42464;

int pathDetail = 100;
int mx;
void setup(){
  size(800, 800);
  
  textAlign(CENTER);
  textSize(40);
  fill(170);
}

void draw(){
  background(30);
  mx = mouseX;
  //Computing important values
  float scaleFactor = (width - border) / TWO_PI;
  float distToEdge = width - TWO_PI * scaleFactor;
  float mappedMouse = map(mx, distToEdge / 2, width - distToEdge / 2, 0, TWO_PI);
  
  PVector circleCenter = new PVector(mx, height / 2 + scaleFactor);
  PVector pointOnCircle = new PVector(circleCenter.x + sin(mappedMouse + PI) * scaleFactor, 
    circleCenter.y + cos(mappedMouse + PI) * scaleFactor);
  PVector circlePointRelative = pointOnCircle.copy().sub(circleCenter);
  
  //Draw
  drawWheel(pointOnCircle, circleCenter, circlePointRelative, scaleFactor);
  
  drawPath(circleCenter.x + sin(mappedMouse + PI) * scaleFactor, distToEdge / 2,
    distToEdge, scaleFactor, mappedMouse, circleCenter);
    
  noStroke();
  fill(220, 40, 120);
  circle(pointOnCircle.x, pointOnCircle.y, 10);
}

void drawWheel(PVector pointOnCircle, PVector circleCenter, 
  PVector circlePointRelative, float scaleFactor){
  noFill();
  stroke(170);  
  strokeWeight(2);
  
  circle(circleCenter.x, circleCenter.y, scaleFactor * 2);
  line(pointOnCircle.x, pointOnCircle.y, 
    circleCenter.x - circlePointRelative.x, circleCenter.y - circlePointRelative.y);
  line(circleCenter.x + circlePointRelative.y, circleCenter.y - circlePointRelative.x, 
    circleCenter.x - circlePointRelative.y, circleCenter.y + circlePointRelative.x);
}

void drawPath(float min, float max, float distToEdge, 
  float scaleFactor, float mappedMouse, PVector circleCenter)
{
  line(0, height / 2, width, height / 2);
  stroke(220, 40, 120);
  strokeWeight(5);
  PVector lastPoint = new PVector(distToEdge / 2, height / 2);
  for(int i = 0; i < pathDetail; i++){
    float t = map(i, 0, pathDetail, 0, TWO_PI);
    float tNext = map(i + 1, 0, pathDetail, 0, TWO_PI);
    float x = t - sin(t);
    float y = 1 - cos(t);
    PVector point = new PVector(x * scaleFactor + distToEdge / 2, 
      y * scaleFactor + height / 2);
      
    if(x * scaleFactor + distToEdge / 2 > min || mx < max)
      break;
    if((tNext - sin(tNext)) * scaleFactor + distToEdge / 2 
      > circleCenter.x + sin(mappedMouse + PI) * scaleFactor)
    {
      fill(170); 
      text("x: " + toDecimal(x * scaleRatio, 2) + "cm", width / 2, 40);
      text("y: " + toDecimal((2 - y) * scaleRatio, 2) + "cm", width / 2, 80);
    }
    line(point.x, point.y, lastPoint.x, lastPoint.y);
    lastPoint = point.copy();
  }
}


String toDecimal(float f, int i){
  return floor(f) + "." + floor((f - floor(f)) * pow(10, i));
}
