tableextension 50002 "CST Sales Header" extends "Sales Header"
{
    fields
    {
        field(50000; "Def. Orderer - Empl. Dim. Code"; Code[50])
        {
            Caption = 'Default Orderer - Employee Dim. Code', comment = 'DAN="Ordretaster - medarbejder dimension."';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = "Dimension Value".Code where("Dimension Code"=const('MEDARBEJDER'), Blocked=const(false));
            Editable = false;
        }
        field(50001; Printed; Boolean)
        {
            Caption = 'Printed', comment = 'DAN="Udskrevet"';
            Editable = true;
        }
        field(50002; "Printed by"; Text[10])
        {
            Caption = 'Printed by', comment = 'DAN="Udskrevet af"';
            Editable = true;
        }
        field(50099; "POS - VAT Correction"; Boolean)
        {
            Caption = 'POS - VAT Correction', comment = 'DAN="POS - Moms korrektion"';
            DataClassification = CustomerContent;
        }
    }
    trigger OnModify()
    var
        UserSetupMgt: Codeunit "UserSetupMgt";
    begin
        if "Def. Orderer - Empl. Dim. Code" = '' then "Def. Orderer - Empl. Dim. Code":=UserSetupMgt.GetUserSetupEmployeeCode(Format(UserId()));
    end;
}
