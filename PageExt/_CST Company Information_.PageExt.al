pageextension 50003 "CST Company Information" extends "Company Information"
{
    layout
    {
        addafter(IBAN)
        {
            field("IBAN (EURO)"; Rec."IBAN (EURO)")
            {
                ApplicationArea = All;
            }
        }
        addbefore(Picture)
        {
            field("ECO-Text"; Rec."ECO-Text")
            {
                ApplicationArea = All;
            }
        }
        addafter(Communication)
        {
            group(WebCommunication)
            {
                Caption = 'Communication (Web)', comment = 'DAN="Web-kommunikation"';

                field("Phone No. (web)"; Rec."Phone No. (web)")
                {
                    ApplicationArea = All;
                }
                field("E-Mail (Web)"; Rec."E-Mail (Web)")
                {
                    ApplicationArea = All;
                }
                field("Home Page (Web)"; Rec."Home Page (Web)")
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter(Picture)
        {
            field(PictureWeb; rec."Picture (Web)")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the picture (web) that has been set up for the company, such as a company logo.';

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                end;
            }
        }
    }
}
