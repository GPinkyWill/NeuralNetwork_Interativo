int sign(float n){
  if(n>=0){
    return 1;
  }else{
    return -1;
  }
}

class Perceptron{
  float[] weights;
  float lr = 0.01;
  
  Perceptron(int n){
    weights = new float [n];
    //inicialização dos weights (pesos) de maneira aleatória
    for(int i = 0; i < weights.length ; i++){
      weights[i] = random(-1,1);
    }
  }
  float guessY(float x){
    float m = weights[0] / weights[1];
    float b = weights[2] / weights[1];
    // a soma de todos os pesos vezes suas entradas tem de dar zero
    // w0*x + w1*y + w2*b = 0
    // isolando y temos: y = -(w0/w1)*x - (w2/w1)* b
    return -m * x - b;
  }
  int guess(float[] inputs){
    float sum = 0;
    for(int i = 0; i < weights.length ; i++){
      sum += inputs[i]*weights[i];
    }
    int output = sign(sum);
    return output;
  }
  
  void train(float[] inputs, int target){
    int guess = guess(inputs);
    int error = target - guess;
    // Ajuste em todos os pesos
    for(int i = 0; i < weights.length ; i++){
      weights[i] += error * inputs[i] * lr;
    }
    
  }

}
