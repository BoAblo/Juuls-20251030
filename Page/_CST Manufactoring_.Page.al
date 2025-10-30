page 50015 "CST Manufactoring"
{
    Caption = 'Manufactoring', Comment = 'DAN="Fremstilling"';
    PageType = List;
    SourceTable = "CST Manufactoring";
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Manufactoring; rec.Manufactoring)
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
