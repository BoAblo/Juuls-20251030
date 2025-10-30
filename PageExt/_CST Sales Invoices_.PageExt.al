pageextension 50015 "CST Sales Invoices" extends "Posted Sales Invoices"
{
    actions
    {
        addafter(Print)
        {
            action(EMCS)
            {
                Caption = 'EMCS', comment = 'DAN="EMCS"';
                ApplicationArea = All;
                Ellipsis = true;
                ToolTip = 'EMCS';

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    CurrPage.SETSELECTIONFILTER(SalesInvHeader);
                    Report.Run(50012, true, false, SalesInvHeader);
                end;
            }
        }
        addafter(Print_Promoted)
        {
            actionref(EMCSPromoted; EMCS)
            {
            }
        }
    }
}
