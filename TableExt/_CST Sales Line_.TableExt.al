tableextension 50003 "CST Sales Line" extends "Sales Line"
{
    fields
    {
        field(50003; "Deposit Line No. Ref."; Integer)
        {
            Caption = 'Deposit Line No. Ref.', comment = 'DAN="Pantlinje referencenr."';
            DataClassification = CustomerContent;
        }
        field(50099; "POS - VAT Correction"; Boolean)
        {
            Caption = 'POS - VAT Correction', comment = 'DAN="POS - Moms korrektion"';
            DataClassification = CustomerContent;
        }
    }
}
