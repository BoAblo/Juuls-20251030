pageextension 50009 CSTPriceWorksSheetExt extends "Price Worksheet"
{
    layout
    {
        addafter(Status)
        {
            field("CST PriceList Group"; Rec."CST Price List Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CST PriceList Group field.';
            }
        }
    }
}
