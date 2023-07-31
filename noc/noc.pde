int w = 1600;
int h = 1000;
int cellW = 2;
int cellH = cellW;
int cells = w / cellW;
int rows = h / cellH;

int[] rule = {0, 1, 0, 1, 1, 0, 1, 0};

void settings() {
  size(w, h);
}

void setup() {
  background(0);
  frameRate(1);
}

void draw() {
    int[] row = getInitialRow();
    
    for (int i = 0; i<rows; i++) {
      drawRow(row, i);
      row = getNextRow(row);
    }

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

void drawRow(int[] row, int rowNum) {  
  for (int i = 0; i < row.length; i++) {
    if (row[i] == 1) fill(255);
    else noFill();

    rect(i*cellW, rowNum*cellH, cellW, cellW);
  }
}

int getRandom(){
  return int(random(0, 255));
}
