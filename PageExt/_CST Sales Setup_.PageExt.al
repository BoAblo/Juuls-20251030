pageextension 50027 "CST Sales Setup" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter(Archiving)
        {
            group(MagasinImport)
            {
                Caption = 'Magasin Import';

                field("CST Magasin Customer No."; Rec."CST Magasin Customer No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies the Customer No. for Magasin.';
                    Visible = true;
                    ShowMandatory = true;
                }
                field("CST Magasin Set Prices InclVAT"; Rec."CST Magasin Set Prices InclVAT")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies whether the Magasin sales documents should have prices set to include VAT.';
                    Visible = true;
                }
                field("CST Magasin Imp Delete Deposit"; Rec."CST Magasin Imp Delete Deposit")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies whether the Magasin import should delete the bottle deposit lines.';
                    Visible = true;
                }
                field("CST Magasin Deflt. Rel. Status"; Rec."CST Magasin Deflt. Rel. Status")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies the default release status for Magasin sales documents.';
                    Visible = true;
                }
                field("CST Magasin Inbox E-mail"; Rec."CST Magasin Inbox E-mail")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies the e-mail address for the Magasin inbox.';
                    Visible = false;
                }
                field("CST Magasin Inbox Password"; Rec."CST Magasin Inbox Password")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies the password for the Magasin inbox e-mail.';
                    Visible = false;
                }
            }
        }
    }
}
