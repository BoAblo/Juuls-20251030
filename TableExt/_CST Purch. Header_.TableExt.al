tableextension 50010 "CST Purch. Header" extends "Purchase Header"
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
    trigger OnModify()
    var
        UserSetupMgt: Codeunit "UserSetupMgt";
    begin
        if "Def. Orderer - Empl. Dim. Code" = '' then "Def. Orderer - Empl. Dim. Code":=UserSetupMgt.GetUserSetupEmployeeCode(Format(UserId()));
    end;
}
