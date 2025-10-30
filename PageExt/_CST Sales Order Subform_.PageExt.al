pageextension 50020 "CST Sales Order Subform" extends "Sales Order Subform"
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
    }
}
