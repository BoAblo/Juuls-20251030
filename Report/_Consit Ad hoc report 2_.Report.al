report 50091 "Consit Ad hoc report 2"
{
    DefaultLayout = RDLC;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Consit Ad hoc report uden layout';
    Permissions = tabledata "Item Ledger Entry"=rm,
        tabledata "Item Application Entry"=rmd;
    ProcessingOnly = true;

    dataset
    {
        //Trin I
        // dataitem(ItemLedgerEntryOpen; "Item Ledger Entry")
        // {
        //     RequestFilterFields = "Entry No.";
        //     DataItemTableView = where("Entry No." = filter('22640|23102|29866|33214|33213|41811'));
        //     trigger OnAfterGetRecord()
        //     begin
        //         "Remaining Quantity" := 0;
        //         Open := false;
        //         Modify();
        //     end;
        // }
        dataitem(ItemLedgerEntryClosed; "Item Ledger Entry")
        {
            RequestFilterFields = "Entry No.";
            //DataItemTableView = where("Entry No." = filter('29883|29882|22641|23115|23116|23117|23118|23119|22996|33300|33301|33302|33288|33287|29880|29879|29867|33216|33215|41568|47994|47993|50491|50490'));
            DataItemTableView = where("Entry No."=filter('47994|47993|50491|50490|50494|50493'));

            trigger OnAfterGetRecord()
            begin
                case "Entry No." of // 29883:
                //     "Remaining Quantity" := 12;
                // 29882:
                //     "Remaining Quantity" := 60;
                // 22641:
                //     "Remaining Quantity" := 54;
                // 23115:
                //     "Remaining Quantity" := 360;
                // 23116:
                //     "Remaining Quantity" := 24;
                // 23117:
                //     "Remaining Quantity" := 24;
                // 23118:
                //     "Remaining Quantity" := 24;
                // 23119:
                //     "Remaining Quantity" := 24;
                // 22996:
                //     "Remaining Quantity" := 60;
                // 33300:
                //     "Remaining Quantity" := 30;
                // 33301:
                //     "Remaining Quantity" := 6;
                // 33302:
                //     "Remaining Quantity" := 24;
                // 33288:
                //     "Remaining Quantity" := 2400;
                // 33287:
                //     "Remaining Quantity" := 600;
                // 29880:
                //     "Remaining Quantity" := 12;
                // 29879:
                //     "Remaining Quantity" := 6;
                // 29867:
                //     "Remaining Quantity" := 4;
                // 33216:
                //     "Remaining Quantity" := 1152;
                // 33215:
                //     "Remaining Quantity" := 1152;
                // 41568:
                //     "Remaining Quantity" := 60;
                47994: "Remaining Quantity":=6;
                47993: "Remaining Quantity":=60;
                50491: "Remaining Quantity":=12;
                50490: "Remaining Quantity":=60;
                50494: "Remaining Quantity":=6;
                50493: "Remaining Quantity":=12;
                end;
                Open:=true;
                Modify();
            end;
        }
        dataitem("Item Application Entry"; "Item Application Entry")
        {
            RequestFilterFields = "Entry No.";
            //DataItemTableView = where("Entry No." = filter('29770|29768|22695|23168|23170|23172|23174|23176|23046|33113|33115|33117|33100|33098|29765|29763|29755|33029|33027|41144||'));
            DataItemTableView = where("Entry No."=filter('47467|47465|49938|49936|49943|49941'));

            trigger OnAfterGetRecord()
            begin
                Delete();
            end;
        }
    }
}
