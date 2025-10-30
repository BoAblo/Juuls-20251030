tableextension 50009 "CST UserSetup" extends "User Setup"
{
    fields
    {
        field(50001; "CST Employee Dimension Code"; Code[20])
        {
            CaptionClass = GetCaptionClass('MEDARBEJDER');
            Caption = 'Employee Dimension Code';
            TableRelation = "Dimension Value".Code where("Dimension Code"=const('MEDARBEJDER'), Blocked=const(false));
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
            begin
            end;
        }
    }
    trigger OnAfterInsert()
    begin
    end;
    trigger OnAfterModify()
    begin
        CheckEmployeeDimCode();
    end;
    local procedure CheckEmployeeDimCode()
    begin
        if "CST Employee Dimension Code" = '' then FieldError("CST Employee Dimension Code", 'Please select a value for Employee Dimension Code!');
    end;
    local procedure GetCaptionClass(DimCode: Code[20]): Text[250]begin
        exit(Format(GetEmployeeDimNo(DimCode)) + ',2,1');
    end;
    local procedure GetEmployeeDimNo(DimCode: Code[20]): Integer var
        GLSetupShortcutDimCode: array[8]of Code[20];
        Index: Integer;
    begin
        if DimCode = '' then exit(0);
        GetGLSetup(GLSetupShortcutDimCode);
        for Index:=1 to ArrayLen(GLSetupShortcutDimCode)do if GLSetupShortcutDimCode[Index] = DimCode then exit(Index);
        exit(0);
    end;
    procedure GetGLSetup(var GLSetupShortcutDimCode: array[8]of Code[20])
    begin
        if not HasGotGLSetup then begin
            GLSetup.Get();
            GLSetupShortcutDimCode[1]:=GLSetup."Shortcut Dimension 1 Code";
            GLSetupShortcutDimCode[2]:=GLSetup."Shortcut Dimension 2 Code";
            GLSetupShortcutDimCode[3]:=GLSetup."Shortcut Dimension 3 Code";
            GLSetupShortcutDimCode[4]:=GLSetup."Shortcut Dimension 4 Code";
            GLSetupShortcutDimCode[5]:=GLSetup."Shortcut Dimension 5 Code";
            GLSetupShortcutDimCode[6]:=GLSetup."Shortcut Dimension 6 Code";
            GLSetupShortcutDimCode[7]:=GLSetup."Shortcut Dimension 7 Code";
            GLSetupShortcutDimCode[8]:=GLSetup."Shortcut Dimension 8 Code";
            HasGotGLSetup:=true;
        end;
    end;
    var GLSetup: Record "General Ledger Setup";
    HasGotGLSetup: Boolean;
}
