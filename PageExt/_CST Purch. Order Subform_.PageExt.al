pageextension 50021 "CST Purch. Order Subform" extends "Purchase Order Subform"
{
    layout
    {
        modify("Location Code")
        {
            Visible = true;
        }
        modify("Bin Code")
        {
            Visible = true;
        }
        modify("Line Discount %")
        {
            Visible = true;
        }
    }
}
