page 50001 "CST Marketing"
{
    ApplicationArea = All;
    Caption = 'CST Marketing', Comment = 'DAN="Markedsføring"';
    PageType = List;
    SourceTable = "CST Marketing";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Marketing "; Rec."Marketing ")
                {
                    ToolTip = 'Specifies the value of the Marketing field.', Comment = 'DAN="Markedsføring"';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = 'DAN="Beskrivelse"';
                }
            }
        }
    }
}
