pageextension 50043 "CST Sales Invoice Ext." extends "Sales Invoice"
{
    layout
    {
        addafter(Status)
        {
            field(Printed; rec.Printed)
            {
                ApplicationArea = All;
                Importance = Additional;
                ToolTip = 'Printed';
                Visible = true;
            }
            field("Printed by"; rec."Printed by")
            {
                ApplicationArea = All;
                Importance = Additional;
                ToolTip = 'Printed by';
                Visible = true;
            }
        }
    }
}
