@isTest
public class msquare_controller_unit_test 
{
    @isTest
    static void runTest()
    {
        msquare_controller msc = new msquare_controller();
        // check to see that bottom row middle column value ends up 
        // in middle row, column 0 after rotate
        integer col = msc.m_Rows/2 + 1;
        integer row = msc.m_Rows - 1;
        integer before = msc.Grid[row][col];
        msc.Rotate();
        row = msc.m_Rows/2 + 1;
        col = 0;
        system.assert(before == msc.Grid[row][col]);
        // check to see that bottom row middle column ends up in
        // top row middle column after HorizontalFold
        row = msc.m_Rows - 1;
        col = msc.m_Rows/2 + 1;
        before = msc.Grid[row][col];
        msc.FoldHorizontal();
        system.assert(before == msc.Grid[0][col]);
        // check to see that middle row left column ends up in 
        // middle row right col after VerticalFold
        row = msc.m_Rows/2 + 1;
        col = 0;
        before = msc.Grid[row][col];
        msc.FoldVertical();
        col = msc.m_Rows - 1;
        system.assert(before == msc.Grid[row][col]);
    }
}
