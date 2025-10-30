/// <summary>
/// Table CSTPreSelectedPriceLines (ID 50013).
/// </summary>
table 50013 "CSTPreSelectedPriceLines"

{
    Caption = 'Pre-Selected Price Lines';
    DataClassification = ToBeClassified;
    // DrillDownPageID = "CSTPreSelectedPriceLines";
    // LookupPageID = "CSTPreSelectedPriceLines";

    fields
    {
        field(1; "Price List Code"; Code[20])
        {
            Caption = 'Price List Code';
            DataClassification = CustomerContent;
            TableRelation = "Price List Header";
        }
        field(3; "Source Group"; Enum "Price Source Group")
        {
            DataClassification = CustomerContent;
            Caption = 'Source Group';
            InitValue = 11; // 11 = Always "Customer" because sales price lines are being created
            Editable = false;
            Enabled = false;
        }

        field(4; "Source Type"; Enum "Price Source Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Source Type';

            trigger OnValidate()
            begin
                if xRec."Source Type" = Rec."Source Type" then
                    exit;

                if not (Rec."Source Type" in [Rec."Source Type"::Customer, Rec."Source Type"::"Customer Price Group", Rec."Source Type"::Vendor]) then
                    Error(SourceTypeLbl);
            end;
        }

        field(5; "Source No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Source No.';
            TableRelation = if ("Source Type" = const(Customer)) "Customer" where(Blocked = const(" "))
            else
            if ("Source Type" = const("Customer Price Group")) "Customer Price Group"
            else
            if ("Source Type" = const(Vendor)) "Vendor" where(Blocked = const(" "));

            trigger OnValidate()
            var
                Cust: Record Customer;
                CustPriceGrp: Record "Customer Price Group";
                Vend: Record Vendor;
                RecFound: Boolean;

            begin
                if xRec."Source No." = "Source No." then
                    exit;

                Rec.Description := '';

                if Rec."Source Type" = Rec."Source Type"::"Customer Price Group" then begin
                    RecFound := CustPriceGrp.Get("Source No.");
                    if RecFound then
                        Rec.Description := CustPriceGrp.Description;
                end;
                if Rec."Source Type" = Rec."Source Type"::Customer then begin
                    RecFound := Cust.Get("Source No.");
                    if RecFound then
                        Rec.Description := CustPriceGrp.Description;
                end;
                if Rec."Source Type" = Rec."Source Type"::Vendor then begin
                    RecFound := Vend.Get("Source No.");
                    if RecFound then
                        Rec.Description := CustPriceGrp.Description;
                end;

                if not RecFound then
                    Error(MasterDataErrorLbl, "Source Type", "Source No.");
            end;
        }

        field(7; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
            end;
        }

        field(10; Active; Boolean)
        {
            Caption = 'Active';
            DataClassification = CustomerContent;
            InitValue = false;
        }
    }

    keys
    {
        key(PK; "Price List Code", "Source Type", "Source Group", "Source No.")
        {
            Clustered = true;
        }
    }

    var
        SourceTypeLbl: Label 'Only Customer, Customer Price Group and Vendor are supported in this version!';
        MasterDataErrorLbl: Label 'No Masterdata card found for %1 %2.\Please correct the data before proceeding!', Comment = 'Parameters are %1 = Source Type (e.g. Customer) and %2 = Source No. (e.g. 10000)';
}