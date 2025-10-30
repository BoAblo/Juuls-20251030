pageextension 50022 "CST - Value Entries" extends "Value Entries"
{
    layout
    {
        addbefore("Entry No.")
        {
            field("Vendor No."; Rec."Vendor No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
