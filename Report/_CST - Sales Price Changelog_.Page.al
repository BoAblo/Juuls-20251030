page 50020 "CST - Sales Price Changelog"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Sales Price - Change Log Entries', Comment = 'DAN="Salgspris - ændringslog"';
    Editable = false;
    PageType = List;
    SourceTable = "Change Log Entry";
    SourceTableView = where("Field Log Entry Feature"=filter("Change Log"|All), "Table No."=const(7001));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                //ShowCaption = false;
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
                    Visible = false;
                }
                field("Date and Time"; Rec."Date and Time")
                {
                    Caption = 'Dato og tidspunkt';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date and time when this change log entry was created.';
                }
                field("User ID"; Rec."User ID")
                {
                    Caption = 'Bruger-id';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the ID of the user who posted the entry, to be used, for example, in the change log.';

                    trigger OnDrillDown()
                    var
                        UserMgt: Codeunit "User Management";
                    begin
                        UserMgt.DisplayUserInformation(Rec."User ID");
                    end;
                }
                field(ItemNo; FindItemNo(rec."Primary Key Field 1 Value", rec."Primary Key Field 2 Value"))
                {
                    Caption = 'Varenr.';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the table containing the changed field.';
                }
                field(ItemDescription; FindItemDescription(rec."Primary Key Field 1 Value", rec."Primary Key Field 2 Value"))
                {
                    Caption = 'Beskrivelse';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the table containing the changed field.';
                }
                field("Field Caption"; Rec."Field Caption")
                {
                    Caption = 'Felttitel';
                    ApplicationArea = Basic, Suite;
                    DrillDown = false;
                    ToolTip = 'Specifies the field caption of the changed field.';
                }
                field("Type of Change"; Rec."Type of Change")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the type of change made to the field.';
                }
                field("Old Value"; Rec."Old Value")
                {
                    Caption = 'Gammel værdi';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value that the field had before a user made changes to the field.';
                }
                field("New Value"; Rec."New Value")
                {
                    Caption = 'Ny værdi';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value that the field had after a user made changes to the field.';
                }
            }
        }
    }
    procedure FindItemNo(PrimaryKeyField1Value: Text[50]; PrimaryKeyField2Value: Text[50]): Code[20]var
        PriceListLine: Record "Price List Line";
        LineNo: Integer;
    begin
        Evaluate(LineNo, PrimaryKeyField2Value);
        PriceListLine.setrange("Price List Code", PrimaryKeyField1Value);
        PriceListLine.setrange("Line No.", LineNo);
        IF PriceListLine.FindFirst()then exit(PriceListLine."Asset No.");
        exit('');
    end;
    procedure FindItemDescription(PrimaryKeyField1Value: Text[50]; PrimaryKeyField2Value: Text[50]): Text[100]var
        PriceListLine: Record "Price List Line";
        Item: Record Item;
        LineNo: Integer;
    begin
        Evaluate(LineNo, PrimaryKeyField2Value);
        PriceListLine.setrange("Price List Code", PrimaryKeyField1Value);
        PriceListLine.setrange("Line No.", LineNo);
        IF PriceListLine.FindFirst()then IF Item.get(PriceListLine."Asset No.")then exit(Item.Description);
        Exit('');
    end;
}
