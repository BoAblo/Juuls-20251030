page 50008 "CST Regions"
{
    Caption = 'Regions', Comment = 'DAN="Regioner"';
    Editable = true;
    PageType = List;
    SourceTable = "CST Regions";
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Country; rec.Country)
                {
                    ToolTip = ' ';
                }
                field(Region; rec.Region)
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
