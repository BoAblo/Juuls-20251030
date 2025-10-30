pageextension 50007 "CST Sales Order Ext." extends "Sales Order"
{
    layout
    {
        addafter("Salesperson Code")
        {
            field("Def. Orderer - Empl. Dim. Code"; Rec."Def. Orderer - Empl. Dim. Code")
            {
                ApplicationArea = All;
                Importance = Additional;
                ToolTip = 'Specifies the value of the Default Orderer - Empl. Dim. Code.', Comment = 'DAN="Default ordretaster - medarbejder dimension."';
                Visible = true;
                ShowMandatory = true;
            }
        }
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
        addafter("Print Confirmation")
        {
            action(SalesDocumentTest)
            {
                Caption = 'Picking Note', comment = 'DAN="Plukseddel"';
                ApplicationArea = All;
                Ellipsis = true;
                ToolTip = 'Plukseddel';

                trigger OnAction()
                var
                    reportPrint: Codeunit "Test Report-Print";
                begin
                    ReportPrint.PrintSalesHeader(Rec);
                end;
            }
        }
        addafter("Print Confirmation_Promoted")
        {
            actionref(SalesDocumentTestPromoted; SalesDocumentTest)
            {
            }
        }
    }
}
