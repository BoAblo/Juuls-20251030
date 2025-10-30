pageextension 50011 "CST Sales Inv. Ext." extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Salesperson Code")
        {
            field("Def. Orderer - Empl. Dim. Code"; Rec."Def. Orderer - Empl. Dim. Code")
            {
                ApplicationArea = All;
                Importance = Additional;
                ToolTip = 'Specifies the value of the Default Orderer - Empl. Dim. Code.', Comment = 'DAN="Default ordretaster - medarbejder dimeension."';
                Visible = true;
                ShowMandatory = true;
            }
        }
    }
}
