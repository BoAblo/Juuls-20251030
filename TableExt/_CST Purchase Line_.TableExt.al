tableextension 50015 "CST Purchase Line" extends "Purchase Line"
{
    fields
    {
        field(50003; "Deposit Line No. Ref."; Integer)
        {
            Caption = 'Deposit Line No. Ref.', comment = 'DAN="Pantlinje referencenr."';
            DataClassification = CustomerContent;
        }
        field(50004; "Has Deposit Line"; Boolean)
        {
            Caption = 'Has Deposit Line', comment = 'DAN="Har pantlinje"';
            DataClassification = CustomerContent;
        }
    }
}
