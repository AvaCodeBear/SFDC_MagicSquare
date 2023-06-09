public with sharing class msquare_controller 
{
    public integer m_Rows {get; set;}
    public integer m_StartVal {get; set;}
    public integer m_Slope {get; set;}
    public integer m_Const {get; set;}
    public integer m_magicNumber {get; set;}
    public List<List<integer>> Grid {get; set;}
    public string m_Table {get; set;}
    public integer m_Rrotations {get; set;}
    public integer m_Lrotations {get; set;}
    private boolean m_HFold = false;
    private boolean m_VFold = false;
    public string m_hFoldMessage {get; set;}
    public string m_vFoldMessage {get; set;}


    public msquare_controller() 
    {
        m_Rows = randomValue(3,15,true);
        m_Slope = randomValue(1,9,false);
        m_Const = randomValue(0,10,false);
        m_StartVal = randomValue(0,10,false);
        m_Rrotations = randomValue(0,3,false);
        m_Lrotations = m_Rrotations > 0 ? 4 - m_Rrotations : 0;
        integer foldFlag = Math.mod(Math.round((Math.random() * 100.0)),2);
        if(foldFlag == 1) m_HFold = true;
        foldFlag = foldFlag = Math.mod(Math.round((Math.random() * 100.0)),2);
        if(foldFlag == 1) m_VFold = true;
        m_magicNumber = 0;
        m_hFoldMessage = m_HFold ? 'Folded About the Horizontal Axis': '';
        m_vFoldMessage = m_VFold ? 'Folded About the Vertical Axis' : '';
        Initialize();
        for(integer r = 0; r < m_Rrotations; r++)
            Rotate();
        if(m_HFold)
            FoldHorizontal();
        if(m_VFold)
            FoldVertical();
        Build_Table();
    }

    private Integer randomValue(Integer minVal, Integer maxVal, boolean mustbeOdd)
    {
        Integer rnd = Math.mod((DateTime.Now()).millisecond(),maxVal+1);
        if(rnd < minVal) rnd += minVal;
        if(mustbeOdd && Math.mod(rnd,2) == 0) rnd++;
        if(rnd > maxVal) rnd -= 2;
        return rnd;
    }

    // Folds Once about the X axis
    public void FoldHorizontal()
    {
        List<integer> tmp; // = new List<integer>();
        integer trow = 0;
        integer brow = m_Rows - 1;
        while(trow < brow)
        {
            tmp = Grid[trow];
            Grid[trow++] = Grid[brow];
            Grid[brow--] = tmp;
        }
    }

    // Folds once about the Y axis
    public void FoldVertical()
    {
        integer tmp;
        for(integer row = 0; row < m_Rows; row++)
        {
            integer scol = 0;
            integer ecol = m_Rows-1;
            while(scol < ecol)
            {
                tmp = Grid[row][scol];
                Grid[row][scol++] = Grid[row][ecol];
                Grid[row][ecol--] = tmp;
            }
        }
    }

    // Rotates Grid to the right once.
    // call in a loop to rotate N times.
    // to Rotate Left N times, Rotate Right (4-N) times
    public void Rotate()
    {
        List<List<integer>> tmpGrid = new List<List<integer>>();
        for(integer rn = 0; rn < m_Rows; rn++)
            tmpGrid.add(FetchColumn(rn));
        Grid = tmpGrid;
     }

    // returns column cn from bottom to top
    private List<integer> FetchColumn(integer cn)
    {
        List<integer> rVal = new List<integer>();

        if(cn >= 0 && cn < m_Rows)
        {
            for(integer rn = m_Rows-1; rn >= 0; rn--)
                rVal.add(Grid[rn][cn]);
        }
        return rVal;
    }

    public void Initialize()
    {
        Grid = new List<List<integer>>();
        // y = mx+b
        integer curY = 0;
        integer curX = m_StartVal;
        //integer curSlope = m_Slope;
        //integer curConst = m_Const; 
         
        for(integer rn = 0; rn < m_Rows; rn++)
        {
            Grid.add(new List<integer>());
            for(integer cn = 0; cn < m_Rows; cn++)
                Grid[rn].add(null);
        }

        integer curRow = m_Rows - 1;
        integer curCol = m_Rows / 2;
        integer rowDir = -2;
        integer colDir = -1;

 
        while(Grid[curRow][curCol] == null)
        {
            Grid[curRow][curCol] = m_Slope*curX + m_Const;
            curX++;
            integer nr = curRow + rowDir;
            integer nc = curCol + colDir;
            if(nr < 0)
                nr = m_Rows + nr;
            else if(nr >= m_Rows)
                nr = m_Rows - nr;
            
            if(nc < 0)
                nc = m_Rows + nc;
            else if(nc >= m_Rows)
                nc = m_Rows - nc;

            
            if( Grid[nr][nc] != null)
            {
                nr = curRow-1;
                nc = curCol;
            }
            curRow = nr;
            curCol = nc;
            if(curRow < 0 || curRow >= m_Rows || curCol < 0 || curCol >= m_Rows)
                break;                
        }
        for(Integer cn = 0; cn < m_Rows; cn++)
        {
            m_magicNumber += Grid[0][cn];
        }
    }

    private void Build_Table()
    {
        m_Table = '<br/><br/><table border=\"1px solid black\" align=\"center\">';
        for(integer row = 0; row < m_Rows; row++)
        {
            m_Table += '<tr>';
            for(integer col = 0; col < m_Rows; col++)
            {
                m_Table += '<td style=\"text-align:center\">' + Grid[row][col] + '</td>';
            }
            m_Table += '</tr>';
        }
        m_Table += '</table>';
    }
}