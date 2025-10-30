report 50002 "CST - Picking List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Report/layout/JuulsPickingList.rdlc';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Picking List', comment = 'DAN="Plukliste"';

    dataset
    {
        dataitem("Warehouse Activity Header"; "Warehouse Activity Header")
        {
            DataItemTableView = SORTING(Type, "No.")WHERE(Type=FILTER(Pick|"Invt. Pick"));
            RequestFilterFields = "No.", "No. Printed";

            column(No_WhseActivHeader; "No.")
            {
            }
            column(SourceDocument_WarehouseActivityHeader; "Warehouse Activity Header"."Source Document")
            {
            }
            column(SourceNo_WarehouseActivityHeader; "Warehouse Activity Header"."Source No.")
            {
            }
            column(HeaderNo_As_BarCode; BarCode)
            {
            }
            column(CustAddr1; CustAddr[1])
            {
            }
            column(CustAddr2; CustAddr[2])
            {
            }
            column(CustAddr3; CustAddr[3])
            {
            }
            column(CustAddr4; CustAddr[4])
            {
            }
            column(CustAddr5; CustAddr[5])
            {
            }
            column(CustAddr6; CustAddr[6])
            {
            }
            column(CustAddr7; CustAddr[7])
            {
            }
            column(CustAddr8; CustAddr[8])
            {
            }
            column(ShipToAddr8; ShipToAddr[8])
            {
            }
            column(ShipToAddr7; ShipToAddr[7])
            {
            }
            column(ShipToAddr6; ShipToAddr[6])
            {
            }
            column(ShipToAddr5; ShipToAddr[5])
            {
            }
            column(ShipToAddr4; ShipToAddr[4])
            {
            }
            column(ShipToAddr3; ShipToAddr[3])
            {
            }
            column(ShipToAddr2; ShipToAddr[2])
            {
            }
            column(ShipToAddr1; ShipToAddr[1])
            {
            }
            column(ShowShippingAddr; ShowShippingAddr)
            {
            }
            column(ShiptoAddrCaption; ShiptoAddrCaptionLbl)
            {
            }
            column(ShowWorkDescription; ShowWorkDescription)
            {
            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

                column(CompanyName; COMPANYNAME)
                {
                }
                column(TodayFormatted; FORMAT(TODAY, 0, 4))
                {
                }
                column(Time; TIME)
                {
                }
                column(PickFilter; PickFilter)
                {
                }
                column(DirectedPutAwayAndPick; Location."Directed Put-away and Pick")
                {
                }
                column(BinMandatory; Location."Bin Mandatory")
                {
                }
                column(InvtPick; InvtPick)
                {
                }
                column(ShowLotSN; ShowLotSN)
                {
                }
                column(SumUpLines; SumUpLines)
                {
                }
                column(No_WhseActivHeaderCaption; "Warehouse Activity Header".FIELDCAPTION("No."))
                {
                }
                column(WhseActivHeaderCaption; "Warehouse Activity Header".TABLECAPTION + ': ' + PickFilter)
                {
                }
                column(LoctnCode_WhseActivHeader; "Warehouse Activity Header"."Location Code")
                {
                }
                column(SortingMtd_WhseActivHeader; "Warehouse Activity Header"."Sorting Method")
                {
                }
                column(AssgUserID_WhseActivHeader; "Warehouse Activity Header"."Assigned User ID")
                {
                }
                column(SourcDocument_WhseActLine; "Warehouse Activity Line"."Source Document")
                {
                }
                column(LoctnCode_WhseActivHeaderCaption; "Warehouse Activity Header".FIELDCAPTION("Location Code"))
                {
                }
                column(SortingMtd_WhseActivHeaderCaption; "Warehouse Activity Header".FIELDCAPTION("Sorting Method"))
                {
                }
                column(AssgUserID_WhseActivHeaderCaption; "Warehouse Activity Header".FIELDCAPTION("Assigned User ID"))
                {
                }
                column(SourcDocument_WhseActLineCaption; "Warehouse Activity Line".FIELDCAPTION("Source Document"))
                {
                }
                column(SourceNo_WhseActLineCaption; WhseActLine.FIELDCAPTION("Source No."))
                {
                }
                column(ShelfNo_WhseActLineCaption; WhseActLine.FIELDCAPTION("Shelf No."))
                {
                }
                column(VariantCode_WhseActLineCaption; WhseActLine.FIELDCAPTION("Variant Code"))
                {
                }
                column(Description_WhseActLineCaption; WhseActLine.FIELDCAPTION(Description))
                {
                }
                column(ItemNo_WhseActLineCaption; WhseActLine.FIELDCAPTION("Item No."))
                {
                }
                column(UOMCode_WhseActLineCaption; WhseActLine.FIELDCAPTION("Unit of Measure Code"))
                {
                }
                column(QtytoHandle_WhseActLineCaption; WhseActLine.FIELDCAPTION("Qty. to Handle"))
                {
                }
                column(QtyBase_WhseActLineCaption; WhseActLine.FIELDCAPTION("Qty. (Base)"))
                {
                }
                column(DestinatnType_WhseActLineCaption; WhseActLine.FIELDCAPTION("Destination Type"))
                {
                }
                column(DestinationNo_WhseActLineCaption; WhseActLine.FIELDCAPTION("Destination No."))
                {
                }
                column(ZoneCode_WhseActLineCaption; WhseActLine.FIELDCAPTION("Zone Code"))
                {
                }
                column(BinCode_WhseActLineCaption; WhseActLine.FIELDCAPTION("Bin Code"))
                {
                }
                column(ActionType_WhseActLineCaption; WhseActLine.FIELDCAPTION("Action Type"))
                {
                }
                column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
                {
                }
                column(PickingListCaption; PickingListCaptionLbl)
                {
                }
                column(WhseActLineDueDateCaption; WhseActLineDueDateCaptionLbl)
                {
                }
                column(QtyHandledCaption; QtyHandledCaptionLbl)
                {
                }
                column(EANCode_Item_Caption; Item.FIELDCAPTION(GTIN))
                {
                }
                column(Vintage_Item_Caption; Item.FIELDCAPTION(Vintage))
                {
                }
                column(AgeYear_Item_Caption; Item.FIELDCAPTION("Age(Year)"))
                {
                }
                column(EthanolPct_Item_Caption; Item.FIELDCAPTION("Alcohol%"))
                {
                }
                column(ShipmentDate_SalesOrderLine_Caption; SalesOrderLine.FIELDCAPTION("Shipment Date"))
                {
                }
                dataitem("Warehouse Activity Line"; "Warehouse Activity Line")
                {
                    DataItemLink = "Activity Type"=FIELD(Type), "No."=FIELD("No.");
                    DataItemLinkReference = "Warehouse Activity Header";
                    DataItemTableView = SORTING("Activity Type", "No.", "Sorting Sequence No.");

                    trigger OnAfterGetRecord()
                    begin
                        IF SumUpLines AND ("Warehouse Activity Header"."Sorting Method" <> "Warehouse Activity Header"."Sorting Method"::Document)THEN BEGIN
                            IF TempWhseActLine."No." = '' THEN BEGIN
                                TempWhseActLine:="Warehouse Activity Line";
                                TempWhseActLine.INSERT();
                                MARK(TRUE);
                            END
                            ELSE
                            BEGIN
                                TempWhseActLine.SETCURRENTKEY("Activity Type", "No.", "Bin Code", "Breakbulk No.", "Action Type");
                                TempWhseActLine.SETRANGE("Activity Type", "Activity Type");
                                TempWhseActLine.SETRANGE("No.", "No.");
                                TempWhseActLine.SETRANGE("Bin Code", "Bin Code");
                                TempWhseActLine.SETRANGE("Item No.", "Item No.");
                                TempWhseActLine.SETRANGE("Action Type", "Action Type");
                                TempWhseActLine.SETRANGE("Variant Code", "Variant Code");
                                TempWhseActLine.SETRANGE("Unit of Measure Code", "Unit of Measure Code");
                                TempWhseActLine.SETRANGE("Due Date", "Due Date");
                                IF "Warehouse Activity Header"."Sorting Method" = "Warehouse Activity Header"."Sorting Method"::"Ship-To" THEN BEGIN
                                    TempWhseActLine.SETRANGE("Destination Type", "Destination Type");
                                    TempWhseActLine.SETRANGE("Destination No.", "Destination No.")END;
                                IF TempWhseActLine.FINDFIRST()THEN BEGIN
                                    TempWhseActLine."Qty. (Base)":=TempWhseActLine."Qty. (Base)" + "Qty. (Base)";
                                    TempWhseActLine."Qty. to Handle":=TempWhseActLine."Qty. to Handle" + "Qty. to Handle";
                                    TempWhseActLine."Source No.":='';
                                    IF "Warehouse Activity Header"."Sorting Method" <> "Warehouse Activity Header"."Sorting Method"::"Ship-To" THEN BEGIN
                                        TempWhseActLine."Destination Type":=TempWhseActLine."Destination Type"::" ";
                                        TempWhseActLine."Destination No.":='';
                                    END;
                                    TempWhseActLine.MODIFY();
                                END
                                ELSE
                                BEGIN
                                    TempWhseActLine:="Warehouse Activity Line";
                                    TempWhseActLine.INSERT();
                                    MARK(TRUE);
                                END;
                            END;
                        END
                        ELSE
                            MARK(TRUE);
                    end;
                    trigger OnPostDataItem()
                    begin
                        MARKEDONLY(TRUE);
                    end;
                    trigger OnPreDataItem()
                    begin
                        TempWhseActLine.SETRANGE("Activity Type", "Warehouse Activity Header".Type);
                        TempWhseActLine.SETRANGE("No.", "Warehouse Activity Header"."No.");
                        TempWhseActLine.DELETEALL();
                        IF BreakbulkFilter THEN TempWhseActLine.SETRANGE("Original Breakbulk", FALSE);
                        CLEAR(TempWhseActLine);
                    end;
                }
                dataitem(WhseActLine; "Warehouse Activity Line")
                {
                    DataItemLink = "Activity Type"=FIELD(Type), "No."=FIELD("No.");
                    DataItemLinkReference = "Warehouse Activity Header";
                    DataItemTableView = SORTING("Activity Type", "No.", "Sorting Sequence No.");

                    column(SourceNo_WhseActLine; "Source No.")
                    {
                    }
                    column(FormatSourcDocument_WhseActLine; FORMAT("Source Document"))
                    {
                    }
                    column(ShelfNo_WhseActLine; "Shelf No.")
                    {
                    }
                    column(ItemNo_WhseActLine; "Item No.")
                    {
                    }
                    column(Description_WhseActLine; Description)
                    {
                    }
                    column(VariantCode_WhseActLine; "Variant Code")
                    {
                    }
                    column(UOMCode_WhseActLine; "Unit of Measure Code")
                    {
                    }
                    column(DueDate_WhseActLine; FORMAT("Due Date"))
                    {
                    }
                    column(QtytoHandle_WhseActLine; "Qty. to Handle")
                    {
                    }
                    column(QtyBase_WhseActLine; "Qty. (Base)")
                    {
                    }
                    column(DestinatnType_WhseActLine; "Destination Type")
                    {
                    }
                    column(DestinationNo_WhseActLine; "Destination No.")
                    {
                    }
                    column(ZoneCode_WhseActLine; "Zone Code")
                    {
                    }
                    column(BinCode_WhseActLine; "Bin Code")
                    {
                    }
                    column(ActionType_WhseActLine; "Action Type")
                    {
                    }
                    column(LotNo_WhseActLine; "Lot No.")
                    {
                    }
                    column(SerialNo_WhseActLine; "Serial No.")
                    {
                    }
                    column(LotNo_WhseActLineCaption; FIELDCAPTION("Lot No."))
                    {
                    }
                    column(SerialNo_WhseActLineCaption; FIELDCAPTION("Serial No."))
                    {
                    }
                    column(LineNo_WhseActLine; "Line No.")
                    {
                    }
                    column(BinRanking_WhseActLine; "Bin Ranking")
                    {
                    }
                    column(EmptyStringCaption; EmptyStringCaptionLbl)
                    {
                    }
                    column(EANCode_Item; Item_GTIN)
                    {
                    }
                    column(Vintage_Item; Item.Vintage)
                    {
                    }
                    column(AgeYear_Item; Item."Age(Year)")
                    {
                    }
                    column(EthanolPct_Item; Item."Alcohol%")
                    {
                    }
                    column(Country_Item; Item.Country)
                    {
                    }
                    column(ShipmentDate_SalesOrderLine; FORMAT(SalesOrderLine."Shipment Date"))
                    {
                    }
                    column(Inventory_Item; Item.Inventory)
                    {
                    }
                    column(InventoryAllocation; Item."Inventory Allocation Engros")
                    {
                    }
                    column(MultiGTIN; MultiGTIN)
                    {
                    }
                    dataitem(WhseActLine2; "Warehouse Activity Line")
                    {
                        DataItemLink = "Activity Type"=FIELD("Activity Type"), "No."=FIELD("No."), "Bin Code"=FIELD("Bin Code"), "Item No."=FIELD("Item No."), "Action Type"=FIELD("Action Type"), "Variant Code"=FIELD("Variant Code"), "Unit of Measure Code"=FIELD("Unit of Measure Code"), "Due Date"=FIELD("Due Date");
                        DataItemLinkReference = WhseActLine;
                        DataItemTableView = SORTING("Activity Type", "No.", "Bin Code", "Breakbulk No.", "Action Type");

                        column(LotNo_WhseActLine2; "Lot No.")
                        {
                        }
                        column(SerialNo_WhseActLine2; "Serial No.")
                        {
                        }
                        column(QtyBase_WhseActLine2; "Qty. (Base)")
                        {
                        }
                        column(QtytoHandle_WhseActLine2; "Qty. to Handle")
                        {
                        }
                        column(LineNo_WhseActLine2; "Line No.")
                        {
                        }
                    }
                    trigger OnAfterGetRecord()
                    var
                        CSTJuulsFunction: Codeunit "CST - Juuls Functions";
                    begin
                        IF SumUpLines THEN BEGIN
                            TempWhseActLine.GET("Activity Type", "No.", "Line No.");
                            "Qty. (Base)":=TempWhseActLine."Qty. (Base)";
                            "Qty. to Handle":=TempWhseActLine."Qty. to Handle";
                        END;
                        IF Item.GET("Item No.")THEN Item.CALCFIELDS(Inventory);
                        MultiGTIN:=false;
                        IF SalesOrderLine.GET(SalesOrderLine."Document Type"::Order, "Source No.", "Source Line No.")THEN if(SalesOrderLine.Type = SalesOrderLine.Type::Item) AND (SalesOrderLine."No." <> '')then MultiGTIN:=CSTJuulsFunction.MultiGTINNumre(SalesOrderLine."No.");
                        IF MultiGTIN then Item_GTIN:='** ' + Item.GTIN
                        else
                            Item_GTIN:=Item.GTIN;
                    end;
                    trigger OnPreDataItem()
                    begin
                        COPY("Warehouse Activity Line");
                        Counter:=COUNT;
                        IF Counter = 0 THEN CurrReport.BREAK();
                        IF BreakbulkFilter THEN SETRANGE("Original Breakbulk", FALSE);
                    end;
                }
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No."=FIELD("Source No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")WHERE("Document Type"=FILTER(Order), Type=FILTER(' '), Description=FILTER(<>''));

                column(Description_SalesLine; "Sales Line".Description)
                {
                }
            }
            dataitem(WorkDescriptionLines; "Integer")
            {
                DataItemTableView = sorting(Number)where(Number=filter(1..99999));

                column(WorkDescriptionLineNumber; Number)
                {
                }
                column(WorkDescriptionLine; WorkDescriptionLine)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if WorkDescriptionInstream.EOS then CurrReport.Break();
                    WorkDescriptionInstream.ReadText(WorkDescriptionLine);
                end;
                trigger OnPostDataItem()
                begin
                    Clear(WorkDescriptionInstream)end;
                trigger OnPreDataItem()
                begin
                    if not ShowWorkDescription then CurrReport.Break();
                    SalesOrderHeader."Work Description".CreateInStream(WorkDescriptionInstream, TEXTENCODING::UTF8);
                end;
            }
            trigger OnAfterGetRecord()
            var
                BarcodeString: Text;
                BarcodeFontProvider: Interface "Barcode Font Provider";
            begin
                GetLocation("Location Code");
                InvtPick:=Type = Type::"Invt. Pick";
                IF NOT CurrReport.PREVIEW THEN WhseCountPrinted.RUN("Warehouse Activity Header");
                CLEAR(SalesOrderHeader);
                IF SalesOrderHeader.GET(SalesOrderHeader."Document Type"::Order, "Warehouse Activity Header"."Source No.")THEN begin
                    FormatAddr.SalesHeaderBillTo(CustAddr, SalesOrderHeader);
                    ShowShippingAddr:=FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, SalesOrderHeader);
                    SalesOrderHeader.CalcFields("Work Description");
                    ShowWorkDescription:=SalesOrderHeader."Work Description".HasValue;
                end;
                Clear(BarcodeString);
                if "No." <> '' then begin
                    BarcodeString:="No.";
                    BarcodeSymbology:="Barcode Symbology"::Code39;
                    BarcodeFontProvider:=Enum::"Barcode Font Provider"::IDAutomation1D;
                    // Set data string source 
                    if BarcodeString <> '' then begin
                        // Validate the input
                        BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                        // Encode the data string to the barcode font
                        BarCode:=BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
                    end;
                end;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Indstillinger)
                {
                    Caption = 'Options', comment = 'DAN="Indstillinger"';

                    field(Breakbulk_; BreakbulkFilter)
                    {
                        Caption = 'Set Breakbulk Filter', comment = 'DAN="Angiv nedbrydningsfilter"';
                        ToolTip = 'Set Breakbulk Filter', comment = 'DAN="Angiv nedbrydningsfilter"';
                        Editable = BreakbulkEditable;
                        ApplicationArea = all;
                    }
                    field(SumUpLines_; SumUpLines)
                    {
                        Caption = 'Sum up Lines', comment = 'DAN="Sammentælling af linjer"';
                        ToolTip = 'Sum up Lines', comment = 'DAN="Sammentælling af linjer"';
                        Editable = SumUpLinesEditable;
                        ApplicationArea = all;
                    }
                    field(LotSerialNo_; ShowLotSN)
                    {
                        Caption = 'Show Serial/Lot Number', comment = 'DAN="Vis serie-/lotnummer"';
                        ToolTip = 'Show Serial/Lot Number', comment = 'DAN="Vis serie-/lotnummer"';
                        ApplicationArea = all;
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnInit()
        begin
            SumUpLinesEditable:=TRUE;
            BreakbulkEditable:=TRUE;
        end;
        trigger OnOpenPage()
        begin
            IF HideOptions THEN BEGIN
                BreakbulkEditable:=FALSE;
                SumUpLinesEditable:=FALSE;
            END;
        end;
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        PickFilter:="Warehouse Activity Header".GETFILTERS;
    end;
    var Location: Record Location;
    TempWhseActLine: Record "Warehouse Activity Line" temporary;
    Item: Record Item;
    SalesOrderLine: Record "Sales Line";
    SalesOrderHeader: Record "Sales Header";
    WhseCountPrinted: Codeunit "Whse.-Printed";
    FormatAddr: Codeunit "Format Address";
    WorkDescriptionInstream: InStream;
    BarcodeSymbology: Enum "Barcode Symbology";
    CustAddr: array[8]of Text[50];
    ShipToAddr: array[8]of Text[50];
    Counter: Integer;
    BreakbulkFilter: Boolean;
    SumUpLines: Boolean;
    HideOptions: Boolean;
    InvtPick: Boolean;
    ShowLotSN: Boolean;
    BreakbulkEditable: Boolean;
    SumUpLinesEditable: Boolean;
    ShowShippingAddr: Boolean;
    MultiGTIN: Boolean;
    ShowWorkDescription: Boolean;
    BarCode: Text;
    Item_GTIN: Text[17];
    WorkDescriptionLine: Text;
    PickFilter: Text;
    CurrReportPageNoCaptionLbl: Label 'Page', comment = 'DAN="Side"';
    PickingListCaptionLbl: Label 'Picking List', comment = 'DAN="Plukliste"';
    WhseActLineDueDateCaptionLbl: Label 'Due Date', comment = 'DAN="Forfaldsdato"';
    QtyHandledCaptionLbl: Label 'Qty. Handled', comment = 'DAN="Hånderet antal"';
    EmptyStringCaptionLbl: Label '____________', comment = 'DAN="____________"';
    ShiptoAddrCaptionLbl: Label 'Ship-to Address', comment = 'DAN="Leveringsadresse"';
    local procedure GetLocation(LocationCode: Code[10])
    begin
        IF LocationCode = '' THEN Location.INIT()
        ELSE IF Location.Code <> LocationCode THEN Location.GET(LocationCode);
    end;
    /// <summary>
    /// SetBreakbulkFilter.
    /// </summary>
    /// <param name="BreakbulkFilter2">Boolean.</param>
    procedure SetBreakbulkFilter(BreakbulkFilter2: Boolean)
    begin
        BreakbulkFilter:=BreakbulkFilter2;
    end;
    /// <summary>
    /// SetInventory.
    /// </summary>
    /// <param name="SetHideOptions">Boolean.</param>
    procedure SetInventory(SetHideOptions: Boolean)
    begin
        HideOptions:=SetHideOptions;
    end;
}
