Reportextension 50008 "CST - Customer/Item Sales" extends "Customer/Item Sales" //113
{
    dataset
    {
        modify("Value Entry")
        {
        RequestFilterFields = "Item No.", "Posting Date", "Vendor No.";
        }
    }
}
