table 50010 "CST Regions"
{
    Caption = 'Regions', Comment = 'DAN="Regioner"';
    LookupPageID = "CST Regions";

    fields
    {
        field(1; Country; Text[30])
        {
            Caption = 'Country', Comment = 'DAN="Land"';
            TableRelation = "Country/Region";
        }
        field(2; Region; Text[30])
        {
            Caption = 'Region', Comment = 'DAN="Region"';
        }
    }
    keys
    {
        key(Key1; Country, Region)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
