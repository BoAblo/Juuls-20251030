codeunit 50001 "CST Create Sales Docs. Magasin"
{
    /// <summary>
    /// CreateSalesHeader.
    /// </summary>
    /// <param name="SalesHeader">VAR Record "Sales Header".</param>
    /// <param name="SalesDocType">enum "Sales Document Type".</param>
    /// <param name="CustomerNo">Code[20].</param>
    /// <param name="InvDate">Date.</param>
    /// <param name="PricesIncludingVAT">Boolean.</param>
    procedure CreateSalesHeader(var SalesHeader: Record "Sales Header"; SalesDocType: enum "Sales Document Type"; CustomerNo: Code[20]; InvDate: Date; PricesIncludingVAT: Boolean)
    begin
        if CustomerNo = '' then Error(Text000Lbl);
        SalesHeader.SetCurrentKey("Document Type", "Sell-to Customer No.");
        SalesHeader.SetRange("Document Type", SalesDocType);
        SalesHeader.SetRange("Sell-to Customer No.", CustomerNo);
        SalesHeader.SetRange("Posting Date", InvDate);
        SalesHeader.SetRange(Status, SalesHeader.Status::Open);
        if SalesHeader.FindFirst()then exit;
        Clear(SalesHeader);
        SalesHeader.SetHideValidationDialog(true);
        SalesHeader.SetHideCreditCheckDialogue(true);
        SalesHeader.Init();
        SalesHeader."Document Type":=SalesDocType;
        SalesHeader."No.":='';
        SalesHeader.Insert(true);
        SalesHeader.Validate("Sell-to Customer No.", CustomerNo);
        SalesHeader.Validate("Document Date", InvDate);
        SalesHeader.Validate("Posting Date", InvDate);
        SalesHeader.Validate("Order Date", InvDate);
        SalesHeader.Validate("Shipment Date", InvDate);
        SalesHeader.Validate(Status, SalesHeader.Status::Open);
        SalesHeader.Validate("Prices Including VAT", PricesIncludingVAT);
        SalesHeader.Modify(true);
    end;
    /// <summary>
    /// CreateSalesLines.
    /// </summary>
    /// <param name="TempSalesLine">Temporary VAR Record "Sales Line".</param>
    /// <param name="SalesHeader">VAR Record "Sales Header".</param>
    /// <param name="SalesLine">VAR Record "Sales Line".</param>
    procedure CreateSalesLines(var TempSalesLine: Record "Sales Line" temporary; var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    var
        Qty: Decimal;
        UnitPrice: Decimal;
        LineAmount: Decimal;
        LineDiscountAmount: Decimal;
        VatAmount: Decimal;
        WorkingAmount: Decimal;
        ItemExists: Boolean;
        ItemNoToUse: Code[20];
        Counter: Integer;
    begin
        if SalesHeader."No." = '' then Error(Text001Lbl, SalesHeader."Sell-to Customer No.", SalesHeader."Posting Date");
        if TempSalesLine.FindSet()then repeat Counter+=1;
                WorkingAmount:=TempSalesLine.Amount + TempSalesLine."Line Discount Amount" + TempSalesLine."VAT Base Amount";
                Qty:=TempSalesLine.Quantity;
                UnitPrice:=0;
                if Qty <> 0 then UnitPrice:=WorkingAmount / Qty;
                LineAmount:=WorkingAmount;
                LineDiscountAmount:=TempSalesLine."Line Discount Amount";
                VatAmount:=TempSalesLine."VAT Base Amount";
                ItemExists:=GetItem(TempSalesLine."No.", TempSalesLine."Item Reference No.", ItemNoToUse);
                if DeveloperMessageYesNo then if Counter mod 10 = 0 then Message('Processing Sales Line %1 of %2 - Item Exists: %3 - Item No.: %4.', Counter, TempSalesLine.Count(), ItemExists, ItemNoToUse);
                SalesLine.Init();
                SalesLine.SetSalesHeader(SalesHeader);
                SalesLine.SetHideValidationDialog(true);
                SalesLine."Document Type":=SalesHeader."Document Type";
                SalesLine.Validate("Document No.", SalesHeader."No.");
                SalesLine."Line No.":=FindNextSalesLineLineNo(SalesHeader."Document Type", SalesHeader."No.");
                SalesLine.Insert(true);
                if ItemExists then begin
                    SalesLine.Validate("Type", SalesLine.Type::Item);
                    SalesLine.Validate("No.", ItemNoToUse);
                    SalesLine.Validate("Quantity", Qty);
                    SalesLine.Validate("Unit Price", UnitPrice);
                    SalesLine.Validate("Line Amount", LineAmount);
                    if LineDiscountAmount <> 0 then SalesLine.Validate("Line Discount Amount", LineDiscountAmount);
                end
                else
                begin
                    SalesLine.Validate("Type", SalesLine.Type::" ");
                    SalesLine."No.":=TempSalesLine."No.";
                    SalesLine."Item Reference No.":=TempSalesLine."Item Reference No.";
                    SalesLine."Description":=CopyStr(StrSubstNo(Text002Lbl, TempSalesLine."Item Reference No.", FormatDecimal(UnitPrice, 2), FormatDecimal(Qty, 0), FormatDecimal(LineAmount, 2), FormatDecimal(LineDiscountAmount, 2)), 1, MaxStrLen(TempSalesLine."Description"));
                    SalesLine."Description 2":=CopyStr(TempSalesLine.Description, 1, MaxStrLen(SalesLine."Description 2"));
                    SalesLine."Line Amount":=LineAmount;
                    SalesLine."Line Discount Amount":=LineDiscountAmount;
                    SalesLine."VAT Base Amount":=VatAmount;
                end;
                SalesLine.Modify(true);
            until TempSalesLine.Next() = 0;
    end;
    local procedure FindNextSalesLineLineNo(SalesDocType: Enum "Sales Document Type"; DocNo: Code[20]): Integer var
        SalesLine2: Record "Sales Line";
    begin
        if DocNo = '' then exit;
        SalesLine2.SetCurrentKey("Document Type", "Document No.");
        SalesLine2.SetRange("Document Type", SalesDocType);
        SalesLine2.SetRange("Document No.", DocNo);
        if SalesLine2.FindLast()then;
        exit(SalesLine2."Line No." - (SalesLine2."Line No." MOD 10000) + 10000);
    end;
    local procedure GetItem(ItemNo: Code[20]; ItemRefNo: Text[50]; var ItemNoToUse: Code[20]): Boolean var
        Item: Record Item;
        ItemReference: Record "Item Reference";
        ItemRefType: Enum "Item Reference Type";
    begin
        Clear(ItemNoToUse);
        if Item.Get(ItemNo)then begin
            ItemNoToUse:=Item."No.";
            exit(true);
        end;
        Clear(Item);
        Item.SetRange(GTIN, itemRefNo);
        if Item.FindFirst()then begin
            ItemNoToUse:=Item."No.";
            exit(true);
        end;
        Item.SetRange(GTIN);
        Clear(ItemReference);
        ItemReference.SetCurrentKey("Reference Type No.");
        ItemReference.SetRange("Reference Type", ItemRefType::"Bar Code");
        ItemReference.SetRange("Reference Type No.", ItemRefNo);
        if not ItemReference.FindFirst()then exit(false);
        if not Item.Get(ItemReference."Item No.")then exit(false);
        ItemNoToUse:=Item."No.";
        exit(true);
    end;
    /// <summary>
    /// SetShowDeveloperMessageYesNo.
    /// </summary>
    /// <param name="ValueBool">Boolean.</param>
    procedure SetShowDeveloperMessageYesNo(ValueBool: Boolean)
    begin
        DeveloperMessageYesNo:=ValueBool;
    end;
    local procedure FormatDecimal(Value: Decimal; NoOfDecimals: Integer): Text var
        ValueText: Text;
        FormatText: Text[100];
    begin
        if NoOfDecimals > 0 then begin
            NoOfDecimals+=1; // Adjust for the separator
            FormatText:=StrSubstNo(NoOfDecimalsLbl, NoOfDecimals);
            ValueText:=Format(Value, 0, FormatText);
        end
        else
            ValueText:=Format(Value);
        if Value >= 0 then exit(ValueText);
        exit(ValueText + ' (Neg.)');
    end;
    var DeveloperMessageYesNo: Boolean;
    Text000Lbl: Label 'Customer No. is missing in Magasin Setup', comment = 'DAN="Kundenummer mangler i Magasin-opsætning"', Locked = true;
    Text001Lbl: Label 'There is no Sales Header for the selected Customer No. =  %1 and Posting Date = %2!', comment = 'DAN="Der findes ikke nogen salgsordre til kundenr = %1 og bogføringsdato = %2!"', Locked = true;
    Text002Lbl: Label 'Item not found. Ref.No. %1 - Price %2 - Qty. %3 - Amout %4 - Disc. %5', comment = 'DAN="Varenr. ikke fundet. Referencenummer %1!"', Locked = true;
    NoOfDecimalsLbl: Label '<Precision,2><Sign><Integer Thousand><Decimals,%1>', Comment = '%1 = No. of Decimals';
}
