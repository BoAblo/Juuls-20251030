pageextension 50028 "CST - Item Ledger Entries" extends "Item Ledger Entries"
{
    layout
    {
        addbefore("Entry No.")
        {
            field("Customer Posting Group"; Rec."Customer Posting Group")
            {
                ApplicationArea = All;
            }
        }
    }
}
