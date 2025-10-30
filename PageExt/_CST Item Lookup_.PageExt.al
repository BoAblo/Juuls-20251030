pageextension 50005 "CST Item Lookup" extends "Item Lookup"
{
    layout
    {
        addafter(Description)
        {
            field("Alcohol%"; Rec."Alcohol%")
            {
                ApplicationArea = All;
                ToolTip = 'ToolTip';
            }
            field(Vintage; Rec.Vintage)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vintage field.', Comment = 'DAN="Årgang"';
            }
            field("Own Item"; Rec."Own Item")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Own Item field.', Comment = 'DAN="Egen vare"';
            }
        }
        addafter("Unit Price")
        {
            field("1ENGROS 1"; Rec."1ENGROS 1")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the 1ENGROS 1 field.';
            }
            field("2ENGROS 2"; Rec."2ENGROS 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the 2ENGROS 2 field.';
            }
            field("3DETAIL"; Rec."3DETAIL")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the 3DETAIL field.';
            }
            field("Deposit Code"; Rec."Deposit Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Deposit Code field.', Comment = 'DAN="Pantkode"';
            }
        }
    }
}
