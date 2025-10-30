page 50012 "CST Deposit Codes"
{
    ApplicationArea = All;
    Caption = 'CST Deposit Codes', Comment = 'DAN="Pant Koder"';
    PageType = List;
    SourceTable = "CST Deposit Code";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = 'DAN="Kode"';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = 'DAN="Beskrivelse"';
                }
                field("Deposit Item No."; Rec."Deposit Item No.")
                {
                    ToolTip = 'Specifies the value of the Deposit Item No. field.', Comment = 'DAN="Pant varenr."';
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    ToolTip = 'Specifies the value of the Vendor Posting Group field.', Comment = 'DAN="Kreditor bogføringsgruppe"';
                }
            }
        }
    }
}
