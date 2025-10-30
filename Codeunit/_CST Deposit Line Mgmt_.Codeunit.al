codeunit 50002 "CST Deposit Line Mgmt"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateQuantityOnBeforeResetAmounts', '', false, false)]
    local procedure OnValidateQuantityOnBeforeResetAmounts(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        MaintainSalesDepositLine(SalesLine);
    end;
    [EventSubscriber(ObjectType::Table, Database::"Sales line", 'OnValidateQtyToShipOnAfterCheckQuantity', '', false, false)]
    local procedure OnValidateQtyToShipOnAfterCheckQuantity(var SalesLine: Record "Sales Line"; CurrentFieldNo: Integer)
    var
        s_depositline: record "Sales Line";
    begin
        If SalesLine."Line No." = 0 then exit;
        //>> HCH
        IF CurrentFieldNo <> 0 then // << HCH
            If salesline."Qty. to Ship" <> 0 then begin
                s_depositline.Reset();
                s_depositline.SetRange("Document Type", SalesLine."Document Type");
                s_depositline.SetRange("Document No.", SalesLine."Document No.");
                s_depositline.SetRange("Deposit Line No. Ref.", SalesLine."Line No.");
                If s_depositline.FindFirst()then If(s_depositline."Qty. to Ship" <> SalesLine."Qty. to Ship")then begin
                        s_depositline.Validate("Qty. to Ship", SalesLine."Qty. to Ship");
                        s_depositline.Modify(true);
                    end;
            end;
    end;
    //>> HCH
    [EventSubscriber(ObjectType::Table, Database::"Sales line", 'OnValidateQtyToInvoiceOnBeforeCalcInvDiscToInvoice', '', false, false)]
    local procedure OnValidateQtyToInvoiceOnBeforeCalcInvDiscToInvoice(var SalesLine: Record "Sales Line"; CurrentFieldNo: Integer)
    var
        s_depositline: record "Sales Line";
    begin
        If SalesLine."Line No." = 0 then exit;
        IF CurrentFieldNo <> 0 then If salesline."Qty. to Invoice" <> 0 then begin
                s_depositline.Reset();
                s_depositline.SetRange("Document Type", SalesLine."Document Type");
                s_depositline.SetRange("Document No.", SalesLine."Document No.");
                s_depositline.SetRange("Deposit Line No. Ref.", SalesLine."Line No.");
                If s_depositline.FindFirst()then If s_depositline."Qty. to Invoice" <> SalesLine."Qty. to Invoice" then begin
                        s_depositline.Validate("Qty. to Invoice", SalesLine."Qty. to Invoice");
                        s_depositline.Modify(true);
                    end;
            end;
    end;
    //<< HCH
    //>> HCH
    [EventSubscriber(ObjectType::Table, Database::"Sales line", 'OnValidateQuantityOnAfterInitQty', '', false, false)]
    local procedure OnValidateQuantityOnAfterInitQty(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    var
        s_depositline: record "Sales Line";
    begin
        If SalesLine."Line No." = 0 then exit;
        IF CurrentFieldNo <> 0 then If salesline."Qty. to Invoice" <> 0 then begin
                s_depositline.Reset();
                s_depositline.SetRange("Document Type", SalesLine."Document Type");
                s_depositline.SetRange("Document No.", SalesLine."Document No.");
                s_depositline.SetRange("Deposit Line No. Ref.", SalesLine."Line No.");
                If s_depositline.FindFirst()then If s_depositline.Quantity <> SalesLine.Quantity then begin
                        s_depositline.Validate(Quantity, SalesLine.Quantity);
                        s_depositline.Modify(true);
                    end;
            end;
    end;
    //<< HCH
    local procedure MaintainSalesDepositLine(var SalesLine: record "Sales Line")
    var
        SalesHeader: record "Sales Header";
        S_DepositLine: record "Sales Line";
        DepositCode: record "CST Deposit Code";
        Item: record Item;
        IsHandled: Boolean;
    begin
        If(Salesline.type <> SalesLine.type::Item) or (Salesline.Quantity = 0) or (SalesLine."Line No." = 0)then exit;
        If item.Get(salesline."No.")then;
        If item."Deposit Code" = '' then exit;
        SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.");
        OnBeforeInsertSalesDepositLine(SalesHeader, IsHandled);
        If IsHandled then exit;
        If DepositCode.Get(Item."Deposit Code")then begin
            DepositCode.testfield("Deposit Item No.");
            S_DepositLine.Reset();
            S_DepositLine.SetRange("Document Type", SalesLine."Document Type");
            S_DepositLine.SetRange("Document No.", SalesLine."Document No.");
            S_DepositLine.SetRange("Deposit Line No. Ref.", SalesLine."Line No.");
            If S_DepositLine.FindFirst()then begin
                S_DepositLine.Validate(Quantity, SalesLine.Quantity);
                S_DepositLine.Modify(true);
            end
            else
            begin
                S_DepositLine.Init();
                S_DepositLine.Validate("Document Type", SalesLine."Document Type");
                S_DepositLine.Validate("Document No.", SalesLine."Document No.");
                S_DepositLine.Validate("Line No.", SalesLine."Line No." + 1000);
                S_DepositLine.Validate(Type, S_DepositLine.Type::Item);
                S_DepositLine.Validate("No.", DepositCode."Deposit Item No.");
                S_DepositLine.Insert(true);
                S_DepositLine.Validate(Quantity, SalesLine.Quantity);
                S_DepositLine.Validate("Deposit Line No. Ref.", SalesLine."Line No.");
                S_DepositLine.Modify(true);
            end;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterDeleteEvent, '', false, false)]
    local procedure OnDeleteSalesLine(var Rec: Record "Sales Line"; RunTrigger: Boolean)
    var
        SalesDepositLine: record "Sales Line";
    begin
        If Rec."Line No." = 0 then exit;
        If RunTrigger then begin
            SalesDepositLine.Reset();
            SalesDepositLine.SetRange("Document Type", Rec."Document Type");
            SalesDepositLine.SetRange("Document No.", Rec."Document No.");
            SalesDepositLine.SetRange("Deposit Line No. Ref.", rec."Line No.");
            If SalesDepositLine.FindFirst()then SalesDepositLine.Delete(true);
        end;
    end;
    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertSalesDepositLine(Var Salesheader: Record "Sales Header"; Var IsHandled: Boolean)
    begin
    end;
    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    //            PURCHASE
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnValidateQuantityOnBeforeResetAmounts', '', false, false)]
    local procedure OnValidateQuantityOnAfterPlanPriceCalcByField(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line")
    begin
        MaintainPurchaseDepositLine(PurchaseLine);
    end;
    [EventSubscriber(ObjectType::Table, Database::"Purchase line", 'OnValidateQtyToReceiveOnAfterCheckQty', '', false, false)]
    local procedure OnValidateQtyToReceiveOnAfterCheckQty(var PurchaseLine: Record "Purchase Line"; CurrFieldNo: Integer)
    var
        p_depositline: record "Purchase Line";
    begin
        If PurchaseLine."Qty. to receive" <> 0 then begin
            p_depositline.Reset();
            p_depositline.SetRange("Document Type", PurchaseLine."Document Type");
            p_depositline.SetRange("Document No.", PurchaseLine."Document No.");
            p_depositline.SetRange("Deposit Line No. Ref.", PurchaseLine."Line No.");
            If p_depositline.FindFirst()then If(p_depositline.Quantity <> PurchaseLine.Quantity) or (p_depositline."Qty. to receive" <> PurchaseLine."Qty. to receive")then begin
                    If p_depositline.Quantity <> PurchaseLine.Quantity then p_depositline.Validate(Quantity, PurchaseLine.Quantity);
                    If p_depositline."Qty. to receive" <> PurchaseLine."Qty. to receive" then p_depositline.Validate("Qty. to receive", PurchaseLine."Qty. to receive");
                    p_depositline.Modify(true);
                end;
        end;
    end;
    local procedure MaintainPurchaseDepositLine(var PurchaseLine: record "Purchase Line")
    var
        PurchaseHeader: record "Purchase Header";
        p_DepositLine: record "Purchase Line";
        DepositCode: record "CST Deposit Code";
        Item: record Item;
        Vendor: record Vendor;
        IsHandled: Boolean;
    begin
        If(PurchaseLine.type <> PurchaseLine.type::Item) or (PurchaseLine.Quantity = 0) or (purchaseline."Line No." = 0)then exit;
        If item.Get(PurchaseLine."No.")then If item."Deposit Code" = '' then exit;
        PurchaseHeader.Get(PurchaseLine."Document Type", PurchaseLine."Document No.");
        OnBeforeInsertPurchaseDepositLine(PurchaseHeader, IsHandled);
        If IsHandled then exit;
        If DepositCode.Get(Item."Deposit Code")then begin
            DepositCode.testfield("Deposit Item No.");
            If Vendor.Get(PurchaseHeader."Pay-to Vendor No.") AND (Vendor."Vendor Posting Group" = DepositCode."Vendor Posting Group")then begin
                p_DepositLine.Reset();
                p_DepositLine.SetRange("Document Type", PurchaseLine."Document Type");
                p_DepositLine.SetRange("Document No.", PurchaseLine."Document No.");
                p_DepositLine.SetRange("Deposit Line No. Ref.", PurchaseLine."Line No.");
                If p_DepositLine.FindFirst()then begin
                    p_DepositLine.Validate(Quantity, PurchaseLine.Quantity);
                    //>>HCH
                    p_DepositLine.Validate("Qty. to receive", PurchaseLine."Qty. to receive");
                    p_DepositLine.Validate("Qty. to Invoice", PurchaseLine."Qty. to Invoice");
                    //<<HCH
                    p_DepositLine.Modify(true);
                end
                else
                begin
                    p_DepositLine.Init();
                    p_DepositLine.Validate("Document Type", PurchaseLine."Document Type");
                    p_DepositLine.Validate("Document No.", PurchaseLine."Document No.");
                    p_DepositLine.Validate("Line No.", PurchaseLine."Line No." + 1000);
                    p_DepositLine.Validate(Type, p_DepositLine.Type::Item);
                    p_DepositLine.Validate("No.", DepositCode."Deposit Item No.");
                    p_DepositLine.Insert(true);
                    p_DepositLine.Validate(Quantity, PurchaseLine.Quantity);
                    p_DepositLine.Validate("Deposit Line No. Ref.", PurchaseLine."Line No.");
                    p_DepositLine.Modify(true);
                end;
            end;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnAfterDeleteEvent, '', false, false)]
    local procedure OnDeletePurchaseLine(var Rec: Record "Purchase Line"; RunTrigger: Boolean);
    var
        PurchaseDepositLine: record "Purchase Line";
    begin
        If Rec."Line No." = 0 then exit;
        If RunTrigger then begin
            PurchaseDepositLine.Reset();
            PurchaseDepositLine.SetRange("Document Type", Rec."Document Type");
            PurchaseDepositLine.SetRange("Document No.", Rec."Document No.");
            PurchaseDepositLine.SetRange("Deposit Line No. Ref.", Rec."Line No.");
            If PurchaseDepositLine.FindFirst()then PurchaseDepositLine.Delete(true);
        end;
    end;
    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertPurchaseDepositLine(Var Purchaseheader: Record "Purchase Header"; Var IsHandled: Boolean)
    begin
    end;
    //>>>>>>>>>>>>>>>>>>>>
    // Warehouse Inventory Pick posting
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Post", OnAfterSalesLineModify, '', false, false)]
    local procedure OnAfterSalesLineModify(var SalesLine: Record "Sales Line")
    var
        SalesDepositLine: record "Sales Line";
    begin
        If SalesLine."Line No." = 0 then exit;
        SalesDepositLine.Reset();
        SalesDepositLine.SetRange("Document Type", SalesLine."Document Type");
        SalesDepositLine.SetRange("Document No.", SalesLine."Document No.");
        SalesDepositLine.SetRange("Deposit Line No. Ref.", SalesLine."Line No.");
        If SalesDepositLine.FindFirst()then If(salesline."Qty. to Ship" <= SalesDepositLine."Outstanding Quantity")then begin
                SalesDepositLine.validate("qty. to ship", SalesLine."qty. to ship");
                SalesDepositLine.Modify();
            end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Post", OnUpdateQtyToHandleOnSalesLineOnBeforeSalesLineModify, '', false, false)]
    local procedure OnUpdateQtyToHandleOnSalesLineOnBeforeSalesLineModify(var SalesLine: Record "Sales Line"; var ModifyLine: Boolean)
    begin
        If salesline."Deposit Line No. Ref." <> 0 then ModifyLine:=false;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Post", OnAfterPurchLineModify, '', false, false)]
    local procedure OnAfterPurchLineModify(var PurchaseLine: Record "Purchase Line")
    var
        PurchaseDepositLine: record "Purchase Line";
    begin
        If PurchaseLine."Line No." = 0 then exit;
        PurchaseDepositLine.Reset();
        PurchaseDepositLine.SetRange("Document Type", PurchaseLine."Document Type");
        PurchaseDepositLine.SetRange("Document No.", PurchaseLine."Document No.");
        PurchaseDepositLine.SetRange("Deposit Line No. Ref.", PurchaseLine."Line No.");
        If PurchaseDepositLine.FindFirst()then If(PurchaseLine."Qty. to receive" <= PurchaseDepositLine."Outstanding Quantity")then begin
                PurchaseDepositLine.validate("qty. to Receive", PurchaseLine."qty. to receive");
                PurchaseDepositLine.Modify();
            end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Post", OnUpdateQtyToHandleOnPurchaseLineOnBeforePurchLineModify, '', false, false)]
    local procedure OnUpdateQtyToHandleOnPurchaseLineOnBeforePurchLineModify(var PurchaseLine: Record "Purchase Line"; var ModifyLine: Boolean)
    begin
        If PurchaseLine."Deposit Line No. Ref." <> 0 then ModifyLine:=false;
    end;
}
