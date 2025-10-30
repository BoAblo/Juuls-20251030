Report 50098 "POS - VAT Correction"
{
    //Permissions = tabledata "G/L Entry" = rmid;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'POS - VAT Correction', comment = 'DAN="POS - Momskorrektion"';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "No.";
            DataItemTableView = where("Document Type"=const(Invoice), "Sell-to Customer No."=filter('0010'), "POS - VAT Correction"=filter(false));

            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type"=field("Document Type"), "Document No."=field("No.");
                DataItemTableView = where(Type=const(Item), "POS - VAT Correction"=filter(false));

                trigger OnAfterGetRecord()
                begin
                    validate("Unit Price", "Unit Price" + ("Unit Price" * "VAT %" / 100));
                    "POS - VAT Correction":=true;
                    modify(true);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                "POS - VAT Correction":=true;
                modify(true);
            end;
        }
    }
    trigger OnPostReport()
    begin
        message(format(i));
    end;
    var i: Integer;
}
