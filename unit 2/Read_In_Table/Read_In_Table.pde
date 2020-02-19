void setup() {
  //load input into grid
  String[] inputRows = loadStrings("my data.txt");
  int rows = inputRows.length;
  int columns = inputRows[0].split(",").length;
  int[][] grid = new int[rows][columns];
  
  for(int i = 0; i < rows; i++) {
    String[] row = inputRows[i].split(",");
    for(int j = 0; j < columns; j++) {
       grid[i][j] = int(row[j]);
    }
  }
  
  //row sums
  int[] rowSums = new int[rows];
  for(int i = 0; i < rows; i++) {
    int rowSum = 0;
    for(int j = 0; j < columns; j++) {
      rowSum += grid[i][j];
    }
    rowSums[i] = rowSum;
  }
  
  //column sums
  int[] columnSums = new int[columns];
  for(int j = 0; j < columns; j++) {
    int columnSum = 0;
    for(int i = 0; i < rows; i++) {
      columnSum += grid[i][j];
    }
    columnSums[j] = columnSum;
  }
  
  exit();
  println("row sums:");
  printArray(rowSums);
  println();
  println("column sums:");
  printArray(columnSums);
}
