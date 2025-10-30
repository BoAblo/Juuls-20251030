Codeunit 50003 "UserSetupMgt"
{
    trigger OnRun()
    var
    begin
    end;
    procedure GetUserSetupEmployeeCode(UserIdCode: Code[50]): Code[20]var
        UserSetup: Record "User Setup";
    begin
        if UserIdCode = '' then exit('');
        if UserSetup.Get(UserIdCode)then begin
            if UserSetup."CST Employee Dimension Code" = '' then UserSetup.FieldError("CST Employee Dimension Code", 'CST Employee Dimension Code is not set for this user-id!');
            exit(UserSetup."CST Employee Dimension Code");
        end;
        exit('');
    end;
}
