/// <summary>
/// Report CST Juuls Item GTIN Label (ID 50010).
/// </summary>
report 50010 "CST Juuls Item GTIN Label"
{
    UsageCategory = Tasks;
    ApplicationArea = All;
    Caption = 'Juuls Item GTIN Label';
    WordMergeDataItem = Items;
    DefaultRenderingLayout = Word;

    dataset
    {
        dataitem(Items; Item)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Items';

            // Column that provides the data string for the barcode
            column(No_; "No.")
            {
            }
            column(Description; ItemDesc)
            {
            }
            column(Base_Unit_of_Measure; "Base Unit of Measure")
            {
            }
            column(Unit_Price_Label; FieldCaption("Unit Price"))
            {
            }
            column(Unit_Price; UnitPriceInclVAT)
            {
            }
            column(Alcohol_Pct_Label; FieldCaption("Alcohol%"))
            {
            }
            column(Alcohol_Pct; "Alcohol%")
            {
            }
            column(Age_Year_Label; FieldCaption("Age(Year)"))
            {
            }
            column(Age_Year_; "Age(Year)")
            {
            }
            column(Vintage_Label; FieldCaption(Vintage))
            {
            }
            column(Vintage; Vintage)
            {
            }
            column(Producer_Label; FieldCaption(Producer))
            {
            }
            column(Producer; Producer)
            {
            }
            column(GTIN; GTINBarCode)
            {
            }
            column(GTIN_2D; GTINQRCode)
            {
            }

            trigger OnAfterGetRecord()
            var
                BarcodeString: Text;
                BarcodeFontProvider: Interface "Barcode Font Provider";
                BarcodeFontProvider2D: Interface "Barcode Font Provider 2D";

            begin
                UnitPriceInclVAT := Round(CalculateUnitPriceInclVAT(Items), 0.01, '=');

                ItemDesc := Description;
                if ItemDesc = '' then
                    ItemDesc := "Description 2";

                GTINWorkCode := GetGTINWorkCode();

                // Declare the barcode provider using the barcode provider interface and enum
                BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeFontProvider2D := Enum::"Barcode Font Provider 2D"::IDAutomation2D;

                // Set data string source 
                if GTINWorkCode <> '' then begin
                    BarcodeString := GTINWorkCode;
                    // Validate the input
                    BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                    // Encode the data string to the barcode font
                    GTINBarCode := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
                    GTINQRCode := BarcodeFontProvider2D.EncodeFont(BarcodeString, BarcodeSymbology2D);
                end
            end;

        }
    }
    rendering
    {
        layout(Word)
        {
            Type = Word;
            LayoutFile = './Report/Layout/Word_Juuls_Item_Label.docx';
        }
    }

    trigger OnInitReport()
    begin
        BarcodeSymbology := Enum::"Barcode Symbology"::Code39;
        BarcodeSymbology2D := Enum::"Barcode Symbology 2D"::"QR-Code";

        VATPct := GetVATPercent();
        if VATPct = 0 then
            if not Confirm(NoVATPostingSetupFoundQst, false) then
                Error(NoVATPostingSetupFoundErr);
    end;

    local procedure CalculateUnitPriceInclVAT(ItemRec: Record Item): Decimal

    begin
        exit(ItemRec."Unit Price" + (ItemRec."Unit Price" * VATPct / 100));
    end;

    local procedure GetVATPercent(): Decimal
    var
        VATPostingSetup: Record "VAT Posting Setup";

    begin
        VATPostingSetup.SetFilter("VAT Bus. Posting Group", '%1|%2|%3', 'INDLAND', 'DOMESTIC', '');
        VATPostingSetup.SetRange("VAT Identifier", 'NORMAL');
        VATPostingSetup.SetFilter("VAT %", '<>%1', 0);
        if VATPostingSetup.FindFirst() then
            exit(VATPostingSetup."VAT %");

        exit(0);
    end;

    local procedure GetGTINWorkCode(): Code[14]
    var
        ItemRef: Record "Item Reference";
        ItemRefType: Enum "Item Reference Type";

    begin
        if Items.GTIN <> '' then
            exit(Items.GTIN);

        ItemRef.SetRange("Item No.", Items."No.");
        ItemRef.SetFilter("Unit of Measure", '%1|%2', Items."Base Unit of Measure", '');
        ItemRef.SetRange("Reference Type", ItemRefType::"Bar Code");
        ItemRef.SetFilter("Reference No.", '<>%1');
        if ItemRef.FindLast() then
            exit(CopyStr(ItemRef."Reference No.", 1, MaxStrLen(GTINWorkCode)));

        exit('');
    end;

    var
        UnitPriceInclVAT: Decimal;
        VATPct: Decimal;
        BarcodeSymbology: Enum "Barcode Symbology";
        BarcodeSymbology2D: Enum "Barcode Symbology 2D";
        ItemDesc: Text;
        GTINBarCode: Text;
        GTINQRCode: Text;
        GTINWorkCode: Code[14];
        NoVATPostingSetupFoundQst: Label 'No VAT percentage found for domestic normal VAT. Do you want to proceed?', Comment = 'Confirmation message when no VAT Posting Setup is found.';
        NoVATPostingSetupFoundErr: Label 'No VAT percentage found for domestic normal VAT. Please set up VAT Posting Setup correctly before proceeding.', Comment = 'Error message when no VAT Posting Setup is found.';
}
