report 50012 "CST - EMCS"
{
    DefaultLayout = RDLC;
    ApplicationArea = All;
    UsageCategory = Administration;
    RDLCLayout = './Report/layout/JuulsEMCS.rdlc';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.", "Posting Date";

            column(CompanyName; COMPANYNAME)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(SIHFilter; SIHFilter)
            {
            }
            column(SIH_No; "Sales Invoice Header"."No.")
            {
            }
            column(InvoiceNoCapt; InvoiceNoLbl)
            {
            }
            column(ItemNoCapt; ItemNoLbl)
            {
            }
            column(QuantityCapt; QuantityLbl)
            {
            }
            column(LiterCapt; LiterLbl)
            {
            }
            column(GrossWeightCapt; GrossWeightLbl)
            {
            }
            column(UnitsPerParcelCapt; UnitsPerParcelLbl)
            {
            }
            column(NoOfLitersCapt; NoOfLitersLbl)
            {
            }
            column(TotalGrossWeightCapt; TotalGrossWeightLbl)
            {
            }
            column(TotalNetWeightCapt; TotalNetWeightLbl)
            {
            }
            column(EthanolPercentageCapt; EthanolPercentageLbl)
            {
            }
            column(ItemTariffNoCapt; ItemTariffNoLbl)
            {
            }
            column(ItemDescriptionCapt; ItemDescriptionLbl)
            {
            }
            column(NoOfParcelsCapt; NoOfParcelsLbl)
            {
            }
            column(Header2QuantityCapt; Header2QuantityLbl)
            {
            }
            column(Header2GrossWeightCapt; Header2GrossWeightLbl)
            {
            }
            column(Header2NetWeightCapt; Header2NetWeightLbl)
            {
            }
            column(Header2EthanolPercCapt; Header2EthanolPercLbl)
            {
            }
            column(Header2KNCodeCapt; Header2KNCodeLbl)
            {
            }
            column(Header2CommDescrCapt; Header2CommDescrLbl)
            {
            }
            column(Header2NoOfParcelsCapt; Header2NoOfParcelsLbl)
            {
            }
            column(PostingDate; "Sales Invoice Header"."Posting Date")
            {
            }
            column(ShipToAddress; "Sales Invoice Header"."Ship-to Address")
            {
            }
            column(ShipToAdress2; "Sales Invoice Header"."Ship-to Address 2")
            {
            }
            column(ShipToCity; "Sales Invoice Header"."Ship-to City")
            {
            }
            column(ShipToName; "Sales Invoice Header"."Ship-to Name")
            {
            }
            column(InvoiceNo; "Sales Invoice Header"."No.")
            {
            }
            column(ShipToPostCode; "Sales Invoice Header"."Ship-to Post Code")
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No."=FIELD("No.");
                DataItemTableView = WHERE(Type=FILTER(Item), "No."=FILTER(<>''));

                column(SIL_DocNo; "Sales Invoice Line"."Document No.")
                {
                }
                column(SIL_No; "Sales Invoice Line"."No.")
                {
                }
                column(SIL_Quantity; "Sales Invoice Line".Quantity)
                {
                }
                column(SIL_Liter; ItemContents.Contents / 1000)
                {
                }
                column(SIL_GrossWeight; "Sales Invoice Line"."Gross Weight")
                {
                }
                column(SIL_UnitsPerParcel; "Sales Invoice Line"."Units per Parcel")
                {
                }
                column(NoOfLiters; "Sales Invoice Line".Quantity * (ItemContents.Contents / 1000))
                {
                }
                column(TotalGrossWeight; "Sales Invoice Line".Quantity * "Sales Invoice Line"."Gross Weight")
                {
                }
                column(TotalNetWeight; "Sales Invoice Line".Quantity * "Sales Invoice Line"."Net Weight")
                {
                }
                column(SIL_EthanolPercentage; Item."Alcohol%")
                {
                }
                column(Item_ItemTariffNo; ItemTariffCode)
                {
                }
                column(Item_ItemDescription; ItemDescription)
                {
                }
                column(NoOfParcels; NoOfParcels)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    Clear(ItemContents);
                    NoOfParcels:=0;
                    ItemTariffCode:='';
                    ItemDescription:='';
                    NoOfParcels:=0.0;
                    IF "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item then begin
                        IF Item.GET("No.")THEN BEGIN
                            IF(Item."Tariff No." <> '')THEN ItemTariffCode:=Item."Tariff No.";
                            IF(Item.Description <> '')THEN ItemDescription:=Item.Description;
                        END;
                        IF("Sales Invoice Line"."Units per Parcel" <> 0)THEN NoOfParcels:="Sales Invoice Line".Quantity / "Sales Invoice Line"."Units per Parcel";
                        IF Item."Contents Code" <> '' then begin
                            ItemContents.get(Item."Contents Code");
                            ItemContents.TestField(Contents);
                        end;
                    end;
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
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
        SIHFilter:="Sales Invoice Header".GETFILTERS();
    end;
    var var ItemContents: Record "Item Contents";
    Item: Record Item;
    SIHFilter: Text;
    ItemTariffCode: Code[20];
    ItemDescription: Text[100];
    NoOfParcels: Decimal;
    PageCaptionLbl: Label 'Page', comment = 'DAN="Side"';
    InvoiceNoLbl: Label 'Invoice No.', comment = 'DAN="Fakturanr."';
    ItemNoLbl: Label 'Item No.', comment = 'DAN="Varenr."';
    QuantityLbl: Label 'Quantity', comment = 'DAN="Antal"';
    LiterLbl: Label 'Liter', comment = 'DAN="Liter"';
    GrossWeightLbl: Label 'Gross Weight', comment = 'DAN="Bruttovægt"';
    UnitsPerParcelLbl: Label 'Units per Parcel', comment = 'DAN="Antal pr. kolli"';
    NoOfLitersLbl: Label 'No of Liters', comment = 'DAN="Antal liter"';
    TotalGrossWeightLbl: Label 'Total Gross Weight', comment = 'DAN="Mængde bruttovægt"';
    TotalNetWeightLbl: Label 'Total Net Weight', comment = 'DAN="Mængde nettovægt"';
    EthanolPercentageLbl: Label 'Ethanol Percentage', comment = 'DAN="Alkohol %"';
    ItemTariffNoLbl: Label 'Tariff No.', comment = 'DAN="Varekode"';
    ItemDescriptionLbl: Label 'Item Description', comment = 'DAN="Varebeskrivelse"';
    NoOfParcelsLbl: Label 'Parcels', comment = 'DAN="Kolli"';
    Header2QuantityLbl: Label 'Quantity (Liter)', comment = 'DAN="Mængde"';
    Header2GrossWeightLbl: Label 'Gross Weight (Total)', comment = 'DAN="Bruttovægt (total)"';
    Header2NetWeightLbl: Label 'Net Weight (Total)', comment = 'DAN="Nettovægt (total)"';
    Header2EthanolPercLbl: Label 'Ethanol Percentage', comment = 'DAN="Alkohol styrke"';
    Header2KNCodeLbl: Label 'Tariff No.', comment = 'DAN="KN-kode"';
    Header2CommDescrLbl: Label 'Commercial Description', comment = 'DAN="Kommerciel beskrivelse"';
    Header2NoOfParcelsLbl: Label 'No of Parcels', comment = 'DAN="Antal kolli"';
}
