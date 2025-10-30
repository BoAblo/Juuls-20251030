report 50009 "CST - Tax Reporting"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Report/layout/JuulsTaxReporting.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Tax Reporting', comment = 'DAN="Afgiftsindberetning"';

    dataset
    {
        dataitem(Duty; Duty)
        {
            //RequestFilterFields = "Code", "Duty Type", "Journal No. Filter", "Date Filter";
            column(Afg_Kode; Duty.Code)
            {
            }
            column(Afg_Beskrivelse; Duty.Description)
            {
            }
            column(Afg_Agregningsart; Duty."Duty Type")
            {
            }
            column("Afg_Afgiftsbeløb"; Duty."Duty Amount")
            {
            }
            column(Enheder; Enheder) //Altid positiv
            {
            }
            column(Stam_Navn; DutySetup.Name)
            {
            }
            column(Stam_Adr1; Adr[1])
            {
            }
            column(Stam_Adr2; Adr[2])
            {
            }
            column(Stam_Adr3; Adr[3])
            {
            }
            column(Stam_Reg; DutySetup."Registration No.")
            {
            }
            column(Stam_EksportNo; DutySetup."Export Registration No.")
            {
            }
            column(Stam_Tlf; CompanyInfo."Phone No.")
            {
            }
            column(Stam_Fax; CompanyInfo."Telex No.")
            {
            }
            column(PeriodeAfg; PeriodeAfgrænsning)
            {
            }
            column(ThisDate; FORMAT(ThisDate))
            {
            }
            trigger OnAfterGetRecord()
            var
                DutyEntry: Record "Duty Entry";
                DutyGroupLine: Record "Duty Group Line";
                SalesUnit: Decimal;
                PurchUnit: Decimal;
            begin
                CALCFIELDS("Duty Amount");
                CalcFields("Contents (Sales)", "Alcohol Contents (Sales)", "Net Weight (Sales)");
                CalcFields("Contents (Purchase)", "Alcohol Contents (Purchase)", "Net Weight (Purchase)");
                CASE "Duty Type" OF "Duty Type"::Unit: begin
                    Enheder:=0;
                    SalesUnit:=0;
                    PurchUnit:=0;
                    DutyEntry.setrange("Duty Code", "Code");
                    DutyEntry.setfilter("Currency Code", "Currency Filter");
                    DutyEntry.setfilter("Posting Date", GetFilter("Posting Date Filter"));
                    DutyEntry.setfilter(Open, GetFilter("Open Filter"));
                    DutyEntry.setfilter("Duty Register No.", GetFilter("Duty Register No. Filter"));
                    DutyEntry.setrange("Duty Entry Type", "Duty Entry Type"::Sale);
                    DutyEntry.setrange("Duty Free", false);
                    if DutyEntry.FindSet()then repeat DutyGroupLine.reset();
                            DutyGroupLine.setrange("Duty Group Code", DutyEntry."Duty Group Code");
                            DutyGroupLine.setrange("Duty Entry Type", "Duty Entry Type"::Sale);
                            if DutyGroupLine.FindFirst()then if DutyGroupLine.Quantity <> 0 then SalesUnit:=SalesUnit + (DutyEntry.Quantity * DutyGroupLine.Quantity);
                        until DutyEntry.next() = 0;
                    DutyEntry.setrange("Duty Entry Type", "Duty Entry Type"::Purchase);
                    if DutyEntry.FindSet()then repeat DutyGroupLine.reset();
                            DutyGroupLine.setrange("Duty Group Code", DutyEntry."Duty Group Code");
                            DutyGroupLine.setrange("Duty Entry Type", "Duty Entry Type"::Purchase);
                            if DutyGroupLine.FindFirst()then if DutyGroupLine.Quantity <> 0 then PurchUnit:=PurchUnit + (DutyEntry.Quantity * DutyGroupLine.Quantity);
                        until DutyEntry.next() = 0;
                    Enheder:=PurchUnit - SalesUnit;
                end;
                "Duty Type"::Liter: Enheder:="Contents (Purchase)" - "Contents (Sales)";
                "Duty Type"::Alcohol: Enheder:="Alcohol Contents (Purchase)" - "Alcohol Contents (Sales)";
                "Duty Type"::"Net Weight": Enheder:="Net Weight (Purchase)" - "Net Weight (Sales)" END;
                Enheder:=ROUND(Enheder);
                "Duty Amount":=ROUND("Duty Amount");
            end;
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
        CompanyInfo.get();
        DutySetup.GET();
        Adr[1]:=DutySetup.Name;
        Adr[2]:=DutySetup."Name 2";
        Adr[3]:=DutySetup.Address;
        Adr[4]:=DutySetup."Address 2";
        Adr[5]:=DutySetup.Postcode + ' ' + DutySetup.City;
        COMPRESSARRAY(Adr);
        PeriodeAfgrænsning:=Duty.GETFILTER("Posting Date Filter");
        IF(PeriodeAfgrænsning = '')THEN PeriodeAfgrænsning:='<Ingen>';
        PeriodeAfgrænsning:='Periode : ' + PeriodeAfgrænsning;
        ThisDate:=TODAY;
    end;
    var DutySetup: Record "Duty Setup";
    CompanyInfo: Record "Company Information";
    Adr: array[5]of Text[100];
    "PeriodeAfgrænsning": Text;
    Enheder: Decimal;
    ThisDate: Date;
}
