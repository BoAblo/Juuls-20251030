reportextension 50005 "CST Sales Cr. Memo" extends "Standard Sales - Credit Memo" //1307
{
    dataset
    {
        add(Header)
        {
            column(ECOText_; ECOText_)
            {
            }
            column(CompanyInfo_PhoneNo; CompanyInfo_PhoneNo)
            {
            }
            column(CompanyInfo_EMail; CompanyInfo_EMail)
            {
            }
            column(CompanyInfo_HomePage; CompanyInfo_HomePage)
            {
            }
            column(CompanyBankAccount_IBANEURO; CompanyBankAccount."IBAN (EURO)")
            {
            }
            column(CompanyBankAccount_IBANEUROLbl; CompanyBankAccount.FieldCaption("IBAN (EURO)"))
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
            column(PostingDateLbl; Header.FieldCaption("Posting Date"))
            {
            }
            column(NewSalesPerson_Lbl; NewSalespersonTxt)
            {
            }
            column(NewExternalDocumentNo_Lbl; NewExternalDocumentNoTxt)
            {
            }
            column(NewYourReference_Lbl; NewYourReferenceTxt)
            {
            }
            column(NewPackageTrackingNo_Lbl; NewPackageTrackingNoTxt)
            {
            }
            column(DocPicture; CompanyInfo.DocPicture)
            {
            }
        }
        modify(Header)
        {
        trigger OnAfterAfterGetRecord()
        var
            ItemContents: Record "Item Contents";
            DutyGroupLine: Record "Duty Group Line";
            TempInventoryBuffer: Record "Inventory Buffer" temporary;
        begin
            ECOText_:='';
            If CompanyInfo."ECO-Text" <> '' then ECOText_:=CompanyInfo."ECO-Text";
            CompanyInfo.CalcFields(Picture);
            CompanyInfo.CalcFields("Picture (Web)");
            Customer.get("Sell-to Customer No.");
            if Customer."Company Information (Web)" then begin
                CompanyInfo_PhoneNo:=CompanyInfo."Phone No. (web)";
                CompanyInfo_EMail:=CompanyInfo."E-Mail (Web)";
                CompanyInfo_HomePage:=CompanyInfo."Home Page (Web)";
                if CompanyInfo."Picture (Web)".HasValue then CompanyInfo.DocPicture:=CompanyInfo."Picture (Web)"
                else
                    CompanyInfo.DocPicture:=CompanyInfo.Picture;
            end
            else
            begin
                CompanyInfo_PhoneNo:=CompanyInfo."Phone No.";
                CompanyInfo_EMail:=CompanyInfo."E-Mail";
                CompanyInfo_HomePage:=CompanyInfo."Home Page";
                CompanyInfo.DocPicture:=CompanyInfo.Picture;
            end;
            //Hvordan ved jeg hvilke varer der skal med i beregningen "Item Tax Group Code" = SPRIT
            EthanolLiter:=0;
            i:=0;
            clear(TempInventoryBuffer);
            clear(LiterCapt);
            clear(LiterDec);
            SCML.SETRANGE("Document No.", "No.");
            SCML.SETRANGE(Type, SCML.Type::Item);
            IF SCML.FINDset()THEN REPEAT Item.SETRANGE("No.", SCML."No.");
                    IF Item.FINDfirst()THEN IF Item."Contents Code" <> '' then begin
                            ItemContents.get(Item."Contents Code");
                            ItemContents.TestField(Contents);
                            //Spiritus
                            IF StrPos(Item."Duty Group Code", 'SPRIT') <> 0 THEN EthanolLiter:=EthanolLiter + (((ItemContents.Contents / 1000) * SCML.Quantity) * (Item."Alcohol%" / 100))
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
                                        TempInventoryBuffer.Quantity:=SCML.Quantity * (ItemContents.Contents / 1000);
                                        TempInventoryBuffer.insert();
                                    end
                                    else
                                    begin
                                        TempInventoryBuffer.Quantity:=TempInventoryBuffer.Quantity + (SCML.Quantity * (ItemContents.Contents / 1000));
                                        TempInventoryBuffer.Modify();
                                    end;
                                end;
                            end;
                        end;
                UNTIL SCML.NEXT() = 0;
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
            //Blanke ledetekster
            IF header."Salesperson Code" = '' then NewSalespersonTxt:=''
            else
                NewSalespersonTxt:=NewSalespersonLbl;
            IF header."External Document No." = '' then NewExternalDocumentNoTxt:=''
            else
                NewExternalDocumentNoTxt:=NewExternalDocumentNoLbl;
            IF header."Your Reference" = '' then NewYourReferenceTxt:=''
            else
                NewYourReferenceTxt:=NewYourReferenceLbl;
            IF Header."Package Tracking No." = '' then NewPackageTrackingNoTxt:=''
            else
                NewPackageTrackingNoTxt:=NewPackageTrackingNoLbl;
        end;
        }
        add(Line)
        {
            column(EtanolPct_Lbl; Item.FieldCaption("Alcohol%"))
            {
            }
            column(EtanolPct; Item."Alcohol%")
            {
            }
            column(AgeYear_Lbl; Item.FieldCaption("Age(Year)"))
            {
            }
            column(AgeYear; Item."Age(Year)")
            {
            }
            column(NoOfLitreLbl; NoOfLitreLbl)
            {
            }
        }
        modify(Line)
        {
        trigger OnAfterAfterGetRecord()
        var
        begin
            clear(Item);
            if line.Type = Line.type::Item then if Item.get(line."No.")then;
        end;
        trigger OnAfterPreDataItem()
        begin
        end;
        }
    }
    rendering
    {
        layout("JuulsSalesCreditMemoDiffLogo.rdlc")
        {
            Type = RDLC;
            LayoutFile = './ReportExt/layout/JuulsSalesCreditMemoDiffLogo.rdlc';
            Caption = 'Juul´s Engros Sales Cr. Memo - Diff. Logo', comment = 'DAN="Juul´s Engros salgskreditnota - Diff. Logo"';
            Summary = 'Juul´s Engros Sales Cr. Memo is a customized layout for Juul´s Engros';
        }
    }
    var Customer: Record Customer;
    SCML: Record "Sales Cr.Memo Line";
    Item: Record Item;
    EthanolLiter: Decimal;
    EtanolPct: Decimal;
    LiterDec: array[20]of Decimal;
    i: integer;
    CompanyInfo_PhoneNo: Text[30];
    CompanyInfo_EMail: Text[80];
    CompanyInfo_HomePage: Text[255];
    ECOText_: text[100];
    NewSalespersonTxt: text;
    NewExternalDocumentNoTxt: Text;
    NewYourReferenceTxt: Text;
    NewPackageTrackingNoTxt: Text;
    DocumentReference: Text;
    LiterCapt: array[20]of Text[100];
    EmptyCPMOCRReferenceType: Boolean;
    NoOfLitreLbl: Label 'Quantity in liters', comment = 'DAN="Mængde i liter"';
    NewSalespersonLbl: Label 'Our Reference', comment = 'DAN="Vores reference"';
    NewExternalDocumentNoLbl: Label 'Your Rekv. No.', comment = 'DAN="Deres rekv. nr."';
    NewYourReferenceLbl: Label 'Your Reference', comment = 'DAN="Deres reference"';
    NewPackageTrackingNoLbl: Label 'Tracking No.', comment = 'DAN="Trackingnr."';
}
