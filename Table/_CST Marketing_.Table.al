table 50001 "CST Marketing"
{
    Caption = 'CST Marketing', Comment = 'DAN="Markedsføring"';
    LookupPageId = "CST Marketing";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Marketing "; Code[30])
        {
            Caption = 'Marketing ', Comment = 'DAN="Markedsføring"';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description', Comment = 'DAN="Beskrivelse"';
        }
    }
    keys
    {
        key(PK; "Marketing ")
        {
            Clustered = true;
        }
    }
}
