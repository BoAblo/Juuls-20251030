table 50016 "CST Product Type"
{
    Caption = 'Product Type', Comment = 'DAN="Produkt type"';

    fields
    {
        field(1; "Product Type"; Code[30])
        {
            Caption = 'Product Type', Comment = 'DAN="Produkt type"';
        }
        field(2; Description; Text[80])
        {
            Caption = 'Description', Comment = 'DAN="Beskrivelse"';
        }
    }
    keys
    {
        key(Key1; "Product Type")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
