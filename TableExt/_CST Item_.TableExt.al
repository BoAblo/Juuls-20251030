tableextension 50001 "CST Item" extends Item
{
    fields
    {
        field(50001; "GTIN (Kolli)"; Text[14])
        {
            Caption = 'GTIN (Kolli)', comment = 'DAN="GTIN (Kolli)"';
            DataClassification = CustomerContent;
        }
        field(50005; "1ENGROS 1"; Decimal)
        {
            Caption = '1ENGROS 1', comment = 'DAN="1ENGROS 1"';
            FieldClass = FlowField;
            CalcFormula = Lookup("Price List Line"."Unit Price" WHERE("Asset No."=FIELD("No."), "Price List Code"=FILTER('1ENGROS 1'), "Asset Type"=FILTER("Item"), "Source Type"=FILTER("Customer Price Group"), "Source No."=FILTER('1ENGROS 1'), "Ending Date"=FILTER('')));
        }
        field(50006; "2ENGROS 2"; Decimal)
        {
            Caption = '2ENGROS 2', comment = 'DAN="2ENGROS 2"';
            FieldClass = FlowField;
            CalcFormula = Lookup("Price List Line"."Unit Price" WHERE("Asset No."=FIELD("No."), "Price List Code"=FILTER('2ENGROS 2'), "Asset Type"=FILTER("Item"), "Source Type"=FILTER("Customer Price Group"), "Source No."=FILTER('2ENGROS 2'), "Ending Date"=FILTER('')));
        }
        field(50007; "3DETAIL"; Decimal)
        {
            Caption = '3DETAIL', comment = 'DAN="3DETAIL"';
            FieldClass = FlowField;
            CalcFormula = Lookup("Price List Line"."Unit Price" WHERE("Asset No."=FIELD("No."), "Price List Code"=FILTER('3DETAIL'), "Asset Type"=FILTER("Item"), "Source Type"=FILTER("Customer Price Group"), "Source No."=FILTER('3DETAIL'), "Ending Date"=FILTER('')));
        }
        field(50008; "Deposit Code"; Code[20])
        {
            Caption = 'Deposit Code', comment = 'DAN="Pantkode"';
            TableRelation = "CST Deposit Code";
            DataClassification = CustomerContent;
        }
        field(50009; "Best Before / Expires"; Date)
        {
            Caption = 'Best Before / Expires', comment = 'DAN="Bedst før/udløber"';
            DataClassification = CustomerContent;
        }
        field(50012; "Own Item"; Boolean)
        {
            Caption = 'Own Item', comment = 'DAN="Egen vare"';
            DataClassification = CustomerContent;
        }
        field(50013; Producer; Text[250])
        {
            Caption = 'Producer', comment = 'DAN="Producent"';
            DataClassification = CustomerContent;
            TableRelation = "CST Producer";
        }
        field(50014; Country; Text[30])
        {
            Caption = 'Country', comment = 'DAN="Land"';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                IF Country <> xRec.Country THEN Region:='';
            end;
        }
        field(50015; Region; Text[30])
        {
            Caption = 'Region', comment = 'DAN="Region"';
            TableRelation = "CST Regions".Region where(Country=field(Country));
            DataClassification = CustomerContent;
        }
        field(50016; "Age(Year)"; Text[10])
        {
            Caption = 'Age(Year)', comment = 'DAN="Alder (år)"';
            DataClassification = CustomerContent;
        }
        field(50017; District; Text[30])
        {
            Caption = 'District', comment = 'DAN="Distrikt"';
            TableRelation = "CST Districts".District WHERE(Country=FIELD(Country), Region=FIELD(Region));
            DataClassification = CustomerContent;
        }
        field(50021; Biodynamic; Boolean)
        {
            Caption = 'Biodynamic', comment = 'DAN="Biodynamisk"';
            DataClassification = CustomerContent;
        }
        field(50022; Natural; Boolean)
        {
            Caption = 'Natural', comment = 'DAN="Naturvin"';
            DataClassification = CustomerContent;
        }
        field(50024; Marketing; Code[30])
        {
            Caption = 'Marketing', comment = 'DAN="Markedsføring"';
            TableRelation = "CST Marketing";
            DataClassification = CustomerContent;
        }
        field(50025; "Discontinued Item"; Boolean)
        {
            Caption = 'Discontinued Item', comment = 'DAN="Udgået vare"';
            DataClassification = CustomerContent;
        }
        field(50030; "Grape 1"; Code[30])
        {
            Caption = 'Grape 1', comment = 'DAN="Drue 1"';
            TableRelation = "CST Grape";
            DataClassification = CustomerContent;
        }
        field(50031; "Grape 2"; Code[30])
        {
            Caption = 'Grape 2', comment = 'DAN="Drue 2"';
            TableRelation = "CST Grape";
            DataClassification = CustomerContent;
        }
        field(50032; "Grape 3"; Code[30])
        {
            Caption = 'Grape 3', comment = 'DAN="Drue 3"';
            TableRelation = "CST Grape";
            DataClassification = CustomerContent;
        }
        field(50043; "Product Type"; Code[30])
        {
            Caption = 'Product Type', comment = 'DAN="Produkt type"';
            TableRelation = "CST Product Type";
            DataClassification = CustomerContent;
        }
        field(50076; Manufactured; Code[30])
        {
            Caption = 'Manufactured', comment = 'DAN="Fremstillet på"';
            TableRelation = "CST Manufactoring";
            DataClassification = CustomerContent;
        }
        field(50077; "Sell Only in Store"; Boolean)
        {
            Caption = 'Sell Only in Store', comment = 'DAN="Må kun sælges i butik"';
            DataClassification = CustomerContent;
        }
        field(50078; "Inventory Allocation Engros"; Text[50])
        {
            Caption = 'Inventory Allocation Engros', comment = 'DAN="Lagerplacering Engros"';
            DataClassification = CustomerContent;
        }
        field(50079; "Allocated Item"; Boolean)
        {
            Caption = 'Allocated Item', comment = 'DAN="Allokeret vare"';
            DataClassification = CustomerContent;
        }
        field(50080; "Inventory Allocation Værn"; Text[50])
        {
            Caption = 'Inventory Allocation Værn', comment = 'DAN="Lagerplacering Værn"';
            DataClassification = CustomerContent;
        }
        field(50081; "Organic Item"; Boolean)
        {
            Caption = 'Organic Item', comment = 'DAN="Økologisk vare"';
            DataClassification = CustomerContent;
        }
        field(50082; Vintage; Integer)
        {
            Caption = 'Vintage', comment = 'DAN="Årgang"';
            DataClassification = CustomerContent;
        }
    }
    fieldgroups
    {
    addlast(dropdown;
    Inventory, Vintage, "Alcohol%", District)
    {
    }
    }
}
