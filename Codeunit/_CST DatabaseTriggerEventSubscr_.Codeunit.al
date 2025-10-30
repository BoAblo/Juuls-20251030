codeunit 50009 "CST DatabaseTriggerEventSubscr"
{
    trigger OnRun()
    begin
    end;
    //Table 270
    [EventSubscriber(ObjectType::Table, 270, 'OnAfterCopyBankFieldsFromCompanyInfo', '', false, false)]
    local procedure OnAfterCopyBankFieldsFromCompanyInfo(var BankAccount: Record "Bank Account"; CompanyInformation: Record "Company Information")
    begin
        CompanyInformation.get();
        BankAccount."IBAN (EURO)":=CompanyInformation."IBAN (EURO)";
    end;
    //Report 1306
    [EventSubscriber(ObjectType::Report, report::"Standard sales - Invoice", 'OnBeforeFillRightHeader', '', false, false)]
    local procedure OnBeforeFillRightHeader(var SalesInvoiceHeader: Record "Sales Invoice Header"; SalespersonPurchaser: Record "Salesperson/Purchaser"; var SalesPersonText: Text; var RightHeader: Record "Name/Value Buffer"; var IsHandled: Boolean)
    begin
        IsHandled:=True;
    end;
    //SubstituteReport
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnSubstituteReport(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = Report::"Picking List" then NewReportID:=Report::"CST - Picking List";
    end;
}
