codeunit 50006 "CST Sales Mgmt"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnValidateSellToCustomerNoOnBeforeCheckBlockedCustOnDocs, '', false, false)]
    local procedure OnValidateSellToCustomerNoOnBeforeCheckBlockedCustOnDocs(var SalesHeader: Record "Sales Header"; var Cust: Record Customer; var IsHandled: Boolean)
    begin
        IsHandled:=true;
    //Always allow creating sales orders for blocked customers
    end;
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnValidateBillToCustomerNoOnBeforeCheckBlockedCustOnDocs, '', false, false)]
    local procedure OnValidateBillToCustomerNoOnBeforeCheckBlockedCustOnDocs(var SalesHeader: Record "Sales Header"; var Cust: Record Customer; var IsHandled: Boolean)
    begin
        IsHandled:=true;
    //Always allow creating sales orders for blocked customers
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnBeforeReleaseSalesDoc, '', false, false)]
    local procedure OnBeforeReleaseSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean; var SkipCheckReleaseRestrictions: Boolean; SkipWhseRequestOperations: Boolean)
    var
        Customer: record Customer;
    begin
        Customer.get(SalesHeader."Sell-to Customer No.");
        Customer.CheckBlockedCustOnDocs(Customer, SalesHeader."Document Type", false, false);
        If SalesHeader."Sell-to Customer No." <> SalesHeader."Bill-to Customer No." then begin
            Customer.get(SalesHeader."Bill-to Customer No.");
            Customer.CheckBlockedCustOnDocs(Customer, SalesHeader."Document Type", false, false);
        end;
    end;
}
