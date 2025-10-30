page 50016 "CST Product Type"
{
    Caption = 'Product Type', Comment = 'DAN="Produkt typer"';
    PageType = List;
    SourceTable = "CST Product Type";
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Product Type"; rec."Product Type")
                {
                    ToolTip = ' ';
                }
                field(Description; rec.Description)
                {
                    ToolTip = ' ';
                }
            }
        }
    }
    actions
    {
    }
}
