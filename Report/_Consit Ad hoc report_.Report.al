report 50090 "Consit Ad hoc report"
{
    DefaultLayout = RDLC;
    ApplicationArea = All;
    UsageCategory = Administration;
    RDLCLayout = './Report/layout/ConsitAdHoc.rdlc';
    Caption = 'Consit Ad hoc report med layout';

    dataset
    {
        dataitem(Item; Item)
        {
            column(ItemNo; Item."No.")
            {
            }
            column(Inventory; item.Inventory)
            {
            }
            column(RemainingQty; RemainingQty)
            {
            }
            column(Diff; Diff)
            {
            }
            trigger OnAfterGetRecord()
            var
                ItemLedgerEntry: Record "Item Ledger Entry";
            begin
                RemainingQty:=0;
                Diff:=0;
                Item.CalcFields(Inventory);
                ItemLedgerEntry.SetRange("Item No.", Item."No.");
                If ItemLedgerEntry.FindSet()then repeat RemainingQty:=RemainingQty + ItemLedgerEntry."Remaining Quantity";
                    until ItemLedgerEntry.Next() = 0;
                if RemainingQty = Item.Inventory then CurrReport.Skip()
                else
                    Diff:=Item.Inventory - RemainingQty;
                Modify();
            end;
        }
    }
    var RemainingQty: Decimal;
    Diff: Decimal;
// Permissions = tabledata "Item Ledger Entry" = rm, tabledata "Duty Entry" = rm,
//               tabledata "Purch. Cr. Memo Hdr." = rm, tabledata "Purch. Cr. Memo Line" = rm,
//               tabledata "Purch. Inv. Header" = rm, tabledata "Purch. Inv. Line" = rm,
//               tabledata "Purch. Rcpt. Header" = rm, tabledata "Purch. Rcpt. Line" = rm;
// ApplicationArea = All;
// UsageCategory = Administration;
// Caption = 'Consit - Ad Hoc rapport';
// ProcessingOnly = true;
// dataset
// {
//     dataitem(Vendor; Vendor)
//     {
//         DataItemTableView = where("No." = filter('<>338'));
//         trigger OnAfterGetRecord()
//         begin
//             if "Duty Free" then
//                 "Duty Free" := false
//             else
//                 "Duty Free" := true;
//             Modify();
//         end;
//     }
//     dataitem("Item Ledger Entry"; "Item Ledger Entry")
//     {
//         DataItemTableView = where("Entry Type" = filter(Purchase), "Posting Date" = filter('010625D..'));
//         trigger OnAfterGetRecord()
//         begin
//             if "Duty Free" then
//                 "Duty Free" := false
//             else
//                 "Duty Free" := true;
//             Modify();
//         end;
//     }
//     //Denne bliver aldrig sat
//     // dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
//     // {
//     //     DataItemTableView = where("Duty Entry Type" = filter(Purchase),"Posting Date" = filter('010625D..'));
//     //     trigger OnAfterGetRecord()
//     //     begin
//     //         if "Duty Free" then
//     //             "Duty Free" := false
//     //         else
//     //             "Duty Free" := true;
//     //         Modify();
//     //     end;
//     // }
//     dataitem("Duty Entry"; "Duty Entry")
//     {
//         DataItemTableView = where("Duty Entry Type" = filter(Purchase), "Posting Date" = filter('010625D..'));
//         trigger OnAfterGetRecord()
//         var
//             DutyGroupLine: Record "Duty Group Line";
//         begin
//             if "Duty Free" then begin
//                 "Duty Free" := false;
//                 DutyGroupLine.reset();
//                 DutyGroupLine.setrange("Duty Group Code", "Duty Entry"."Duty Group Code");
//                 DutyGroupLine.setrange("Duty Entry Type", "Duty Entry Type"::Purchase);
//                 if DutyGroupLine.FindFirst() then
//                     if DutyGroupLine.Quantity <> 0 then begin
//                         "Duty Entry"."Duty Amount (LCY)" := ("Duty Entry".Quantity * DutyGroupLine.Quantity) * "Duty Entry"."Duty Price (LCY)";
//                         "Duty Entry"."Duty Amount" := ("Duty Entry".Quantity * DutyGroupLine.Quantity) * "Duty Entry"."Duty Price";
//                     end;
//             end
//             else begin
//                 "Duty Entry"."Duty Amount (LCY)" := 0;
//                 "Duty Entry"."Duty Amount" := 0;
//                 "Duty Free" := true;
//             end;
//             Modify();
//         end;
//     }
//     dataitem("Purchase Header"; "Purchase Header")
//     {
//         DataItemTableView = where("Posting Date" = filter('010625D..'));
//         trigger OnAfterGetRecord()
//         var
//             PurchaseLine: Record "Purchase Line";
//         begin
//             if "Duty Free" then
//                 "Duty Free" := false
//             else
//                 "Duty Free" := true;
//             Modify();
//             PurchaseLine.SetRange("Document Type", "Purchase Header"."Document Type");
//             PurchaseLine.SetRange("Document No.", "Purchase Header"."No.");
//             PurchaseLine.SetRange(Type, PurchaseLine.type::Item);
//             if PurchaseLine.findset() then
//                 repeat
//                     if PurchaseLine."Duty Free" then
//                         PurchaseLine."Duty Free" := false
//                     else
//                         PurchaseLine."Duty Free" := true;
//                     PurchaseLine.Modify();
//                 until PurchaseLine.Next() = 0;
//         end;
//     }
//     dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
//     {
//         DataItemTableView = where("Posting Date" = filter('010625D..'));
//         trigger OnAfterGetRecord()
//         var
//             PurchaseCrMemoLine: Record "Purch. Cr. Memo Line";
//         begin
//             if "Duty Free" then
//                 "Duty Free" := false
//             else
//                 "Duty Free" := true;
//             Modify();
//             PurchaseCrMemoLine.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
//             PurchaseCrMemoLine.SetRange(Type, PurchaseCrMemoLine.type::Item);
//             if PurchaseCrMemoLine.findset() then
//                 repeat
//                     if PurchaseCrMemoLine."Duty Free" then
//                         PurchaseCrMemoLine."Duty Free" := false
//                     else
//                         PurchaseCrMemoLine."Duty Free" := true;
//                     PurchaseCrMemoLine.Modify();
//                 until PurchaseCrMemoLine.Next() = 0;
//         end;
//     }
//     dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
//     {
//         DataItemTableView = where("Posting Date" = filter('010625D..'));
//         trigger OnAfterGetRecord()
//         var
//             PurchaseInvLine: Record "Purch. Inv. Line";
//         begin
//             if "Duty Free" then
//                 "Duty Free" := false
//             else
//                 "Duty Free" := true;
//             Modify();
//             PurchaseInvLine.SetRange("Document No.", "Purch. Inv. Header"."No.");
//             PurchaseInvLine.SetRange(Type, PurchaseInvLine.type::Item);
//             if PurchaseInvLine.findset() then
//                 repeat
//                     if PurchaseInvLine."Duty Free" then
//                         PurchaseInvLine."Duty Free" := false
//                     else
//                         PurchaseInvLine."Duty Free" := true;
//                     PurchaseInvLine.Modify();
//                 until PurchaseInvLine.Next() = 0;
//         end;
//     }
//     dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
//     {
//         DataItemTableView = where("Posting Date" = filter('010625D..'));
//         trigger OnAfterGetRecord()
//         var
//             PurchaseRcptLine: Record "Purch. Rcpt. Line";
//         begin
//             if "Duty Free" then
//                 "Duty Free" := false
//             else
//                 "Duty Free" := true;
//             Modify();
//             PurchaseRcptLine.SetRange("Document No.", "Purch. Rcpt. Header"."No.");
//             PurchaseRcptLine.SetRange(Type, PurchaseRcptLine.type::Item);
//             if PurchaseRcptLine.findset() then
//                 repeat
//                     if PurchaseRcptLine."Duty Free" then
//                         PurchaseRcptLine."Duty Free" := false
//                     else
//                         PurchaseRcptLine."Duty Free" := true;
//                     PurchaseRcptLine.Modify();
//                 until PurchaseRcptLine.Next() = 0;
//         end;
//     }
// }
// trigger OnPreReport()
// begin
//     if not confirm('Denne rapport må kun køres af Consit! Ønsker du at fortsætte') then
//         CurrReport.Break();
// end;
}
