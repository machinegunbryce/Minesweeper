import de.bezier.guido.*;

private final static int NUM_ROWS = 20;
private final static int NUM_COLS = 20;
private final static int NUM_BOMS = 30;
private MSButton[][] buttons;
private ArrayList <MSButton> mines = new ArrayList <MSButton>();
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    Interactive.make( this );
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int r = 0; r < NUM_ROWS; r++) {
      for (int c = 0; c < NUM_COLS; c++) {
        buttons[r][c] = new MSButton(r,c);}
    }for (int i = 0; i < NUM_BOMS; i++) { 
      setMines();
    }
}
public void setMines()
{
//your code
    int row = (int)(random(NUM_ROWS));
    int col = (int)(random(NUM_COLS));
    if (!mines.contains(buttons[row][col]))
      mines.add(buttons[row][col]);
    }
public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon(){
    for (int i = 0; i < NUM_ROWS; i++) {
      for (int j = 0; j < NUM_COLS; j++) {
        if (!mines.contains(buttons[i][j]) && buttons[i][j].isClicked() == false) {
          return false; }
    } 
  }
  return true;}
public void displayLosingMessage()
{
    String lose = "lose";
    for (int i = 0; i < NUM_COLS; i++) {
      
      buttons[NUM_COLS / 2][i].setLabel(lose.substring(i - 1, i));
    }
}
public void displayWinningMessage()
{
    String win = "win";
    if (isWon())
     for (int i = 0; i < NUM_COLS; i++) {
      buttons[NUM_COLS / 2][i].setLabel(win.substring(i - 1, i));
    }
}
public boolean isValid(int r, int c)
{
    if (r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
      return true;
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    for (int i = row - 1; i <= row + 1; i++) {
      for (int j = col - 1; j <= col + 1; j++) {
        if (isValid(i, j) && mines.contains(buttons[i][j]))
          numMines++;
      }
    }
    if (mines.contains(buttons[row][col]))
      numMines--;
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); 
    }


    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if (mouseButton == RIGHT) {
          flagged = !flagged;
          if (flagged == false)
            clicked = false;
        } 
        else if (mines.contains(this)) {
          displayLosingMessage();
        }
        else if (countMines(myRow, myCol) > 0) {
          setLabel(countMines(myRow, myCol));
        }
        else {
          for (int i = myRow - 1; i <= myRow + 1; i++) {
            for (int j = myCol - 1; j <= myCol + 1; j++) {
              if (isValid(i, j) && !buttons[i][j].clicked)
                buttons[i][j].mousePressed();
            }
          }
        }
    }
    public void draw () 
    {    
        if (flagged)
            fill(100, 50, 0);
         else if( clicked && mines.contains(this) ) 
             fill(50,0,12);
        else if(clicked)
            fill(22,14,155);
        else 
            fill(0,0,0);
        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = "" + newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
    public boolean isClicked()
    {
        return clicked;
    }
}
