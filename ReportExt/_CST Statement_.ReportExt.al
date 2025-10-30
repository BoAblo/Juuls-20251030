reportextension 50004 "CST Statement" extends "Standard Statement"
{
    dataset
    {
        add(Integer)
        {
            column(BankBranchNo_CompanyInfo; CompanyInfo."Bank Branch No.")
            {
            }
            column(CompanyInfo_PhoneNo; CompanyInfo_PhoneNo)
            {
            }
            column(CompanyInfo_EMail; CompanyInfo_EMail)
            {
            }
            column(CompanyInfo_HomePage; CompanyInfo_HomePage)
            {
            }
            column(CompanyBankAccount_IBANEURO; Companyinfo."IBAN (EURO)")
            {
            }
            column(CompanyBankAccount_IBANEUROLbl; CompanyInfo.FieldCaption("IBAN (EURO)"))
            {
            }
            column(CompanyBankAccount_IBAN; Companyinfo.IBAN)
            {
            }
            column(CompanyBankAccount_IBANLbl; CompanyInfo.FieldCaption(IBAN))
            {
            }
            column(CompanyBankAccount_SWIFT; Companyinfo."SWIFT Code")
            {
            }
            column(CompanyBankAccount_SWIFTLbl; CompanyInfo.FieldCaption("SWIFT Code"))
            {
            }
        }
        modify(Integer)
        {
        trigger OnAfterAfterGetRecord()
        begin
            if Customer."Company Information (Web)" then begin
                CompanyInfo_PhoneNo:=CompanyInfo."Phone No. (web)";
                CompanyInfo_EMail:=CompanyInfo."E-Mail (Web)";
                CompanyInfo_HomePage:=CompanyInfo."Home Page (Web)";
            end
            else
            begin
                CompanyInfo_PhoneNo:=CompanyInfo."Phone No.";
                CompanyInfo_EMail:=CompanyInfo."E-Mail";
                CompanyInfo_HomePage:=CompanyInfo."Home Page";
            end;
        end;
        }
    }
    rendering
    {
        layout("JuulsEngrosStatement.rdlc")
        {
            Type = RDLC;
            LayoutFile = './ReportExt/layout/JuulsEngrosStatement.rdlc';
            Caption = 'Juul´s Engros Statment', comment = 'DAN="Juul´s Engros kontoudtog"';
            Summary = 'Juul´s Engros Statment is a customized layout for Juul´s Engros.';
        }
    }
    var CompanyInfo_PhoneNo: Text[30];
    CompanyInfo_EMail: Text[80];
    CompanyInfo_HomePage: Text[255];
}
