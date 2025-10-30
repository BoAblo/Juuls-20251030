page 50004 "CST Producer"
{
    ApplicationArea = All;
    Caption = 'Producer', Comment = 'DAN="Producent"';
    PageType = List;
    SourceTable = "CST Producer";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Producer; Rec.Producer)
                {
                    ToolTip = 'Specifies the value of the Producer field.', Comment = 'DAN="Producent"';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = 'DAN="Beskrivelse"';
                }
            }
        }
    }
}
