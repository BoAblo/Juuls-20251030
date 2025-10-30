tableextension 50012 "CST Purch. Inv. Header" extends "Purch. Inv. Header"
{
    fields
    {
        field(50000; "Def. Orderer - Empl. Dim. Code"; Code[50])
        {
            Caption = 'Default Orderer - Employee Dim. Code';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = "Dimension Value".Code where("Dimension Code"=const('MEDARBEJDER'), Blocked=const(false));
            Editable = false;
        }
    }
}
