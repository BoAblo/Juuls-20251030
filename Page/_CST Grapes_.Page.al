page 50003 "CST Grapes"
{
    Caption = 'Grapes', Comment = 'DAN="Druer"';
    PageType = List;
    SourceTable = "CST Grape";
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Grape; rec.Grape)
                {
                    ToolTip = ' ';
                }
                field(Description; rec.Description)
                {
                    ToolTip = ' ';
                }
            }
        }
    }
    actions
    {
    }
}
