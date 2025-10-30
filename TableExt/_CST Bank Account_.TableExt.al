tableextension 50099 "CST Bank Account" extends "Bank Account"
{
    fields
    {
        field(60030; "IBAN (EURO)"; Code[50])
        {
            Caption = 'IBAN (EURO)', comment = 'DAN="IBAN (EURO)"';
            ToolTip = 'IBAN (EURO)', comment = 'DAN="IBAN (EURO)"';

            trigger OnValidate()
            var
                CompanyInfo: record "Company Information";
            begin
                CompanyInfo.CheckIBAN("IBAN (EURO)");
            end;
        }
    }
}
