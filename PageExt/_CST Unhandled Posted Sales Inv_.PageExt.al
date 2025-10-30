pageextension 50032 "CST Unhandled Posted Sales Inv" extends "CDO UnhandledPostedSalesInv."
{
    layout
    {
        addafter("No. Printed (DO)")
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
                Importance = Additional;
                ToolTip = 'Specifies the Location Code for the item in the warehouse.';
                Editable = false;
                Visible = true;
            }
            field("Amount Including VAT"; Rec."Amount Including VAT")
            {
                ApplicationArea = All;
                Importance = Additional;
                ToolTip = 'Specifies the Location Code for the item in the warehouse.';
                Editable = false;
                Visible = true;
            }
        }
    }
}
