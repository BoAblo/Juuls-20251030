reportextension 50003 "CST Sales Invoice" extends "Standard Sales - Invoice" // 1306
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
            column(PaymentID_; PaymentID_)
            {
            }
            column(PaymentIDTxt; PaymentIDTxt)
            {
            }
            column(PaymentTxt; PaymentTxt)
            {
            }
            column(DocumentReferenceTxt; DocumentReferenceTxt)
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
            PaymentID:='';
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
            SIL.SETRANGE("Document No.", "No.");
            SIL.SETRANGE(Type, SIL.Type::Item);
            IF SIL.FINDset()THEN REPEAT Item.SETRANGE("No.", SIL."No.");
                    IF Item.FINDfirst()THEN IF Item."Contents Code" <> '' then begin
                            ItemContents.get(Item."Contents Code");
                            ItemContents.TestField(Contents);
                            //Spiritus
                            IF StrPos(Item."Duty Group Code", 'SPRIT') <> 0 THEN EthanolLiter:=EthanolLiter + (((ItemContents.Contents / 1000) * SIL.Quantity) * (Item."Alcohol%" / 100))
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
                                        TempInventoryBuffer.Quantity:=sil.Quantity * (ItemContents.Contents / 1000);
                                        TempInventoryBuffer.insert();
                                    end
                                    else
                                    begin
                                        TempInventoryBuffer.Quantity:=TempInventoryBuffer.Quantity + (sil.Quantity * (ItemContents.Contents / 1000));
                                        TempInventoryBuffer.Modify();
                                    end;
                                end;
                            end;
                        end;
                UNTIL SIL.NEXT() = 0;
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
            //Betaling
            CASE SalesSetup."CPM OCR Reference Type" OF SalesSetup."CPM OCR Reference Type"::"01": PmtIDLength:=0;
            SalesSetup."CPM OCR Reference Type"::"04": PmtIDLength:=16;
            SalesSetup."CPM OCR Reference Type"::"15": PmtIDLength:=16;
            SalesSetup."CPM OCR Reference Type"::"71": PmtIDLength:=15;
            SalesSetup."CPM OCR Reference Type"::"73": PmtIDLength:=0;
            SalesSetup."CPM OCR Reference Type"::"75": PmtIDLength:=16;
            ELSE
            begin
                PmtIDLength:=0;
                EmptyCPMOCRReferenceType:=true;
            end;
            END;
            DocumentReferenceTxt:='';
            PaymentIDTxt:='';
            PaymentID:='';
            PaymentID_:='';
            PaymentTxt:='';
            IF PmtIDLength > 0 THEN BEGIN
                PaymentID:=PADSTR('', PmtIDLength - 2 - STRLEN("No."), '0') + "No." + '0';
                PaymentID:=PaymentID + Modulus10(PaymentID);
            END
            ELSE
            begin
                DocumentReferenceTxt:='';
                PaymentID:=PADSTR('', PmtIDLength, '0');
            END;
            IF Header."Payment Method Code" <> 'CS' THEN BEGIN
                IF(CompanyInfo.BankCreditorNo <> '') AND not EmptyCPMOCRReferenceType THEN BEGIN
                    DocumentReferenceTxt:=DocumentReferenceCaptionLbl;
                    PaymentID_:='+' + format(SalesSetup."CPM OCR Reference Type") + '<' + PaymentID + ' +' + CompanyInfo.BankCreditorNo + '<';
                    PaymentIDTxt:=PaymentID_Lbl;
                END END
            ELSE
                PaymentTxt:=PaymentTxt1_Lbl;
            IF(Header."Payment Method Code" = 'WEBSHOP') AND (Header."Payment Terms Code" = 'KONTANT')THEN BEGIN
                PaymentTxt:=PaymentTxt2_Lbl;
                DocumentReferenceTxt:='';
                PaymentID_:='';
                PaymentIDTxt:='';
            END;
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
        layout("JuulsSalesInvoiceDiffLogo.rdlc")
        {
            Type = RDLC;
            LayoutFile = './ReportExt/layout/JuulsSalesInvoiceDiffLogo.rdlc';
            Caption = 'Juul´s Engros Sales Invoice - Diff. Logo', comment = 'DAN="Juul´s Engros salgsfaktura - Diff. Logo"';
            Summary = 'Juul´s Engros Sales Invoice is a customized layout for Juul´s Engros';
        }
    }
    procedure Modulus10(TestNumber: Code[16]): Code[16]var
        Counter: Integer;
        Accumulator: Integer;
        WeightNo: Integer;
        SumStr: Text[30];
    begin
        WeightNo:=2;
        SumStr:='';
        FOR Counter:=STRLEN(TestNumber)DOWNTO 1 DO BEGIN
            EVALUATE(Accumulator, COPYSTR(TestNumber, Counter, 1));
            Accumulator:=Accumulator * WeightNo;
            SumStr:=SumStr + FORMAT(Accumulator);
            IF WeightNo = 1 THEN WeightNo:=2
            ELSE
                WeightNo:=1;
        END;
        Accumulator:=0;
        FOR Counter:=1 TO STRLEN(SumStr)DO BEGIN
            EVALUATE(WeightNo, COPYSTR(SumStr, Counter, 1));
            Accumulator:=Accumulator + WeightNo;
        END;
        Accumulator:=10 - (Accumulator MOD 10);
        IF Accumulator = 10 THEN EXIT('0')
        ELSE
            EXIT(FORMAT(Accumulator));
    end;
    var Customer: Record Customer;
    SIL: Record "Sales Invoice Line";
    Item: Record Item;
    EthanolLiter: Decimal;
    LiterDec: array[20]of Decimal;
    i: integer;
    PmtIDLength: Integer;
    PaymentID: Code[16];
    CompanyInfo_PhoneNo: Text[30];
    CompanyInfo_EMail: Text[80];
    CompanyInfo_HomePage: Text[255];
    ECOText_: text[100];
    NewSalespersonTxt: text;
    NewExternalDocumentNoTxt: Text;
    NewYourReferenceTxt: Text;
    NewPackageTrackingNoTxt: Text;
    PaymentID_: Text;
    DocumentReferenceTxt: text;
    PaymentIDTxt: Text;
    PaymentTxt: text;
    LiterCapt: array[20]of Text[100];
    EmptyCPMOCRReferenceType: Boolean;
    NoOfLitreLbl: Label 'Quantity in liters', comment = 'DAN="Mængde i liter"';
    NewSalespersonLbl: Label 'Our Reference', comment = 'DAN="Vores reference"';
    NewExternalDocumentNoLbl: Label 'Your Rekv. No.', comment = 'DAN="Deres rekv. nr."';
    NewYourReferenceLbl: Label 'Your Reference', comment = 'DAN="Deres reference"';
    NewPackageTrackingNoLbl: Label 'Tracking No.', comment = 'DAN="Trackingnr."';
    DocumentReferenceCaptionLbl: Label 'If your bank supports FIK (Danish bank standard), then use the following information:', comment = 'DAN="Hvis banken understøtter FIK (dansk bankstandard), skal du bruge følgende oplysninger:"';
    PaymentID_Lbl: Label 'Payment ID', comment = 'DAN="FIK-kode"';
    PaymentTxt1_Lbl: Label 'Payment via Payment Service', comment = 'DAN="Trækkes via betalingsservice"';
    PaymentTxt2_Lbl: Label 'Payment via juuls.dk', comment = 'DAN="Betalt via juuls.dk"';
}
