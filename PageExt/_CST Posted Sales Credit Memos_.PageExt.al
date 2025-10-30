pageextension 50031 "CST Posted Sales Credit Memos" extends "Posted Sales Credit Memos"
{
    layout
    {
        addafter("No. Printed")
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
                Importance = Additional;
                ToolTip = 'Specifies the Location Code for the item in the warehouse.';
                Editable = false;
                Visible = true;
            }
        }
        modify("Amount Including VAT")
        {
            Visible = true;
        }
    }
}
