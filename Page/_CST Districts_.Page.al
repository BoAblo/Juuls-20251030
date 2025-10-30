page 50002 "CST Districts"
{
    Caption = 'Districts', Comment = 'DAN="Distrikter"';
    PageType = List;
    SourceTable = "CST Districts";
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
                field(District; rec.District)
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
