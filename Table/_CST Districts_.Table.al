table 50011 "CST Districts"
{
    Caption = 'Districts', Comment = 'DAN="Distrikter"';
    LookupPageID = "CST Districts";

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
            TableRelation = "CST Regions".Region WHERE(Country=FIELD(Country));
        }
        field(3; District; Text[30])
        {
            Caption = 'District', Comment = 'DAN="Distrikt"';
        }
    }
    keys
    {
        key(Key1; Country, Region, District)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
