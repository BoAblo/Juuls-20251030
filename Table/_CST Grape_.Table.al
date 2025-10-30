table 50012 "CST Grape"
{
    Caption = 'Grape', Comment = 'DAN="Drue"';
    LookupPageID = "CST Grapes";

    fields
    {
        field(1; Grape; Code[30])
        {
            Caption = 'Grape', Comment = 'DAN="Drue"';
        }
        field(2; Description; Text[80])
        {
            Caption = 'Description', Comment = 'DAN="Beskrivelse"';
        }
    }
    keys
    {
        key(Key1; Grape)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
