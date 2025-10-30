tableextension 50013 "CST Sales Setup" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50010; "CST Magasin Customer No."; Code[20])
        {
            Caption = 'Magasin Customer No.';
            TableRelation = Customer."No.";
            DataClassification = ToBeClassified;
            ToolTip = 'The customer number for the Magasin customer.';
        }
        field(50011; "CST Magasin Set Prices InclVAT"; Boolean)
        {
            Caption = 'Magasin Set Prices Incl. VAT';
            DataClassification = ToBeClassified;
            InitValue = true;
            Editable = false;
            ToolTip = 'Indicates whether the Magasin sales documents should have prices set to include VAT.';
        }
        field(50015; "CST Magasin Inbox E-mail"; Text[80])
        {
            Caption = 'Magasin Inbox E-mail';
            OptimizeForTextSearch = true;
            ExtendedDatatype = EMail;
            ToolTip = 'The e-mail address for the Magasin inbox.';
        }
        field(50016; "CST Magasin Inbox Password"; Text[100])
        {
            Caption = 'Magasin Inbox Password';
            OptimizeForTextSearch = true;
            ExtendedDatatype = Masked;
            ToolTip = 'The password for the Magasin inbox e-mail.';
        }
        field(50020; "CST Magasin Imp Delete Deposit"; Boolean)
        {
            Caption = 'Magasin Imp. Delete Bottle Deposit';
            DataClassification = ToBeClassified;
            ToolTip = 'Indicates whether the Magasin import should delete the bottle deposit lines.';
        }
        field(50025; "CST Magasin Deflt. Rel. Status";Enum "Sales Document Status")
        {
            Caption = 'Magasin Default Release Status';
            DataClassification = ToBeClassified;
            ToolTip = 'The default release status for Magasin sales documents.';

            trigger OnValidate()
            begin
                if("CST Magasin Deflt. Rel. Status" = "Sales Document Status"::"Pending Approval") or ("CST Magasin Deflt. Rel. Status" = "Sales Document Status"::"Pending Prepayment")then FieldError("CST Magasin Deflt. Rel. Status", StrSubstNo(StatusLabelErr, "Sales Document Status"::"Pending Approval", "Sales Document Status"::"Pending Prepayment"));
            end;
        }
    }
    var StatusLabelErr: Label 'cannot be set to "%1" or "%2"!', Comment = '%1 = Depending Release , %2 = Depending Prepayment';
}
