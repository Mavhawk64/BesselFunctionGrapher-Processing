import java.math.*;
ArrayList <PVector> myPoints;
MathContext mc = new MathContext(100);
float px = 0;
int sc = 25;
color myColor;
int besselNum = 1;
void setup() {
  size(700, 700);
  background(0);
  myPoints = new ArrayList<PVector>();
  float rand = floor(random(5));
  
  if(rand == 0) {
    myColor = color(77,238,234);
  } else if(rand == 1) {
    myColor = color(116,238,21);
  } else if(rand == 2) {
    myColor = color(255,231,0);
  } else if(rand == 3) {
    myColor = color(240,0,255);
  } else {
    myColor = color(0,30,255);
  }
  
}

void draw() {
  stroke(255);
  translate(0, height / 2);
  line(0, 0, width, 0);
  stroke(myColor);
  myPoints.add(new PVector(px*sc, -height / 2 * J(new BigDecimal(px), besselNum)));
  point(myPoints.get(myPoints.size() - 1).x, myPoints.get(myPoints.size() - 1).y);
  px += 0.1;
  for(int i = 1; i < myPoints.size(); i++) {
    line(myPoints.get(i - 1).x, myPoints.get(i - 1).y, myPoints.get(i).x, myPoints.get(i).y);
  }
  if(px > width) {
    noLoop();
  }
  //noLoop();
}

float J(BigDecimal x, int m) {
  BigDecimal s = BigDecimal.ZERO;
  for (int l = 0; l <= width; l++) {
    //Numerators
    BigDecimal num1 = BigDecimal.ONE.negate().pow(l, mc);
    BigDecimal num2 = x.pow(2*l+m, mc);
    BigDecimal num = num1.multiply(num2, mc);
    //Denominators
    BigDecimal den1 = (new BigDecimal(2)).pow(2*l+m);
    BigDecimal den2 = factorial(l);
    BigDecimal den3 = factorial(l + m);
    BigDecimal den = (den1.multiply(den2, mc)).multiply(den3, mc);
    //Quotient
    BigDecimal quot = num.divide(den, mc);
    //println(quot);
    //println(num + " / " + den + " = " + tot);
    s = s.add(quot, mc);
    //println("Sum: " + s);
  }
 // println(s);
  //println(s.floatValue());
  return s.floatValue();
}

BigDecimal factorial(int n) {
  BigDecimal p = BigDecimal.ONE;
  while (n > 1) {
    p = p.multiply(new BigDecimal(n), mc);
    n--;
  }
  return p;
}
