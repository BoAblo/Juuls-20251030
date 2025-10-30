table 50000 "CST Producer"
{
    Caption = 'Producer', Comment = 'DAN="Producent"';
    LookupPageID = "CST producer";

    fields
    {
        field(1; Producer; Text[30])
        {
            Caption = 'Producer', Comment = 'DAN="Producent"';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description', Comment = 'DAN="Beskrivelse"';
        }
    }
    keys
    {
        key(Key1; Producer)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
