pageextension 50001 "CST Item Card Ext" extends "Item Card"
{
    layout
    {
        modify("Description 2")
        {
            Visible = true;
            Caption = 'Producer', comment = 'DAN="Producent"';
        }
        addafter("Description 2")
        {
            // field(Producer; Rec.Producer)
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Producer field.', Comment = 'DAN="Producent"';
            // }
            field("Deposit Code"; Rec."Deposit Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Deposit Code field.', Comment = 'DAN="Pantkode"';
            }
        }
        addafter(GTIN)
        {
            field("GTIN (Kolli)"; Rec."GTIN (Kolli)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the GTIN (Kolli) field.', Comment = 'DAN="GTIN (Kolli)"';
            }
            field("Allocated Item"; Rec."Allocated Item")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allocated Item field.', Comment = 'DAN="Allokeret vare"';
            }
        }
        addafter("Last Date Modified")
        {
            field("Alcohol%2"; Rec."Alcohol%")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'ToolTip';
            }
            field(CS_Inventory; Rec.Inventory)
            {
                ApplicationArea = Basic, Suite;
                AssistEdit = false;
                ToolTip = 'Specifies how many units, such as pieces, boxes, or cans, of the item are in inventory.';
            }
            field("CS_Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies how many units of the item are inbound on purchase orders, meaning listed on outstanding purchase order lines.';
            }
            field("CS_Qty. on Sales Order"; Rec."Qty. on Sales Order")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies how many units of the item are allocated to sales orders, meaning listed on outstanding sales orders lines.';
            }
            field("Own Item"; Rec."Own Item")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Own Item field.', Comment = 'DAN="Egen vare"';
            }
            field("Organic Item"; Rec."Organic Item")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Organic Item field.', Comment = 'DAN="Økologisk vare"';
            }
            field("Discontinued Item"; Rec."Discontinued Item")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Discontinued Item field.', Comment = 'DAN="Udgået vare"';
            }
            field(Biodynamic; Rec.Biodynamic)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Biodynamic field.', Comment = 'DAN="Biodynamisk"';
            }
            field(Natural; Rec.Natural)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Natural field.', Comment = 'DAN="Naturvin"';
            }
            field(Vintage; Rec.Vintage)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vintage field.', Comment = 'DAN="Årgang"';
            }
            field("Age(Year)"; Rec."Age(Year)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Age(Year) field.', Comment = 'DAN="Alder (år)"';
            }
            field("Sell Only in Store"; Rec."Sell Only in Store")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sell Only in Store field.', Comment = 'DAN="Må kun sælges i butik"';
            }
            field("Inventory Allocation Engros"; Rec."Inventory Allocation Engros")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Inventory Allocation Engros field.', Comment = 'DAN="Lagerplacering Engros"';
            }
            field("Inventory Allocation Værn"; Rec."Inventory Allocation Værn")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Inventory Allocation Værn field.', Comment = 'DAN="Lagerplacering Værn"';
            }
            field(Marketing; Rec.Marketing)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Marketing field.', Comment = 'DAN="Markedsføring"';
            }
            field("Best Before / Expires"; Rec."Best Before / Expires")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Best Before / Expires field.', Comment = 'DAN="Bedst før/udløber"';
            }
        }
        addafter(Item)
        {
            group(Grapes)
            {
                Caption = 'Geography, Grapes and Use', Comment = 'DAN="Geografi, Druer og anvendelse"';

                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country field.', Comment = 'DAN="Land"';
                }
                field(Region; Rec.Region)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Region field.', Comment = 'DAN="Region"';
                }
                field(District; Rec.District)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the District field.', Comment = 'DAN="Distrikt"';
                }
                field("Grape 1"; Rec."Grape 1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Grape 1 field.', Comment = 'DAN="Drue 1"';
                }
                field("Grape 2"; Rec."Grape 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Grape 2 field.', Comment = 'DAN="Drue 2"';
                }
                field("Grape 3"; Rec."Grape 3")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Grape 3 field.', Comment = 'DAN="Drue 3"';
                }
                field(Manufactured; Rec.Manufactured)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Manufactured field.', Comment = 'DAN="Fremstillet på"';
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product Type field.', Comment = 'DAN="Produkt type"';
                }
            }
        }
    }
    actions
    {
        addafter(CopyItem)
        {
            action(SendToCompany)
            {
                Caption = 'Send to Company', comment = 'DAN="Send til regnskab"';
                ApplicationArea = All;
                Ellipsis = true;
                ToolTip = 'Create new Item in another Company';

                trigger OnAction()
                var
                    ItemCopy: Record Item;
                    ItemUnitOfMeasureCopy: Record "Item Unit of Measure";
                    ItemReference: Record "Item Reference";
                    ItemReferenceCopy: Record "Item Reference";
                    PriceListLine: Record "Price List Line";
                    PriceListLineCopy: Record "Price List Line";
                    NewItemCopy: integer;
                    NewPriceListLineCopy: integer;
                    NewItemReferenceCopy: integer;
                    CopyItemYNLbl: Label 'Copy Item Card to %1?', Comment = 'DAN="Kopier varekort til %1?"';
                    ItemCopiedLbl: Label 'Item %1 is created (incl. Sales Price Lists) in %2.', Comment = 'DAN="Vare %1 er oprettet (incl. salgspriser) i %2."';
                    NotItemCopiedLbl: Label 'There has been created %1 Sales Price List(s) and %2 Item Refenence(s) in %3.', Comment = 'DAN="Der er oprettet %1 salgslistepris(er) og %2 varereference(r) i %3."';
                    NotCreatedLbl: Label 'Nothing has been created in %1', Comment = 'DAN="Der er ikke oprettet noget i %1"';
                begin
                    NewItemCopy:=0;
                    NewItemReferenceCopy:=0;
                    NewPriceListLineCopy:=0;
                    //>> ****************************************************** Sendes til Juuls Vin og Spiritus **************************************************
                    IF COMPANYNAME = 'Juuls Engros' THEN IF CONFIRM(StrSubstNo(CopyItemYNLbl, 'Vin og Spiritus?'), TRUE)THEN Begin
                            ItemCopy.CHANGECOMPANY('Juuls Vin og Spiritus');
                            ItemCopy:=Rec;
                            IF ItemCopy.INSERT()THEN NewItemCopy:=1;
                            ItemUnitOfMeasureCopy.CHANGECOMPANY('Juuls Vin og Spiritus');
                            ItemUnitOfMeasureCopy."Item No.":=rec."No.";
                            ItemUnitOfMeasureCopy.Code:=rec."Base Unit of Measure";
                            ItemUnitOfMeasureCopy."Qty. per Unit of Measure":=1;
                            IF ItemUnitOfMeasureCopy.INSERT()Then;
                            PriceListLineCopy.CHANGECOMPANY('Juuls Vin og Spiritus');
                            PriceListLine.SETCURRENTKEY("Asset Type", "Asset No.", "Price Type", "Amount Type", Status);
                            PriceListLine.SetRange("Asset Type", PriceListLine."Asset Type"::Item);
                            PriceListLine.setrange("Asset No.", rec."No.");
                            PriceListLine.setrange("Price Type", PriceListLine."Price Type"::Sale);
                            PriceListLine.Setfilter(Status, '%1..%2', PriceListLine.Status::Draft, PriceListLine.Status::Active);
                            IF PriceListLine.FINDSET()THEN REPEAT PriceListLineCopy:=PriceListLine;
                                    IF PriceListLineCopy.INSERT()THEN NewPriceListLineCopy:=NewPriceListLineCopy + 1;
                                UNTIL PriceListLine.NEXT() = 0;
                            ItemReferenceCopy.CHANGECOMPANY('Juuls Vin og Spiritus');
                            ItemReference.SETRANGE("Item No.", rec."No.");
                            IF ItemReference.FINDSET()THEN REPEAT ItemReferenceCopy:=ItemReference;
                                    IF ItemReferenceCopy.INSERT()THEN NewItemReferenceCopy:=NewItemReferenceCopy + 1;
                                UNTIL ItemReference.NEXT() = 0;
                            if NewItemCopy = 1 then MESSAGE(StrSubstNo(ItemCopiedLbl, rec."No.", 'Juuls Vin og Spiritus'))
                            else if(NewPriceListLineCopy <> 0) or (NewItemReferenceCopy <> 0)then MESSAGE(StrSubstNo(NotItemCopiedLbl, NewPriceListLineCopy, NewItemReferenceCopy, 'Juuls Vin og Spiritus'))
                                else
                                    MESSAGE(StrSubstNo(NotCreatedLbl, 'Juuls Vin og Spiritus'))END
                        ELSE //>> ****************************************************** Sendes til Lyngby Vinkælder **************************************************
                            IF CONFIRM(StrSubstNo(CopyItemYNLbl, 'Lyngby Vinkælder?'), TRUE)THEN BEGIN
                                ItemCopy.CHANGECOMPANY('Lyngby Vinkælder');
                                ItemCopy:=Rec;
                                //LcItem."Tax Group Code (Juul)" := '';
                                IF ItemCopy.INSERT()then NewItemCopy:=1;
                                ItemUnitOfMeasureCopy.CHANGECOMPANY('Lyngby Vinkælder');
                                ItemUnitOfMeasureCopy."Item No.":=rec."No.";
                                ItemUnitOfMeasureCopy.Code:=rec."Base Unit of Measure";
                                ItemUnitOfMeasureCopy."Qty. per Unit of Measure":=1;
                                IF ItemUnitOfMeasureCopy.INSERT()THEN;
                                PriceListLineCopy.CHANGECOMPANY('Lyngby Vinkælder');
                                PriceListLine.SETCURRENTKEY("Asset Type", "Asset No.", "Price Type", "Amount Type", Status);
                                PriceListLine.SetRange("Asset Type", PriceListLine."Asset Type"::Item);
                                PriceListLine.setrange("Asset No.", rec."No.");
                                PriceListLine.setrange("Price Type", PriceListLine."Price Type"::Sale);
                                PriceListLine.Setfilter(Status, '%1..%2', PriceListLine.Status::Draft, PriceListLine.Status::Active);
                                IF PriceListLine.FINDSET()THEN REPEAT PriceListLineCopy:=PriceListLine;
                                        IF PriceListLineCopy.INSERT()THEN NewPriceListLineCopy:=NewPriceListLineCopy + 1;
                                    UNTIL PriceListLine.NEXT() = 0;
                                ItemReferenceCopy.CHANGECOMPANY('Lyngby Vinkælder');
                                ItemReference.SETRANGE("Item No.", rec."No.");
                                IF ItemReference.FINDSET()THEN REPEAT ItemReferenceCopy:=ItemReference;
                                        IF ItemReferenceCopy.INSERT()THEN NewItemReferenceCopy:=NewItemReferenceCopy + 1;
                                    UNTIL ItemReference.NEXT() = 0;
                                if NewItemCopy = 1 then MESSAGE(StrSubstNo(ItemCopiedLbl, rec."No.", 'Lyngby Vinkælder'))
                                else if(NewPriceListLineCopy <> 0) or (NewItemReferenceCopy <> 0)then MESSAGE(StrSubstNo(NotItemCopiedLbl, NewPriceListLineCopy, NewItemReferenceCopy, 'Lyngby Vinkælder'))
                                    else
                                        MESSAGE(StrSubstNo(NotCreatedLbl, 'Lyngby Vinkælder'))END;
                end;
            }
        }
        addafter(CopyItem_Promoted)
        {
            actionref(SendToCompanyPromoted; SendToCompany)
            {
            }
        }
    }
}
