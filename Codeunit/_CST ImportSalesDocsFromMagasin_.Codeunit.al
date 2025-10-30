codeunit 50005 "CST ImportSalesDocsFromMagasin"
{
    Subtype = Normal;

    trigger OnRun()
    begin
        ImportFromExcel();
    end;
    local procedure ImportFromExcel()
    var
        ExcelBuffer: Record "Excel Buffer";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        InStream: InStream;
        Dialog: Dialog;
        FileName: Text;
        UploadFile: Boolean;
        PostTypeText: Text;
        PostingDate: Date;
        DocType: Enum "Sales Document Type";
        DocNo: Code[20];
        LineNo: Integer;
        IsInvoice: Boolean;
    begin
        Dialog.Open('Importing sales documents...');
        UploadFile:=UploadIntoStream('Select Excel file to import', '', 'Excel Files (*.xlsx)|*.xlsx', FileName, InStream);
        if not UploadFile then exit;
        ExcelBuffer.DeleteAll();
        ExcelBuffer.ReadSheet();
        // Skip header row
        ExcelBuffer.SetFilter("Row No.", '>=%1', 2);
        ExcelBuffer.FindSet();
        repeat // Map fields
            PostingDate:=EvaluateDate(ExcelBuffer.GetValueByCellName('3'));
            PostTypeText:=UpperCase(ExcelBuffer.GetValueByCellName('4'));
            DocNo:=CopyStr(Format(ExcelBuffer.GetValueByCellName('5')), 1, MaxStrLen(DocNo));
            LineNo:=ExcelBuffer."Row No." * 10000;
            IsInvoice:=(PostTypeText = 'SALES') or (PostTypeText = 'SALG');
            DocType:=DocType::Invoice;
            if not IsInvoice then DocType:=DocType::"Credit Memo";
            // Insert or get header
            if not SalesHeader.Get(DocType, DocNo)then begin
                SalesHeader.Init();
                SalesHeader.SetHideValidationDialog(true);
                SalesHeader.SetHideCreditCheckDialogue(true);
                SalesHeader."Document Type":=DocType;
                SalesHeader.Validate("No.", '');
                SalesHeader.Insert(true);
                SalesHeader.Validate("Posting Date", PostingDate);
                SalesHeader.Modify(true);
            end;
            // Insert lines
            SalesLine.Reset();
            SalesLine.SetRange("Document Type", DocType);
            SalesLine.SetRange("Document No.", DocNo);
            SalesLine.FindLast();
            LineNo:=SalesLine."Line No." + 10000;
            SalesLine.Init();
            SalesLine.SetHideValidationDialog(true);
            SalesLine.SetSalesHeader(SalesHeader);
            SalesLine."Document Type":=SalesHeader."Document Type";
            SalesLine.Validate("Document No.", SalesHeader."No.");
            SalesLine."Line No.":=LineNo;
            SalesLine.Insert(true);
            SalesLine.Type:=SalesLine.Type::Item;
            SalesLine.Validate("No.", ExcelBuffer.GetValueByCellName('6'));
            SalesLine.Validate(Description, ExcelBuffer.GetValueByCellName('7'));
            SalesLine.Validate("Location Code", ExcelBuffer.GetValueByCellName('8'));
            SalesLine.Validate(Quantity, EvaluateDecimal(ExcelBuffer.GetValueByCellName('9')));
            SalesLine.Validate("Unit of Measure Code", ExcelBuffer.GetValueByCellName('10'));
            SalesLine.Validate("Unit Price", EvaluateDecimal(ExcelBuffer.GetValueByCellName('11')));
            SalesLine.Validate("Line Amount", EvaluateDecimal(ExcelBuffer.GetValueByCellName('12')));
            SalesLine.Validate("Line Discount Amount", EvaluateDecimal(ExcelBuffer.GetValueByCellName('13')));
            SalesLine.Validate("Unit Cost", EvaluateDecimal(ExcelBuffer.GetValueByCellName('14')));
            SalesLine.Insert(true);
        until ExcelBuffer.Next() = 0;
        Dialog.Close();
        Message('Import completed successfully.');
    end;
    local procedure EvaluateDecimal(ValueText: Text): Decimal var
        D: Decimal;
    begin
        Evaluate(D, ValueText);
        exit(D);
    end;
    local procedure EvaluateDate(ValueText: Text): Date var
        D: Date;
    begin
        Evaluate(D, ValueText);
        exit(D);
    end;
}
