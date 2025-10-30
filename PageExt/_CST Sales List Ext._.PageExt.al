pageextension 50045 "CST Sales List Ext." extends "Sales list"
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
