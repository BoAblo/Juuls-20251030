reportextension 50006 "CST Purchase - Order" extends "Order" //405 - 1322 har ingen RDLC layout
{
    dataset
    {
        add("Purchase Header")
        {
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_IBAN; CompanyInfo.IBAN)
            {
            }
            column(CompanyInfo_IBANLbl; CompanyInfo.FieldCaption(IBAN))
            {
            }
            column(CompanyInfo_SWIFT; CompanyInfo."SWIFT Code")
            {
            }
            column(CompanyInfo_SWIFTLbl; CompanyInfo.FieldCaption("SWIFT Code"))
            {
            }
            column(CompanyInfo_IBANEURO; CompanyInfo."IBAN (EURO)")
            {
            }
            column(CompanyInfo_IBANEUROLbl; CompanyInfo.FieldCaption("IBAN (EURO)"))
            {
            }
            column(CompanyInfo_BankBranchNo; CompanyInfo."Bank Branch No.")
            {
            }
            column(LiterCapt1; LiterCapt[1])
            {
            }
            column(LiterCapt2; LiterCapt[2])
            {
            }
            column(LiterCapt3; LiterCapt[3])
            {
            }
            column(LiterCapt4; LiterCapt[4])
            {
            }
            column(LiterCapt5; LiterCapt[5])
            {
            }
            column(LiterCapt6; LiterCapt[6])
            {
            }
            column(LiterDec1; LiterDec[1])
            {
            }
            column(LiterDec2; LiterDec[2])
            {
            }
            column(LiterDec3; LiterDec[3])
            {
            }
            column(LiterDec4; LiterDec[4])
            {
            }
            column(LiterDec5; LiterDec[5])
            {
            }
            column(LiterDec6; LiterDec[6])
            {
            }
            column(PostingDate; Format("Posting Date", 0, 4))
            {
            }
            column(PostingDateLbl; "Purchase Header".FieldCaption("Posting Date"))
            {
            }
            column(NoOfLitreLbl; NoOfLitreLbl)
            {
            }
            column(EtanolPct_Lbl; Item.FieldCaption("Alcohol%"))
            {
            }
            column(AgeYear_Lbl; Item.FieldCaption("Age(Year)"))
            {
            }
            column(Vintage_Lbl; Item.FieldCaption(Vintage))
            {
            }
        }
        modify("Purchase Header")
        {
        trigger OnAfterAfterGetRecord()
        var
            ItemContents: Record "Item Contents";
            DutyGroupLine: Record "Duty Group Line";
            TempInventoryBuffer: Record "Inventory Buffer" temporary;
        begin
            CompanyInfo.get();
            CompanyInfo.CalcFields(Picture);
            //Hvordan ved jeg hvilke varer der skal med i beregningen "Item Tax Group Code" = SPRIT
            EthanolLiter:=0;
            i:=0;
            clear(TempInventoryBuffer);
            clear(LiterCapt);
            clear(LiterDec);
            PL.SETRANGE("Document No.", "No.");
            PL.SETRANGE(Type, PL.Type::Item);
            IF PL.FINDset()THEN REPEAT Item.SETRANGE("No.", PL."No.");
                    IF Item.FINDfirst()THEN IF Item."Contents Code" <> '' then begin
                            ItemContents.get(Item."Contents Code");
                            ItemContents.TestField(Contents);
                            //Spiritus
                            IF StrPos(Item."Duty Group Code", 'SPRIT') <> 0 THEN EthanolLiter:=EthanolLiter + (((ItemContents.Contents / 1000) * PL.Quantity) * (Item."Alcohol%" / 100))
                            else
                            begin
                                //Vin
                                DutyGroupLine.setrange("Duty Group Code", Item."Duty Group Code");
                                DutyGroupLine.setrange("Duty Entry Type", DutyGroupLine."Duty Entry Type"::Sale);
                                DutyGroupLine.setrange("Duty Line Type", DutyGroupLine."Duty Line Type"::"Duty Code");
                                if DutyGroupLine.FindFirst()then begin
                                    TempInventoryBuffer.setrange("Item No.", DutyGroupLine."Duty Code");
                                    if not TempInventoryBuffer.FindFirst()then begin
                                        TempInventoryBuffer."Item No.":=DutyGroupLine."Duty Code";
                                        TempInventoryBuffer.Quantity:=PL.Quantity * (ItemContents.Contents / 1000);
                                        TempInventoryBuffer.insert();
                                    end
                                    else
                                    begin
                                        TempInventoryBuffer.Quantity:=TempInventoryBuffer.Quantity + (PL.Quantity * (ItemContents.Contents / 1000));
                                        TempInventoryBuffer.Modify();
                                    end;
                                end;
                            end;
                        end;
                UNTIL PL.NEXT() = 0;
            IF EthanolLiter <> 0 THEN BEGIN
                i+=1;
                LiterCapt[i]:='Spiritus:';
                LiterDec[i]:=EthanolLiter;
            END;
            TempInventoryBuffer.setrange("Item No.");
            if TempInventoryBuffer.FindSet()then repeat i+=1;
                    LiterCapt[i]:=TempInventoryBuffer."Item No.";
                    LiterDec[i]:=TempInventoryBuffer.Quantity;
                until TempInventoryBuffer.next() = 0;
        end;
        }
        add(RoundLoop)
        {
            column(EtanolPct; Item."Alcohol%")
            {
            }
            column(AgeYear; Item."Age(Year)")
            {
            }
            column(Vintage; Item.Vintage)
            {
            }
        }
        modify(RoundLoop)
        {
        trigger OnAfterAfterGetRecord()
        var
        begin
            clear(Item);
            if "Purchase Line".Type = "Purchase Line".type::Item then if Item.get("Purchase Line"."No.")then;
        end;
        trigger OnAfterPreDataItem()
        begin
        end;
        }
    }
    rendering
    {
        layout("CSTPurchaseOrder.rdlc")
        {
            Type = RDLC;
            LayoutFile = './ReportExt/layout/JuulsPurchaseOrder.rdlc';
            Caption = 'Juul´s Engros Purchase Order', comment = 'DAN="Juul´s Engros købsordre"';
            Summary = 'Juul´s Engros Purchase Order is a customized layout for Juul´s Engros';
        }
    }
    var PL: Record "Purchase Line";
    Item: Record Item;
    EthanolLiter: Decimal;
    EtanolPct: Decimal;
    LiterDec: array[20]of Decimal;
    LiterCapt: array[20]of Text[100];
    i: integer;
    EmptyCPMOCRReferenceType: Boolean;
    NoOfLitreLbl: Label 'Quantity in liters', comment = 'DAN="Mængde i liter"';
}
