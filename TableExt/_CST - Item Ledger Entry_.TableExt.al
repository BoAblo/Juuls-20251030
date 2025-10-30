tableextension 50008 "CST - Item Ledger Entry" extends "Item Ledger Entry"
{
    fields
    {
        field(50000; "Customer Posting Group"; Code[20])
        {
            Caption = 'Customer Posting Group', Comment = 'DAN="Debitorbogføringsgruppe"';
            TableRelation = "Customer Posting Group";
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."customer Posting Group" where("No."=field("Source No.")));
            ToolTip = 'Specifies the customer''s market type to link business transactions to.';
        }
    }
}
