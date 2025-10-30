tableextension 50079 "CST Company Information" extends "Company Information"
{
    fields
    {
        field(60000; "Phone No. (web)"; Text[30])
        {
            Caption = 'Phone No. (Web)', comment = 'DAN="Web-telefonnr."';
            ToolTip = 'Phone No. (Web)', comment = 'DAN="Web-telefonnr."';
            ExtendedDatatype = PhoneNo;
        }
        field(60001; "E-Mail (Web)"; Text[80])
        {
            Caption = 'Email (Web)', comment = 'DAN="Web-mail"';
            ToolTip = 'Email (Web)', comment = 'DAN="Web-mail"';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("E-Mail (Web)");
            end;
        }
        field(60002; "Home Page (Web)"; Text[255])
        {
            Caption = 'Home Page (Web)', comment = 'DAN="Web-hjemmeside"';
            ToolTip = 'Home Page (Web)', comment = 'DAN="Web-hjemmeside"';
            ExtendedDatatype = URL;
        }
        field(60020; "ECO-Text"; Text[100])
        {
            Caption = 'ECO-Text', comment = 'DAN="Øko-tekst"';
            ToolTip = 'ECO-Text', comment = 'DAN="Øko-tekst"';
        }
        field(60030; "IBAN (EURO)"; Code[50])
        {
            Caption = 'IBAN (EURO)', comment = 'DAN="IBAN (EURO)"';
            ToolTip = 'IBAN (EURO)', comment = 'DAN="IBAN (EURO)"';

            trigger OnValidate()
            begin
                CheckIBAN("IBAN (EURO)");
            end;
        }
        field(60040; "Picture (Web)"; Blob)
        {
            SubType = Bitmap;
            Caption = 'Picture (Web)', comment = 'DAN="Billede (detail)"';
            ToolTip = 'Picture (Web)', comment = 'DAN="Billede (detail)"';
        }
        field(60041; "DocPicture"; Blob)
        {
            SubType = Bitmap;
            Caption = 'Doc. Picture', comment = 'DAN="Dok. Billede"';
            ToolTip = 'Doc. Picture', comment = 'DAN="Dok. Billede"';
        }
    }
}
