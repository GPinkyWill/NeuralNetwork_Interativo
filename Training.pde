float f(float x){
  // y = mx + b
  return r1 * x + r2;
}

class Point{
  float x;
  float y;
  float b;
  int label;

  Point(){
    x = random(-1,1);
    y = random (-1,1);
    //b é de Bias, na soma das duas entradas existe a possibilidade do resultado dar 0
    //para que isso não ocorra e o programa consiga dar um retorno enviamos uma constante
    b = 1;
    float lineY = f(x);
    
    if (y > lineY){
      label = 1;
    }else{
      label = -1;
    }
    
  }
  
  Point(float x_, float y_){
    x = x_;
    y = y_;
    b = 1;
    
  }
  
  
  
  
  //conversão dos valores de X e Y para uma posição mapeada na tela
  float pixelX(){
    return map(x,-1,1,0,width);
  }
  
  float pixelY(){
  return map(y,-1,1,height,0);
  }
  
  
  
  void show(){
    stroke(0);
    if ( label == 1){
      fill(255);
    }else{
      fill(0);
    }
    
    float px = pixelX();
    float py = pixelY();
    ellipse(px,py,20,20);
  }
}
