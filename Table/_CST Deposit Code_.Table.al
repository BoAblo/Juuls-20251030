table 50005 "CST Deposit Code"
{
    Caption = 'CST Deposit Code';
    LookupPageId = "CST Deposit Codes";
    DrillDownPageId = "CST Deposit Codes";
    DataClassification = CustomerContent;

    fields
    {
        field(10; "Code"; Code[20])
        {
            Caption = 'Code', Comment = 'DAN="Kode"';
        }
        field(20; Description; Text[50])
        {
            Caption = 'Description', Comment = 'DAN="Beskrivelse"';
        }
        field(55; "Deposit Item No."; Code[20])
        {
            Caption = 'Deposit Item No.', Comment = 'DAN="Pant varenr."';
            TableRelation = "Item";

            trigger OnValidate()
            var
                Item: Record Item;
            begin
                if "Deposit Item No." <> '' then begin
                    Item.Get("Deposit Item No.");
                    if Item.Type <> Item.Type::"Non-Inventory" then Error(NonInventoryItemErrLbl, "Deposit Item No.");
                end;
            end;
        }
        field(60; "Vendor Posting Group"; Code[20])
        {
            Caption = 'Vendor Posting Group', Comment = 'DAN="Kreditor bogføringsgruppe"';
            TableRelation = "Vendor Posting Group";
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    var NonInventoryItemErrLbl: Label 'The item %1 must be of type Non-Inventory.', Comment = 'DAN="Varen %1 skal være af typen Ikke-Lagerførende."';
}
