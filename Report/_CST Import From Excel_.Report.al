report 50099 "CST Import From Excel"
{
    UsageCategory = Tasks;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Import From Excel';

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(FileInformation)
                {
                    Caption = 'Excel Parameters';

                    field(Name; FileName)
                    {
                        Caption = 'Choose Excel File';
                        ApplicationArea = All;
                        Editable = false;
                        AssistEdit = true;
                        ToolTip = 'Select the Excel File name to import.';

                        trigger OnAssistEdit()
                        begin
                            FileName:=FileManagement.BLOBImportWithFilter(TempBlob, ImportTxt, FileName, StrSubstNo(FileDialogTxt, FilterTxt), FilterTxt);
                            FileExt:=FileManagement.GetExtension(FileName);
                            if(FileName = '') or (not TempBlob.HasValue()) or not(FileExt in['xlsx', 'xls', 'csv'])then begin
                                FileName:='';
                                Error(FileNameErr);
                            end;
                            TempBlob.CreateInStream(ImportedInStream);
                        end;
                    }
                    field(SheetNameField; SheetName)
                    {
                        Caption = 'Choose Sheet Name';
                        ApplicationArea = All;
                        Editable = false;
                        ToolTip = 'Select the sheet name from the Excel Sheet name to import.';

                        trigger OnAssistEdit()
                        begin
                            if(FileName = '') or (not TempBlob.HasValue())then Error(FileNameErr);
                            SheetName:=TempExcelBuffer.SelectSheetsNameStream(ImportedInStream);
                        end;
                    }
                }
            }
        }
        trigger OnOpenPage()
        begin
            FileName:=FileManagement.BLOBImportWithFilter(TempBlob, ImportTxt, FileName, StrSubstNo(FileDialogTxt, FilterTxt), FilterTxt);
            FileExt:=FileManagement.GetExtension(FileName);
            if(FileName = '') or (not TempBlob.HasValue()) or not(FileExt in['xlsx', 'xls', 'csv'])then begin
                FileName:='';
                Message(FileNameErr);
            end
            else
                TempBlob.CreateInStream(ImportedInStream);
        end;
    }
    trigger OnPreReport()
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Value: Boolean;
    // ProcessExcelImport: Codeunit "Process Excel Import";
    begin
        if SalesHeader.get(SalesHeader."Document Type"::Order, 'SO554506')then begin
            if SalesHeader."Sell-to Customer No." <> '58191213' then Error('Wrong customer number for test data. Expected: 58191213, Actual: %1', SalesHeader."Sell-to Customer No.");
            if SalesHeader."Prices Including VAT" then begin
                SalesHeader.Status:=SalesHeader.Status::Open;
                SalesHeader.Validate("Prices Including VAT", false);
                SalesHeader.Modify(true);
            end;
            Value:=false;
            if Value then begin
                SalesLine.SetSalesHeader(SalesHeader);
                SalesLine.SetHideValidationDialog(true);
                SalesLine.SetRange("Document Type", SalesHeader."Document Type");
                SalesLine.SetRange("Document No.", SalesHeader."No.");
                if SalesLine.FindFirst()then SalesLine.DeleteAll();
                SalesHeader.Delete();
                Commit();
            end;
        end;
        Message('Done');
        CurrReport.Break();
        TempExcelBuffer.OpenBookStream(ImportedInStream, SheetName);
        TempExcelBuffer.ReadSheetContinous(SheetName, true);
    // ProcessExcelImport.ProcessExcelImport(TempExcelBuffer);
    end;
    var TempExcelBuffer: Record "Excel Buffer" temporary;
    TempBlob: Codeunit "Temp Blob";
    FileManagement: Codeunit "File Management";
    ImportedInStream: InStream;
    FileName: Text;
    FileExt: Text;
    SheetName: Text;
    FileNameErr: Label 'Please select proper Excel file!';
    FileDialogTxt: Label 'Import (%1)|%1';
    ImportTxt: Label 'Import Excel File';
    FilterTxt: Label '*.xlsx;*.xls;*.*', Locked = true;
}
