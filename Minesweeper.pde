
import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
public final static int NUM_BOMBS = 23;

private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(500, 500);
    textAlign(CENTER,CENTER);
    bombs = new ArrayList <MSButton>();
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons= new MSButton[NUM_ROWS][NUM_COLS];
    for(int i=0;i<NUM_ROWS;i++)
    {
        for(int j=0;j<NUM_COLS;j++)
        {
            buttons[i][j]= new MSButton(i,j);
        }
    }
    
    setBombs();
}
public void setBombs()
{
while (bombs.size() < NUM_BOMBS) {
int row = (int)(Math.random()*(NUM_ROWS));
    int col = (int)(Math.random()*(NUM_COLS));
  if (!bombs.contains(buttons[row][col])) {

    bombs.add(buttons[row][col]);
  } 
}
}

public void draw ()
{
    background(0);
    if(isWon())
        displayWinningMessage();


}
public boolean isWon()
{
    for(int i = 0;i < NUM_ROWS; i++){
        for(int j = 0; j < NUM_COLS; j++){
            if(!buttons[i][j].isClicked()==true&&!bombs.contains(buttons[i][j])){
                return false;
            }
        }
    }
    return true;
}
public void displayLosingMessage()
{
    for(int i=0;i<NUM_ROWS;i++){
    for(int j=0;j<NUM_COLS;j++){
        if(!buttons[i][j].isClicked()&&bombs.contains(buttons[i][j])){
            buttons[i][j].marked=false;
            buttons[i][j].clicked=true;
                buttons[19][0].setLabel("Y");
                buttons[19][1].setLabel("o");
                buttons[19][2].setLabel("u");
                buttons[19][3].setLabel(" ");
                buttons[19][4].setLabel("L");
                buttons[19][5].setLabel("o");
                buttons[19][6].setLabel("s");
                buttons[19][7].setLabel("t");
                buttons[19][8].setLabel("!");
            }
        }
    }

    
}
public void displayWinningMessage()
{
    buttons[19][0].setLabel("Y");
    buttons[19][1].setLabel("o");
    buttons[19][2].setLabel("u");
    buttons[19][3].setLabel(" ");
    buttons[19][4].setLabel("W");
    buttons[19][5].setLabel("o");
    buttons[19][6].setLabel("n");
    buttons[19][7].setLabel("!");
    
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    
    private String label;
    public MSButton ( int rr, int cc )
    {
        width = 500/NUM_COLS;
        height = 500/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c * width;
        y = r * height;
        label = "";
        marked = clicked=false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    } 
    public void mousePressed () 
    {

        if(mouseButton==LEFT&&!marked){

            clicked = true;

         if(bombs.contains(this)){
            displayLosingMessage();
         } else if(countBombs(r,c)>0){
            label=""+countBombs(r,c);
        }
        else
        {         
          if(isValid(r,c-1) && !buttons[r][c-1].isClicked())
            buttons[r][c-1].mousePressed();
          if(isValid(r,c+1) && !buttons[r][c+1].isClicked())
            buttons[r][c+1].mousePressed();
          if(isValid(r-1,c) && !buttons[r-1][c].isClicked())
            buttons[r-1][c].mousePressed();
          if(isValid(r+1,c) && !buttons[r+1][c].isClicked())
            buttons[r+1][c].mousePressed();
          if(isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked())
            buttons[r-1][c-1].mousePressed();
          if(isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked())
            buttons[r+1][c+1].mousePressed();
          if(isValid(r-1,c+1) && !buttons[r-1][c+1].isClicked())
            buttons[r-1][c+1].mousePressed();
          if(isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked())
            buttons[r+1][c-1].mousePressed();

    }
}
if(mouseButton == RIGHT){
    marked=!marked;
}

    }

    public void draw () 
    {    
        if (marked)
            fill(0);
         else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );
     

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r>= 0 && r<=NUM_ROWS-1 && c<=NUM_COLS-1 && c>=0){
            return true;
        }
        else
        {
            return false;
        }
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row+1,col)&&bombs.contains(buttons[row+1][col])){
            numBombs++;
        }
        if(isValid(row-1,col)&&bombs.contains(buttons[row-1][col])){
            numBombs++;
        }
        if(isValid(row,col-1)&&bombs.contains(buttons[row][col-1])){
            numBombs++;
        }
        if(isValid(row,col+1)&&bombs.contains(buttons[row][col+1])){
            numBombs++;
        }
        if(isValid(row-1,col-1)&&bombs.contains(buttons[row-1][col-1])){
            numBombs++;
        }
        if(isValid(row+1,col-1)&&bombs.contains(buttons[row+1][col-1])){
            numBombs++;
        }
        if(isValid(row+1,col+1)&&bombs.contains(buttons[row+1][col+1])){
            numBombs++;
        }
        if(isValid(row-1,col+1)&&bombs.contains(buttons[row-1][col+1])){
            numBombs++;
        }

        return numBombs;
    }
}
