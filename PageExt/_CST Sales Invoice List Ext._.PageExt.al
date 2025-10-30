pageextension 50017 "CST Sales Invoice List Ext." extends "Sales Invoice list"
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
    actions
    {
        addafter(Preview)
        {
            action(POSVATCorrection)
            {
                Caption = 'POS - VAT Correction', comment = 'DAN="POS - Momskorrektion"';
                ApplicationArea = All;
                Ellipsis = true;
                ToolTip = 'POS - VAT Correction', comment = 'DAN="POS - Momskorrektion"';

                trigger OnAction()
                var
                begin
                    REPORT.RUN(REPORT::"POS - VAT Correction", TRUE, FALSE);
                end;
            }
        }
        addafter(Preview_Promoted)
        {
            actionref(POSVATCorrectionPromoted; POSVATCorrection)
            {
            }
        }
    }
}
