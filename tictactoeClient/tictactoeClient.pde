import processing.net.*; 

int[][] grid;
Client client; 
boolean turn = false; 

void setup() {
  size(300, 400); 
  grid = new int[3][3];
  strokeWeight(3);
  textAlign(CENTER, CENTER);
  textSize(50);
  client = new Client(this, "127.0.0.1", 1234);
}

void draw() {
  if (turn)
    background(0, 255, 0); 
  else background(255, 0, 0); 

  stroke(0); 
  line(0, 100, 300, 100); 
  line(0, 200, 300, 200); 
  line(100, 0, 100, 300);
  line(200, 0, 200, 300); 

  if (client.available() >0) {
    String message = client.readString(); 
    int r = int(message.substring(0, 1)); 
    int c = int(message.substring(2, 3)); 
    grid[r][c] = 1; 
    turn = true;
  }

  int row = 0; 
  int col = 0;
  while (row<3) {
    drawXO(row, col); 
    col++; 
    if (col == 3) {
      col = 0; 
      row++;
    }
  }
}

void drawXO(int row, int col) {
  pushMatrix(); 
  translate(row*100, col*100); 
  if (grid[row][col] == 1) {
    noFill(); 
    ellipse(50, 50, 90, 90);
  } else if (grid[row][col] == 2) {
    line(10, 10, 90, 90); 
    line(90, 10, 10, 90);
  }
  popMatrix();
}

void mouseReleased() {
  if (turn) {
    int row = (int)mouseX/100; 
    int col = (int)mouseY/100; 
    if (grid[row][col] == 0)
      grid[row][col] = 2;
    client.write(row + " " + col); 
    turn = false;
  }
}
