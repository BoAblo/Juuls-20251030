pageextension 50030 "CST Posted Sales Invoices" extends "Posted Sales Invoices"
{
    layout
    {
        modify("External Document No.")
        {
            Visible = true;
        }
        modify("Amount Including VAT")
        {
            Visible = true;
        }
    }
}
