reportextension 50007 "CST Sales Document - Test" extends "Sales Document - Test"
{
    dataset
    {
        add("Sales Header")
        {
            column(ShowWorkDescription; ShowWorkDescription)
            {
            }
        }
        modify("Sales header")
        {
        trigger OnAfterAfterGetRecord()
        var
        begin
            "Sales header".CalcFields("Work Description");
            ShowWorkDescription:="Sales header"."Work Description".HasValue;
        end;
        }
        add("RoundLoop")
        {
            column(EtanolPct_Lbl; ItemExt.FieldCaption("Alcohol%"))
            {
            }
            column(EtanolPct; ItemExt."Alcohol%")
            {
            }
            column(AgeYear_Lbl; ItemExt.FieldCaption("Age(Year)"))
            {
            }
            column(AgeYear; ItemExt."Age(Year)")
            {
            }
            column(Vintage_Lbl; ItemExt.FieldCaption("Vintage"))
            {
            }
            column(Vintage; ItemExt."Vintage")
            {
            }
            column(GTIN_Lbl; ItemExt.FieldCaption(GTIN))
            {
            }
            column(GTIN; ItemExt_GTIN)
            {
            }
            column(UOM_Lbl; "Sales Line".FieldCaption("Unit of Measure"))
            {
            }
            column(UOM; "Sales Line"."Unit of Measure")
            {
            }
            column(InventoryAllocation_Lbl; ItemExt.FieldCaption("Inventory Allocation Engros"))
            {
            }
            column(InventoryAllocation; ItemExt."Inventory Allocation Engros")
            {
            }
            column(BinCode_Lbl; "Sales Line".FieldCaption("Bin Code"))
            {
            }
            column(BinCode; "Sales Line"."Bin Code")
            {
            }
            column(MultiGTIN; MultiGTIN)
            {
            }
        }
        modify("RoundLoop")
        {
        trigger OnAfterAfterGetRecord()
        var
            CSTJuulsFunction: Codeunit "CST - Juuls Functions";
        begin
            MultiGTIN:=false;
            clear(ItemExt);
            if "Sales Line".Type = "Sales Line".type::Item then if ItemExt.get("Sales Line"."No.")then MultiGTIN:=CSTJuulsFunction.MultiGTINNumre("Sales Line"."No.");
            IF MultiGTIN then ItemExt_GTIN:='**' + ItemExt.GTIN
            else
                ItemExt_GTIN:=ItemExt.GTIN end;
        }
        addafter(RoundLoop)
        {
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
                    "Sales Header"."Work Description".CreateInStream(WorkDescriptionInstream, TEXTENCODING::UTF8);
                end;
            }
        }
    // modify(PageCounter)
    // {
    //     trigger OnAfterAfterGetRecord()
    //     begin
    //         if not CurrReport.Preview() then begin
    //             "Sales Header"."No. Printed (Picking Note)" := "Sales Header"."No. Printed (Picking Note)" + 1;
    //             "Sales Header".Modify();
    //         end;
    //     end;
    // }
    }
    rendering
    {
        layout("JuulsSalesDocumentTest.rdlc")
        {
            Type = RDLC;
            LayoutFile = './ReportExt/layout/JuulsSalesDocumentTest.rdlc';
            Caption = 'Juul´s Engros Sales Document - Test', comment = 'DAN="Juul´s Engros - Plukseddel"';
            Summary = 'Juul´s Engros Sales Document - Test is a customized layout for Juul´s Engros';
        }
    }
    var ItemExt: Record Item;
    WorkDescriptionInstream: InStream;
    MultiGTIN: Boolean;
    ShowWorkDescription: Boolean;
    WorkDescriptionLine: Text;
    ItemExt_GTIN: code[17];
}
