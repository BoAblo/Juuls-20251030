/// <summary>
/// Codeunit CST Pre-Selected Price Mgt. (ID 50013).
/// </summary>
Codeunit 50013 "CST Pre-Selected Price Mgt."
{
    trigger OnRun()
    var

    begin
        GetItem();
        InitializePriceListLines();
        InsertPriceLines();
    end;

    /// <summary>
    /// InitializePriceListLines.
    /// </summary>
    procedure InitializePriceListLines()
    var
        PreSelectedPriceLine: Record "CSTPreSelectedPriceLines";

    begin
        if not IsInitialized then
            exit;

        if GuiAllowed() then
            if PreSelectedPriceLine.IsEmpty() then
                Message(NoPriceLinesFoundMsg);

        IsInitialized := true;
    end;

    local procedure InsertPriceLines()
    var
        PreSelectedPriceLine: Record "CSTPreSelectedPriceLines";
        PriceLine: Record "Price List Line";
        PriceAmtType: Enum "Price Amount Type";

    begin
        if PreSelectedPriceLine.FindSet() then
            repeat
                if not PriceLineExists(PreSelectedPriceLine) then begin
                    PriceLine.Init();
                    PriceLine.Validate("Price List Code", PreSelectedPriceLine."Price List Code");
                    PriceLine.Validate("Line No.", FindNextPriceLineNo(PreSelectedPriceLine."Price List Code"));
                    PriceLine.Insert(true);
                    PriceLine.Validate("Source Type", PreSelectedPriceLine."Source Type");
                    PriceLine.Validate("Source No.", PreSelectedPriceLine."Source No.");
                    PriceLine.Validate(Description, PreSelectedPriceLine.Description);
                    PriceLine.Validate("Asset Type", PriceLine."Asset Type"::Item);
                    PriceLine.Validate("Product No.", Item."No.");
                    PriceLine.Validate("Amount Type", PriceAmtType::Any);
                    if Item.Description <> '' then
                        PriceLine.Validate("Description", CopyStr(Item.Description, 1, MaxStrLen(PriceLine.Description)));
                    IF Item."Base Unit of Measure" <> '' then
                        PriceLine.Validate("Unit of Measure Code", Item."Base Unit of Measure");
                    PriceLine.Validate("Unit Price", Item."Unit Price");
                    PriceLine.Modify(true);
                end;
            until PreSelectedPriceLine.Next() = 0;
    end;

    local procedure PriceLineExists(PreSelectedPriceLine: Record "CSTPreSelectedPriceLines"): Boolean
    var
        PriceLine2: Record "Price List Line";
    begin
        PriceLine2.Reset();
        PriceLine2.SetCurrentKey("Source Type", "Source No.", "Asset Type", "Asset No.");
        PriceLine2.SetRange("Source Type", PreSelectedPriceLine."Source Type");
        PriceLine2.SetRange("Source No.", Item."No.");
        PriceLine2.SetRange("Asset Type", PriceLine2."Asset Type"::Item);
        PriceLine2.SetRange("Asset No.", Item."No.");
        exit(not PriceLine2.IsEmpty());
    end;

    local procedure FindNextPriceLineNo(PriceListCode: Code[20]): Integer
    var
        PriceLine: Record "Price List Line";

    begin
        PriceLine.Reset();
        PriceLine.SetRange("Price List code", PriceListCode);
        if PriceLine.FindLast() then;
        exit(PriceLine."Line No." + 10000)
    end;

    local procedure GetItem(): Boolean

    begin
        if ItemNo = '' then
            Error(NoItemErrMsg);

        Item.Get(ItemNo);
        if Item.Blocked then
            Item.FieldError(Blocked, ItemNo + ' is blocked.');

        exit(true);
    end;

    /// <summary>
    /// SetParemeters.
    /// </summary>
    /// <param name="NewItemNo">Code[20].</param>
    /// <param name="NewInitialized">Boolean.</param>
    procedure SetParemeters(NewItemNo: Code[20]; NewInitialized: Boolean)

    begin
        ItemNo := NewItemNo;
        IsInitialized := NewInitialized;
    end;

    var
        Item: Record Item;
        ItemNo: Code[20];
        IsInitialized: Boolean;
        NoPriceLinesFoundMsg: Label 'No pre-selected price lines found!\Please set up pre-selected price lines.';
        NoItemErrMsg: Label 'Item No. must be set before running this functionality!';

}