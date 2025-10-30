reportextension 50000 "CST Sales - Shipment" extends "Standard Sales - Shipment"
{
    dataset
    {
        add(Header)
        {
            column(BankBranchNo_CompanyInfo; CompanyInfo."Bank Branch No.")
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
            column(CompanyBankAccount_IBANEURO; Companyinfo."IBAN (EURO)")
            {
            }
            column(CompanyBankAccount_IBANEUROLbl; CompanyInfo.FieldCaption("IBAN (EURO)"))
            {
            }
            column(Customer_PhoneNoCpt; Customer_PhoneNoTxt)
            {
            }
            column(Customer_EMailCpt; Customer_EMailTxt)
            {
            }
            column(Customer_PhoneNo; Customer."Phone No.")
            {
            }
            column(Customer_EMail; Customer."E-Mail")
            {
            }
            column(EtanolPct_Lbl; Item.FieldCaption("Alcohol%"))
            {
            }
            column(AgeYear_Lbl; Item.FieldCaption("Age(Year)"))
            {
            }
            column(DocPicture; CompanyInfo.DocPicture)
            {
            }
        }
        modify(Header)
        {
        trigger OnAfterAfterGetRecord()
        begin
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
            Customer_EMailTxt:='';
            IF Customer."E-Mail" <> '' then Customer_EMailTxt:=Customer_EMail_Lbl;
            Customer_PhoneNoTxt:='';
            IF Customer."Phone No." <> '' then Customer_PhoneNoTxt:=Customer_PhoneNo_Lbl;
        end;
        }
        add(Line)
        {
            column(EtanolPct; Item."Alcohol%")
            {
            }
            column(AgeYear; Item."Age(Year)")
            {
            }
        }
        modify(Line)
        {
        trigger OnAfterAfterGetRecord()
        begin
            clear(Item);
            if Line.Type = Line.type::Item then if Item.get(Line."No.")then;
        end;
        }
    }
    rendering
    {
        layout("JuulsSalesShipmentDiffLogo.rdlc")
        {
            Type = RDLC;
            LayoutFile = './ReportExt/layout/JuulsSalesShipmentDiffLogo.rdlc';
            Caption = 'Juul´s Engros Sales Shipment - Diff. Logo', comment = 'DAN="Juul´s Engros leverance - Diff. Logo"';
            Summary = 'Juul´s Engros Sales - Shipment is a customized layout for Juul´s Engros.';
        }
    }
    var Customer: Record Customer;
    Item: Record Item;
    CompanyInfo_PhoneNo: Text[30];
    CompanyInfo_EMail: Text[80];
    CompanyInfo_HomePage: Text[255];
    Customer_EMailTxt: text[250];
    Customer_PhoneNoTxt: Text[250];
    Customer_EMail_Lbl: Label 'Mail', comment = 'DAN="Mailadresse"';
    Customer_PhoneNo_Lbl: Label 'Phone No.', comment = 'DAN="Telefonnr."';
}
