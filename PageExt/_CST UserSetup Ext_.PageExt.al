pageextension 50004 "CST UserSetup Ext" extends "User Setup"
{
    layout
    {
        addafter("Allow Posting To")
        {
            field("CST Employee Dimension Code"; Rec."CST Employee Dimension Code")
            {
                ApplicationArea = All;
                Importance = Additional;
                ToolTip = 'Specifies the value of the Employee Dimension Code field.', Comment = 'DAN="Medarbejder dimension kode"';
                Visible = true;
                ShowMandatory = true;
            }
        }
    }
}
