report 50001 "CST Import Sales From Magasin"
{
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Import Sales From Magasin', comment = 'DAN="Indlæsning af salg fra Magasin"';

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(ExcelOptions)
                {
                    Caption = 'Excel Import Options', comment = 'DAN="Indstillinger"';

                    field(ServerFileName; FileName)
                    {
                        ApplicationArea = All;
                        AssistEdit = true;
                        Editable = false;
                        Caption = 'Select and import Excel File...', comment = 'DAN="Vælg og indlæs Excel fil"';
                        ToolTip = 'Select the Excel file to import!';

                        trigger OnAssistEdit()
                        begin
                            FileName:=FileManagement.BLOBImportWithFilter(TempBlob, Text007Lbl, FileName, ExcelFileExtensionTok2Lbl, ExcelFileExtensionTok2Lbl);
                            FileExt:=FileManagement.GetExtension(FileName);
                            if(FileName = '') or (not TempBlob.HasValue()) or (not(LowerCase(FileExt)in['xlsx', 'xls', 'csv']))then begin
                                FileName:='';
                                Error(FileNameErr);
                            end;
                        end;
                    }
                    field(SheetNameField; SheetName)
                    {
                        Caption = 'Excel Sheet Name', comment = 'DAN="Excel fane"';
                        ApplicationArea = All;
                        Editable = false;
                        ToolTip = 'Select the sheet name from the Excel Sheet name to import.';

                        trigger OnAssistEdit()
                        begin
                            // Select sheet from the excel file
                            if(FileName = '') or (not TempBlob.HasValue())then Error(FileNameErr);
                            TempBlob.CreateInStream(FileInStream);
                            SheetName:=TempExcelBuffer.SelectSheetsNameStream(FileInStream);
                        end;
                    }
                    field(Description; Desc)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Description', comment = 'DAN="Beskrivelse"';
                        ToolTip = 'Specifies a description of the Magasin imported records.';
                    }
                    field(ShowDeveloperMessages; ShowDeveloperMessageYesNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Developer Messages', comment = 'DAN="Vis udviklerbeskeder"';
                        ToolTip = 'Specifies whether to show developer messages during the import process.';
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnOpenPage()
        var
            Cust: Record Customer;
        begin
            Clear(TempExcelBuffer);
            SalesSetup.Get();
            if SalesSetup."CST Magasin Customer No." = '' then Error(MagasinCustomerNoErr);
            Cust.Get(SalesSetup."CST Magasin Customer No.");
            if Cust.Blocked <> Cust.Blocked::" " then Cust.FieldError("Blocked");
            Clear(TempBlob);
            Clear(FileInStream);
            FileName:='';
            SheetName:='';
            Desc:=StrSubstNo(Text006Lbl, Format(WorkDate()));
            ShowDeveloperMessageYesNo:=false;
        end;
    }
    trigger OnInitReport()
    begin
    end;
    trigger OnPreReport()
    var
        TempSalesHeader: Record "Sales Header" temporary;
        TempSalesLine: Record "Sales Line" temporary;
    begin
        // Open selected sheet
        ErrorMessage:=TempExcelBuffer.OpenBookStream(FileInStream, SheetName);
        if ErrorMessage <> '' then Error(ErrorMessage);
        TempExcelBuffer.ReadSheetContinous(SheetName, true);
        AnalyzeData(TempSalesHeader, TempSalesLine);
        CreateSalesDocs(TempSalesHeader, TempSalesLine);
        TotalRecNo:=TempSalesLine.Count();
    end;
    trigger OnPostReport()
    begin
        TempExcelBuffer.SetRange("Row No.");
        TempExcelBuffer.SetRange("Column No.");
        if not TempExcelBuffer.IsEmpty()then TempExcelBuffer.DeleteAll();
        if GuiAllowed then Message(Text005Lbl, Format(TotalRecNo));
    end;
    local procedure AnalyzeData(var TempSalesHeader: Record "Sales Header" temporary; var TempSalesLine: Record "Sales Line" temporary)
    var
        NextRec: Boolean;
    begin
        Qty:=0;
        PostType:='';
        PostingDate:=0D;
        if GuiAllowed then begin
            Window.Open(Text001Lbl + Text002Lbl);
            Window.Update(1, Text003Lbl);
            Window.Update(2, 0);
        end;
        // Skip header row and only check relevant columns (6 through 19)
        TempExcelBuffer.SetFilter("Row No.", '>%1', 5);
        TempExcelBuffer.SetRange("Column No.", 2);
        if TempExcelBuffer.IsEmpty()then Error(FileNameErr);
        TotalRecNo:=TempExcelBuffer.Count();
        TempExcelBuffer.SetRange("Column No.", 2, 19);
        RecNo:=0;
        if TempExcelBuffer.FindSet()then repeat if TempExcelBuffer."Column No." = 2 then begin
                    RecNo:=RecNo + 1;
                    if GuiAllowed then Window.Update(2, Round(RecNo / TotalRecNo * 10000, 1));
                end;
                case true of // Posting Date
                TempExcelBuffer."Column No." = 2: begin
                    if not Evaluate(PostingDate, TempExcelBuffer."Cell Value as Text")then TempSalesLine.FieldError(TempSalesLine."Posting Date");
                    // Insert Temp Sales Header and Temp Sales Line
                    InsertValuesToTempSalesLines(TempExcelBuffer, TempSalesHeader, TempSalesLine, 0);
                    // Posting Date
                    InsertValuesToTempSalesLines(TempExcelBuffer, TempSalesHeader, TempSalesLine, 2);
                    NextRec:=TempExcelBuffer.Next() <> 0;
                    if not NextRec then Error(FileNameErr);
                    if not Evaluate(PostType, TempExcelBuffer."Cell Value as Text")then PostType:='';
                end;
                // Description
                TempExcelBuffer."Column No." = 9: InsertValuesToTempSalesLines(TempExcelBuffer, TempSalesHeader, TempSalesLine, 9);
                // Item No.
                TempExcelBuffer."Column No." = 10: InsertValuesToTempSalesLines(TempExcelBuffer, TempSalesHeader, TempSalesLine, 10);
                // Bar Code
                TempExcelBuffer."Column No." = 13: InsertValuesToTempSalesLines(TempExcelBuffer, TempSalesHeader, TempSalesLine, 13);
                // Sales Amount Incl. VAT
                TempExcelBuffer."Column No." = 14: InsertValuesToTempSalesLines(TempExcelBuffer, TempSalesHeader, TempSalesLine, 14);
                // Sales VAT Amount
                TempExcelBuffer."Column No." = 15: InsertValuesToTempSalesLines(TempExcelBuffer, TempSalesHeader, TempSalesLine, 15);
                // Sales Amount Excl. VAT
                TempExcelBuffer."Column No." = 16: InsertValuesToTempSalesLines(TempExcelBuffer, TempSalesHeader, TempSalesLine, 16);
                // Line Discount Amount
                TempExcelBuffer."Column No." = 17: InsertValuesToTempSalesLines(TempExcelBuffer, TempSalesHeader, TempSalesLine, 17);
                // Quantity
                TempExcelBuffer."Column No." = 18: begin
                    InsertValuesToTempSalesLines(TempExcelBuffer, TempSalesHeader, TempSalesLine, 18);
                    InsertValuesToTempSalesLines(TempExcelBuffer, TempSalesHeader, TempSalesLine, 9999);
                end;
                end;
            until TempExcelBuffer.Next() = 0;
    end;
    local procedure InsertValuesToTempSalesLines(TempExcelBuffer2: Record "Excel Buffer" temporary; var TempSalesHeader: Record "Sales Header" temporary; var TempSalesLine: Record "Sales Line" temporary; ActionNumber: Integer)
    var
        CreateNewSalesHeader: Boolean;
    begin
        case ActionNumber of 0: // Init TempSalesLine
 begin
            // Look for existing TempSalesHeader
            TempSalesHeader.SetFilter("No.", '%1', 'TEMP-MAGASIN-*');
            TempSalesHeader.SetRange("Document Type", TempSalesHeader."Document Type"::Order);
            TempSalesHeader.SetRange("Posting Date", PostingDate);
            TempSalesHeader.SetRange(Status, TempSalesHeader.Status::Open);
            CreateNewSalesHeader:=not TempSalesHeader.FindFirst();
            // Remove any existing filters
            TempSalesHeader.SetRange("No.");
            TempSalesHeader.SetRange("Document Type");
            TempSalesHeader.SetRange("Posting Date");
            TempSalesHeader.SetRange(Status);
            if CreateNewSalesHeader then begin
                // If not found, create a new TempSalesHeader
                TempSalesHeader.Init();
                TempSalesHeader."Document Type":=TempSalesHeader."Document Type"::Order;
                if TempSalesHeader.IsEmpty()then TempSalesHeader.Validate("No.", 'TEMP-MAGASIN-001')
                else
                    TempSalesHeader.Validate("No.", IncStr(TempSalesHeader."No."));
                TempSalesHeader.Validate("Sell-to Customer No.", SalesSetup."CST Magasin Customer No.");
                TempSalesHeader.Validate("Posting Date", PostingDate);
                TempSalesHeader.Validate("Order Date", PostingDate);
                TempSalesHeader.Validate("Prices Including VAT", SalesSetup."CST Magasin Set Prices InclVAT");
                TempSalesHeader.Insert();
            end;
            TempSalesHeader.SetHideValidationDialog(true);
            // Initialize TempSalesLine
            TempSalesLine.Init();
            TempSalesLine.SetHideValidationDialog(true);
            TempSalesLine.SetSalesHeader(TempSalesHeader);
            TempSalesLine."Line No.":=TempSalesLine."Line No." + 1;
            TempSalesLine."Document Type":=TempSalesHeader."Document Type";
            TempSalesLine."Document No.":=TempSalesHeader."No.";
            RecNo+=1;
        end;
        2: // Posting Date
 if not Evaluate(TempSalesLine."Posting Date", TempExcelBuffer2."Cell Value as Text")then begin
                TempSalesLine.FieldError("Posting Date");
                TempSalesLine."Posting Date":=TempSalesHeader."Posting Date";
            end;
        9: // Description
 TempSalesLine."Description":=CopyStr(TempExcelBuffer2."Cell Value as Text", 1, MaxStrLen(TempSalesLine."Description"));
        10: // Item No.
 begin
            TempSalesLine.Type:=TempSalesLine.Type::Item;
            TempSalesLine."No.":=CopyStr(TempExcelBuffer2."Cell Value as Text", 1, MaxStrLen(TempSalesLine."No."));
        end;
        13: //  Bar Code
 TempSalesLine."Item Reference No.":=CopyStr(TempExcelBuffer2."Cell Value as Text", 1, MaxStrLen(TempSalesLine."Item Reference No."));
        14: // Amount Including VAT
 if not Evaluate(TempSalesLine."Amount Including VAT", TempExcelBuffer2."Cell Value as Text")then TempSalesLine.FieldError("Amount Including VAT");
        15: // VAT Base Amount
 if not Evaluate(TempSalesLine."VAT Base Amount", TempExcelBuffer2."Cell Value as Text")then TempSalesLine.FieldError("VAT Base Amount");
        16: // Amount
 if not Evaluate(TempSalesLine."Amount", TempExcelBuffer2."Cell Value as Text")then TempSalesLine.FieldError("Amount");
        17: // Line Discount Amount
 if not Evaluate(TempSalesLine."Line Discount Amount", TempExcelBuffer2."Cell Value as Text")then TempSalesLine.FieldError("Line Discount Amount");
        18: // Quantity
 if not Evaluate(TempSalesLine."Quantity", TempExcelBuffer2."Cell Value as Text")then begin
                TempSalesLine.FieldError("Quantity");
                if TempSalesLine.Quantity <> 0 then case TempSalesHeader."Prices Including VAT" of false: TempSalesLine."Unit Price":=TempSalesLine.Amount / TempSalesLine.Quantity;
                    true: TempSalesLine."Unit Price":=TempSalesLine."Amount Including VAT" / TempSalesLine.Quantity;
                    end;
            end;
        9999: // Insert TempSalesLine
 TempSalesLine.Insert();
        end;
    end;
    local procedure CreateSalesDocs(var TempSalesHeader: Record "Sales Header" temporary; var TempSalesLine: Record "Sales Line" temporary): Boolean var
        DepositCode: Record "CST Deposit Code";
    begin
        if TempSalesHeader.IsEmpty()then exit(false);
        RecNo:=0;
        TotalRecNo:=TempSalesHeader.Count();
        if GuiAllowed then begin
            Window.Update(1, Text004Lbl);
            Window.Update(2, 0);
        end;
        if TempSalesHeader.FindSet()then begin
            Clear(CreateMagasinSalesDoc);
            CreateMagasinSalesDoc.SetShowDeveloperMessageYesNo(ShowDeveloperMessageYesNo);
            repeat RecNo+=1;
                if GuiAllowed then Window.Update(2, Round(RecNo / TotalRecNo * 10000, 1));
                CreateMagasinSalesDoc.CreateSalesHeader(SalesHeader, TempSalesHeader."Document Type", SalesSetup."CST Magasin Customer No.", PostingDate, TempSalesHeader."Prices Including VAT");
                TempSalesLine.SetRange("Document Type", TempSalesHeader."Document Type");
                TempSalesLine.SetRange("Document No.", TempSalesHeader."No.");
                if TempSalesLine.FindSet()then CreateMagasinSalesDoc.CreateSalesLines(TempSalesLine, SalesHeader, SalesLine);
            until TempSalesHeader.Next() = 0;
            // Delete Deposit Lines if configured to do so
            if SalesSetup."CST Magasin Imp Delete Deposit" then begin
                DepositCode.SetFilter("Code", '<>%1', '');
                DepositCode.SetFilter("Deposit Item No.", '<>%1', '');
                DepositCode.SetFilter("Description", '<>%1', '');
                if DepositCode.FindSet()then begin
                    RecNo:=0;
                    TotalRecNo:=DepositCode.Count();
                    if GuiAllowed then begin
                        Window.Update(1, Text004bLbl);
                        Window.Update(2, 0);
                    end;
                    repeat RecNo+=1;
                        if GuiAllowed then Window.Update(2, Round(RecNo / TotalRecNo * 10000, 1));
                        SalesLine.SetSalesHeader(SalesHeader);
                        SalesLine.SetHideValidationDialog(true);
                        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
                        SalesLine.SetRange("Document No.", SalesHeader."No.");
                        SalesLine.SetRange("Type", SalesLine.Type::"Item");
                        SalesLine.SetRange("No.", DepositCode."Deposit Item No.");
                        if not SalesLine.IsEmpty()then SalesLine.DeleteAll(true);
                    until DepositCode.Next() = 0;
                end;
            end;
            if GuiAllowed then begin
                Window.Update(1, '');
                Window.Update(2, 0);
            end;
            // Set the default release status for the sales documents
            if SalesSetup."CST Magasin Deflt. Rel. Status" <> SalesSetup."CST Magasin Deflt. Rel. Status"::Open then if SalesHeader.FindSet()then repeat SalesHeader.Validate(Status, SalesSetup."CST Magasin Deflt. Rel. Status");
                        SalesHeader.Modify(true);
                    until SalesHeader.Next() = 0;
            exit(true);
        end;
    end;
    var TempExcelBuffer: Record "Excel Buffer" temporary;
    SalesHeader: Record "Sales Header";
    SalesLine: Record "Sales Line";
    SalesSetup: Record "Sales & Receivables Setup";
    FileManagement: Codeunit "File Management";
    CreateMagasinSalesDoc: Codeunit "CST Create Sales Docs. Magasin";
    TempBlob: Codeunit "Temp Blob";
    FileInStream: InStream;
    Window: Dialog;
    FileName: Text;
    SheetName: Text;
    TotalRecNo: Integer;
    RecNo: Integer;
    Desc: Text[50];
    ErrorMessage: Text;
    FileExt: Text;
    PostType: Text[30];
    Qty: Decimal;
    PostingDate: Date;
    ShowDeveloperMessageYesNo: Boolean;
    Text001Lbl: Label 'Process #1#########################\\', comment = 'Proces #1#########################\\';
    Text002Lbl: Label 'Status  @2@@@@@@@@@@@@@@@@@@@', comment = 'DAN="Status @2@@@@@@@@@@@@@@@@@@@"';
    Text003Lbl: Label 'Analyzing Data...', comment = 'DAN="Analyserer data...';
    Text004Lbl: Label 'Creating Sales Documents...', comment = 'DAN="Opretter salgsdokumenter...';
    Text004bLbl: Label 'Preparing Sales Documents...', comment = 'DAN="Forbereder salgsdokumenter...';
    Text005Lbl: Label 'Sales Order(s) has been successfully updated with %1 sales lines.', comment = 'DAN="Salgsordre er oprettet med %1 salgslinjer"';
    Text006Lbl: Label 'Magasin import from Excel - %1.', comment = 'DAN="Magasin indlæsning fra Excel - %1"';
    Text007Lbl: Label 'Select and Import Excel File...', comment = 'DAN="Vælg og indlæs Excelfil..."';
    /// Text007Lbl: Label 'Analyzing Data...\\', comment = 'DAN="Analyserer data...\\';
     // Text007Lbl: Label 'Analyzing Data...', comment = 'DAN="Analyserer data...';
    // Text008Lbl: Label 'Status @1@@@@@@@@@@@@@@@@@@@', comment = 'DAN="Status @1@@@@@@@@@@@@@@@@@@@"';
    ExcelFileExtensionTok2Lbl: Label 'Excel Files (*.xlsx;*.xls;*.csv)|*.xlsx;*.xls;*.csv', Locked = true, Comment = 'Excel file extensions for import. *.xlsx, *.xls, and *.csv';
    FileNameErr: Label 'Please select a valid Excel file containing the right columns and data!', comment = 'DAN="Venligst vælg en valid excelfil med de rigtige kolonner og data!"';
    MagasinCustomerNoErr: Label 'Please set the Magasin Customer No. in the Sales & Receivables Setup!', comment = 'DAN="Venligst indsæt kundenr. for Magasin i Opsætning af Salg"';
}
