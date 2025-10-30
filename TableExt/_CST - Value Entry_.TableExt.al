tableextension 50007 "CST - Value Entry" extends "Value Entry"
{
    fields
    {
        field(50000; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.', Comment = 'DAN="Leverandørnr."';
            ToolTip = 'Vendor No.', Comment = 'DAN="Leverandørnr."';
            TableRelation = Vendor;
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Vendor No." where("No."=field("Item No.")));
        }
    }
}
