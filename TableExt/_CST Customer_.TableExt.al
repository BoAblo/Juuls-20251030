tableextension 50000 "CST Customer" extends Customer
{
    fields
    {
        field(50000; "Salesperson Code 2"; Code[20])
        {
            Caption = 'Salesperson Code 2', comment = 'DAN="Sælgerkode 2"';
            TableRelation = "Salesperson/Purchaser" where(Blocked=const(false));

            trigger OnValidate()
            begin
                ValidateSalesPersonCode();
            end;
        }
        field(60000; "Company Information (Web)"; Boolean)
        {
            Caption = 'Company Information (Web)', comment = 'DAN="Web-virksomhedsoplysninger"';
            ToolTip = 'Company Information (Web)', comment = 'DAN="Web-virksomhedsoplysninger"';
        }
    }
    local procedure ValidateSalesPersonCode()
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
    begin
        if "Salesperson Code 2" <> '' then if SalespersonPurchaser.Get("Salesperson Code 2")then if SalespersonPurchaser.VerifySalesPersonPurchaserPrivacyBlocked(SalespersonPurchaser)then Error(SalespersonPurchaser.GetPrivacyBlockedGenericText(SalespersonPurchaser, true))end;
}
