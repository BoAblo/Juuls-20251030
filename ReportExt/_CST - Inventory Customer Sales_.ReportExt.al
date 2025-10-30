Reportextension 50009 "CST - Inventory Customer Sales" extends "Inventory - Customer Sales" //713
{
    dataset
    {
        modify("Item Ledger Entry")
        {
        RequestFilterFields = "Posting Date", "Source No.", "Customer Posting Group";
        }
    }
}
