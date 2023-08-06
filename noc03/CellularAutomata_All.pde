int w = 1800;
int h = 1000;
int cellW = 4;
int cellH = cellW;
int cells = w / cellW;
int rows = h / cellH;
int ruleNumber = 90;

int startTime;
int delay = 0000;

int[] rule;

void settings() {
  size(w, h);
}

void setup() {
  frameRate(.5);
  background(0);
  startTime = millis();
}

void draw() {
  int currentTime = millis();
  
  if (currentTime - startTime <= delay) return;
  
  background(0);

  int[] row = getInitialRow();

  rule = getRule(ruleNumber);

  int j = getRandom();
  
  for (int i = 0; i<rows; i++) {
    drawRow(row, i, j);
    row = getNextRow(row);
  }
  
  drawRuleNumber();
  ruleNumber++;
}

void drawRuleNumber() {
  int numberToDisplay = ruleNumber;
  String numberString = str(numberToDisplay);
  
  textSize(32);
  fill(255, 255, 255);
  text(numberString, w-100, 100);
}

void printIt(int[] arr) {
  for (int i =0; i<arr.length; i++) print(arr[i] + " ");
  println();
}

int[] getInitialRow() {
  int[] row = new int[cells];
  
  for(int i = 0; i<cells; i++) {
    if (i == cells/2) {
      row[i] = 1;
      
    } else {
      row[i] = 0;
    }
  }
  
  return row;
}

int[] getNextRow(int[] row) {
  int[] newRow = getInitialRow();

  for (int i = 1; i<row.length-1; i++) {
    int left = row[i-1]; int self = row[i]; int right = row[i+1];

    int val = left * 4 + self * 2 + right * 1;
    newRow[i] = rule[val];
  }

  return newRow;
}

void drawRow(int[] row, int rowNum, int j) {
  
  for (int i = 0; i < row.length; i++) {
    if (row[i] == 1) fill(255, 255, 255);//fill(getColor(200), getColor(i+j), getColor(150));
    else noFill();

    rect(i*cellW, rowNum*cellH, cellW, cellW);
  }
}

int[] getRule(int num) {
  int[] arr = new int[8];
  int i = 0;

  while(i < 8 && num > 0) {
    arr[i++] = num % 2;
    num /= 2;
  }

  return arr;
}

int getColor(int val) {
  int cycle = val / 255;
  int res = 10;
  
  //val = val < 10 ? val + 20 : val;
  
  if (cycle % 2 == 1) {
    res =  val > 255 ? 255 - (val%255) : val;
    
  } else res = val > 255 ? 0 + (val%255) : val;
  
  return res;
}

int getRandom(){
  return int(random(0, 255));
}
