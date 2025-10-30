/// <summary>
/// Page CST Pre-Selected Price List (ID 50013).
/// </summary>
page 50013 "CST Pre-Selected Price List"
{
    Caption = 'Pre-Selected Price Lines', Comment = 'Lists pre-selected price lines for customers, customer price groups or vendors.';
    PageType = List;

    SourceTable = "CSTPreSelectedPriceLines";
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Price List Code"; Rec."Price List Code")
                {
                    ToolTip = 'Specifies the price list to which the pre-selected price line belongs.';
                    Visible = true;
                }
                field("Source Group"; Rec."Source Group")
                {
                    ToolTip = 'Specifies the source group of the price line.';
                    Visible = false;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ToolTip = 'Specifies whether the price line is assigned to a customer, customer price group, or vendor.';
                    Visible = true;
                }
                field("Source No."; Rec."Source No.")
                {
                    ToolTip = 'Specifies the customer, customer price group, or vendor to which the price line applies.';
                    Visible = true;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description of the item to which the price line applies.';
                    Visible = true;
                }
                field(Active; Rec.Active)
                {
                    ToolTip = 'Indicates whether the pre-selected price line is active.';
                    Visible = true;
                }
            }
        }
    }
}