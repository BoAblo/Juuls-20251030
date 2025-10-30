pageextension 50000 "CST Customer Card Ext" extends "Customer Card"
{
    layout
    {
        addafter("Salesperson Code")
        {
            field(SalesPersonEmail; SalesPersonRec."E-Mail")
            {
                ApplicationArea = All;
                ToolTip = 'Email address of the salesperson.', Comment = 'DAN="Email for sælger"';
                Caption = 'Salesperson Email', Comment = 'DAN="Sælger Email"';
                Importance = Additional;
                Editable = false;
            }
            field("Salesperson Code 2"; Rec."Salesperson Code 2")
            {
                ApplicationArea = All;
                ToolTip = '2. Salesperson', Comment = 'DAN="2. sælger"';
            }
            field(SalesPerson2Email; SalesPerson2Rec."E-Mail")
            {
                ApplicationArea = All;
                ToolTip = 'Email address of the 2. salesperson.', Comment = 'DAN="Email for 2. sælger"';
                Caption = '2. Salesperson Email', Comment = 'DAN="2. Sælger Email"';
                Importance = Additional;
                Editable = false;
            }
            field("Company Information (Web)"; Rec."Company Information (Web)")
            {
                ApplicationArea = All;
            }
        }
    }
    var SalesPersonRec: record "Salesperson/Purchaser";
    SalesPerson2Rec: record "Salesperson/Purchaser";
    trigger OnAfterGetRecord()
    begin
        if not SalesPersonRec.Get(Rec."Salesperson Code")then SalesPersonRec.Init();
        if not SalesPerson2Rec.Get(Rec."Salesperson Code 2")then SalesPerson2Rec.Init();
    end;
}
