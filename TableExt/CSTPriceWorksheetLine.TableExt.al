tableextension 50004 CSTPriceWorksheetLine extends "Price Worksheet Line"
{
    fields
    {
        field(50000; "CST Price List Code"; Code[20])
        {
            Caption = 'Juuls Price List Code', comment = 'DAN="Juuls Prisliste Gruppe"';
            ToolTip = 'Price List Code', comment = 'DAN="Juuls Prisliste Gruppe"';
            TableRelation = "Price List Header";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Rec."CST Price List Code" <> '' then begin
                    "Price List Code":=Rec."CST Price List Code";
                    "Source Type":="Source Type"::"Customer Price Group";
                    "Source No.":="CST Price List Code";
                    validate("Assign-to No.", "CST Price List Code");
                end;
            end;
        }
    }
}
