pageextension 50002 "CST Item List Ext" extends "Item List"
{
    layout
    {
        addafter(Description)
        {
            field("Alcohol%"; Rec."Alcohol%")
            {
                ApplicationArea = All;
                ToolTip = 'ToolTip';
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
        }
        addafter("Unit Cost")
        {
            field("1ENGROS 1"; Rec."1ENGROS 1")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the 1ENGROS 1 field.', Comment = '%';
            }
            field("2ENGROS 2"; Rec."2ENGROS 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the 2ENGROS 2 field.', Comment = '%';
            }
            field("3DETAIL"; Rec."3DETAIL")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the 3DETAIL field.', Comment = '%';
            }
        }
        addafter("Vendor No.")
        {
            field("Product Type"; Rec."Product Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Product Type field.', Comment = 'DAN="Produkt type"';
            }
            field("Organic Item"; Rec."Organic Item")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Organic Item field.', Comment = 'DAN="Økologisk vare"';
            }
            field(Natural; Rec.Natural)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Natural field.', Comment = 'DAN="Naturvin"';
            }
            field(Biodynamic; Rec.Biodynamic)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Biodynamic field.', Comment = 'DAN="Biodynamisk"';
            }
            field("Own Item"; Rec."Own Item")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Own Item field.', Comment = 'DAN="Egen vare"';
            }
            field(Country; Rec.Country)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Country field.', Comment = 'DAN="Land"';
            }
            field("Deposit Code"; Rec."Deposit Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Deposit Code field.', Comment = 'DAN="Pantkode"';
            }
        }
    }
    actions
    {
        addafter("Revaluation Journal")
        {
            action(SalesPriceChangelog)
            {
                Caption = 'Sales Price Changelog', comment = 'DAN="Salgspris - ændringslog"';
                ApplicationArea = All;
                Ellipsis = true;
                ToolTip = 'Sales Price Changelog';
                Image = ChangeLog;
                RunObject = Page "CST - Sales Price Changelog";
            }
            //>>TEMP HCH
            action("Update Item Ref")
            {
                ApplicationArea = all;
                Caption = 'Update Item Ref', Comment = 'DAN="Update Item Ref"';
                ToolTip = 'Update Item Ref', Comment = 'DAN="Update Item Ref"';
                Image = Import;
                RunObject = XMLport "Update Item Ref";
            }
        //<<TEMP HCH
        }
        addafter(ShowLog_Promoted)
        {
            actionref(SalesPriceChangelogPromoted; SalesPriceChangelog)
            {
            }
        }
    }
}
