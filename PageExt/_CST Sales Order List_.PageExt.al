pageextension 50016 "CST Sales Order List" extends "Sales Order List"
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
// actions
// {
//     addafter(PostAndSend)
//     {
//         action(JuulsPostSendAndPrint)
//         {
//             ApplicationArea = Basic, Suite;
//             Caption = 'Post, Send and Print', comment = 'DAN="Bogfør, send og udskriv"';
//             Ellipsis = true;
//             Image = Print;
//             ToolTip = 'Finalize and prepare to send the document according to the customer''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.';
//             trigger OnAction()
//             var
//                 SalesPostPrint: Codeunit "Sales-Post + Print";
//             begin
//                 PostDocument(CODEUNIT::"Sales-Post and Send");
//                 SalesPostPrint.GetReport(rec);
//             end;
//         }
//     }
//     addafter(PostAndSend_Promoted)
//     {
//         actionref(JuulsPostSendAndPrintPromoted; JuulsPostSendAndPrint)
//         {
//         }
//     }
//}
}
