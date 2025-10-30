pageextension 50025 "CST Posted Sales Cr.Memo Subf." extends "Posted Sales Cr. Memo Subform"
{
    layout
    {
        addafter("Unit of Measure Code")
        {
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
                Importance = Additional;
                ToolTip = 'Specifies the Location Code for the item in the warehouse.';
                Editable = false;
                Visible = true;
                ShowMandatory = true;
            }
            field("Bin Code"; Rec."Bin Code")
            {
                ApplicationArea = All;
                Importance = Additional;
                ToolTip = 'Specifies the Bin Code for the item in the warehouse.';
                Editable = false;
                Visible = true;
                ShowMandatory = true;
            }
        }
    }
}
