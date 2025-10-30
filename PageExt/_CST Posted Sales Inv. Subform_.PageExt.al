pageextension 50019 "CST Posted Sales Inv. Subform" extends "Posted Sales Invoice Subform"
{
    layout
    {
        modify("Location Code")
        {
            Visible = true;
            Editable = false;
        }
        modify("Bin Code")
        {
            Visible = true;
            Editable = false;
        }
    }
}
