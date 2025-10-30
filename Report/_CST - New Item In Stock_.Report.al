report 50032 "CST - New Item In Stock"
{
    DefaultLayout = RDLC;
    ApplicationArea = All;
    UsageCategory = Administration;
    RDLCLayout = './Report/layout/JuulsNewItemInStock.rdlc';
    Caption = 'New Items In Stock', comment = 'DAN="Nye varer på lager"';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Location Filter";

            column(CompanyName; COMPANYNAME)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(No_Item; Item."No.")
            {
            }
            column(No_Item_Caption; Item.FIELDCAPTION("No."))
            {
            }
            column(Description_Item; Item.Description)
            {
            }
            column(Description_Item_Caption; Item.FIELDCAPTION(Description))
            {
            }
            column(Quantity_ItemLedgerEntryStartDate; ItemLedgerEntryStartDate.Quantity)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(StartDateCaption; StartDateCaptionLbl)
            {
            }
            column(Quantity_ItemLedgerEntryEndDate; ItemLedgerEntryEndDate.Quantity)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(EndDateCaption; EndDateCaptionLbl)
            {
            }
            column(ReportNameCaption; ReportNameCaptionLbl)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(InventoryEndDate; InventoryEndDateLbl)
            {
            }
            column(DETAIL_Item; Item."3DETAIL")
            {
            }
            column(DETAIL_Item_Caption; Item.FIELDCAPTION("3DETAIL"))
            {
            }
            trigger OnAfterGetRecord()
            begin
                ItemLedgerEntryStartDate.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
                ItemLedgerEntryStartDate.SETFILTER("Item No.", "No.");
                IF Item.GETFILTER(Item."Location Filter") <> '' THEN ItemLedgerEntryStartDate.SETFILTER("Location Code", Item.GETFILTER(Item."Location Filter"));
                ItemLedgerEntryStartDate.SETFILTER("Posting Date", '..%1', StartDate);
                ItemLedgerEntryStartDate.CALCSUMS(Quantity);
                CLEAR(ItemLedgerEntryEndDate);
                IF ItemLedgerEntryStartDate.Quantity = 0 THEN BEGIN
                    ItemLedgerEntryEndDate.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
                    ItemLedgerEntryEndDate.SETFILTER("Item No.", "No.");
                    IF Item.GETFILTER(Item."Location Filter") <> '' THEN ItemLedgerEntryEndDate.SETFILTER("Location Code", Item.GETFILTER(Item."Location Filter"));
                    ItemLedgerEntryEndDate.SETFILTER("Posting Date", '..%1', EndDate);
                    ItemLedgerEntryEndDate.CALCSUMS(Quantity);
                END;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(StartDate_; StartDate)
                {
                    Caption = 'Start Date', comment = 'DAN="Startdato"';
                    ToolTip = 'Start Date';
                    ApplicationArea = all;
                }
                field(EndDate_; EndDate)
                {
                    Caption = 'End Date', comment = 'DAN="Slutdato"';
                    ToolTip = 'End Date';
                    ApplicationArea = all;
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        ItemFilter:=Item.GETFILTERS;
    end;
    var ItemLedgerEntryStartDate: Record "Item Ledger Entry";
    ItemLedgerEntryEndDate: Record "Item Ledger Entry";
    ItemFilter: Text;
    StartDate: Date;
    EndDate: Date;
    // InventoryStartDateLbl: Label 'Inventory at Start Date';
    InventoryEndDateLbl: Label 'Inventory at End Date';
    ReportNameCaptionLbl: Label 'New Item In Stock';
    CurrReportPageNoCaptionLbl: Label 'Page';
    StartDateCaptionLbl: Label 'Start Date';
    EndDateCaptionLbl: Label 'End Date';
}
