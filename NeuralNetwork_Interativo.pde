String inputText = "";
String questao1 = "Qual o valor do ângulo?";
String questao2 = "Qual o deslocamento?";
String informacao = "Digite um valor entre '-1' e '1'";
int contadorQuestoes = 0;
int cursorPosition = 0;
int cursorBlinkTimer = 0;
boolean cursorVisible = true;
int textSizeValue = 40;
boolean liberado = false;
boolean inicializado = false;


float r1,r2;


Perceptron brain;
Point[] points = new Point[100];
int trainingIndex = 0;

void setup() {
  size(600, 600);
  textAlign(CENTER, CENTER);
  textSize(textSizeValue);
  
  
  
}

void draw() {
  background(255);
  //Apresenta a reta e o perceptron atualizados
  if(contadorQuestoes == 2){
        liberado = true;
        contadorQuestoes =0;
        println(r1, r2);
      }
  if(liberado == false){
    float textX = width / 2;
    float textY = height / 2;
    if(inputText == ""){
      fill(80,100);
      textSize(30);
      text(informacao, textX, textY);
    }
    fill(0);
    textSize(textSizeValue);
    if(contadorQuestoes == 0){
      text(questao1, textX, textY-100);
    }else{
      text(questao2, textX, textY-100);
    }
    text(inputText, textX, textY);
    //habilita o indicador intermitente de escrita
    if (millis() - cursorBlinkTimer > 1000) {
      cursorVisible = !cursorVisible;
      cursorBlinkTimer = millis();
    }
    //mostra o indicador visual de escrita
    if (cursorVisible) {
      fill(0);
      float cursorX = textWidth(inputText.substring(0, cursorPosition)) + textX - textWidth(inputText) / 2;
      line(cursorX, textY - textSizeValue / 2, cursorX, textY + textSizeValue / 2);
    }
  }else{
    //inicializa os perceptrons caso sejam alterados novamente
    if(inicializado == false){
      brain = new Perceptron(3);
  
      for(int i = 0; i < points.length; i++){
        points[i] = new Point();
      }
      inicializado = true;
    }

    stroke(0);
  
    //desenho da linha de referência
    Point p1 = new Point(-1, f(-1));
    Point p2 = new Point(1, f(1));
    line(p1.pixelX(),p1.pixelY(),p2.pixelX(),p2.pixelY());
    //desenho da linha que representa o aprendizado do programa
    Point p3 = new Point(-1, brain.guessY(-1));
    Point p4 = new Point(1, brain.guessY(1));
    line(p3.pixelX(),p3.pixelY(),p4.pixelX(),p4.pixelY());
  
    //mostra todos os pontos em tela
    for(Point pt : points){
      pt.show();
    }
    // preenche cada ponto em tela com uma cor que representa se o programa acertou ou errou sua posição
    for (Point pt : points){
      float[] inputs = {pt.x, pt.y, pt.b};
      int target = pt.label;  
    
      int guess = brain.guess(inputs);
      if (guess == target){
          fill(0,255,0);
      }else{
          fill(255,0,0);
      }
      noStroke();
      ellipse(pt.pixelX(), pt.pixelY(), 10,10);
    }
    
      //Treino individual de cada ponto, aqui existe um loop onde ocorre o ajusto de cada ponto treinado e quando ele chega no ultimo ponto, reseta
      Point training = points[trainingIndex];
      float[] inputs = {training.x, training.y, training.b};
      int target = training.label;
      brain.train(inputs, target);
      trainingIndex++;
      if( trainingIndex == points.length){
      trainingIndex = 0;
      }

    }
 }

void keyPressed() {
  if (keyCode == LEFT) {
    if (cursorPosition > 0) {
      cursorPosition--;
    }
  } else if (keyCode == RIGHT) {
    if (cursorPosition < inputText.length()) {
      cursorPosition++;
    }
  } else if (key == BACKSPACE) {
    if (inputText.length() > 0 && cursorPosition > 0) {
      inputText = inputText.substring(0, cursorPosition - 1) + inputText.substring(cursorPosition);
      cursorPosition--;
    }
  } else if (key == ENTER) {
  
    println("Texto digitado: " + inputText);
    println(contadorQuestoes);
    //não deixa texto vazio ser enviado e nem a reta ser alterada durante o processo
    if(inputText != "" && liberado == false){
     
      if(contadorQuestoes == 0){
        r1 = parseFloat(inputText);
        contadorQuestoes++;
      }else if(contadorQuestoes == 1){
        r2 = parseFloat(inputText);
        contadorQuestoes++;
      }
    }
    inputText = "";
    cursorPosition = 0;
  } else if (key >= '0' && key <= '9' || key == '.' || key == '-') {
    inputText = inputText.substring(0, cursorPosition) + key + inputText.substring(cursorPosition);
    cursorPosition++;
  } else if (key == 'E' || key == 'e') {
    liberado = false;
    inicializado = false;
  }
}
