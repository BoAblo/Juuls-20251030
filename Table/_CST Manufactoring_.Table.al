table 50015 "CST Manufactoring"
{
    Caption = 'Manufactoring', Comment = 'DAN="Fremstilling"';
    LookupPageID = "CST Manufactoring";

    fields
    {
        field(1; Manufactoring; Code[30])
        {
            Caption = 'Manufactoring', Comment = 'DAN="Fremstilling"';
        }
        field(2; Description; Text[80])
        {
            Caption = 'Description', Comment = 'DAN="Beskrivelse"';
        }
    }
    keys
    {
        key(Key1; Manufactoring)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
