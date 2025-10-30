pageextension 50006 "CST Price List Line Review" extends "Price List Line Review"
{
    layout
    {
        modify("Starting Date")
        {
            Editable = true;
        }
        modify("Ending Date")
        {
            Editable = true;
        }
    }
    actions
    {
        addbefore(VerifyLines)
        {
            action(JuulsDeletePriceline)
            {
                ApplicationArea = All;
                Caption = 'Delete Price Line', comment = 'DAN="Juuls Slet pris linje"';
                Image = Delete;
                ToolTip = 'Delete the selected price line.', comment = 'DAN="Slet den valgte pris linje."';

                trigger OnAction()
                var
                    PriceListLine: Record "Price List Line";
                    Text1Qst: label 'Are you sure you want to delete this price line?', comment = 'DAN="Er du helt sikker at denne linje skal slettes?"';
                begin
                    if PriceListLine.Get(Rec."Price List code", rec."Line No.")then if Confirm(Text1Qst)then begin
                            PriceListLine.Delete();
                            Commit();
                            CurrPage.Update(false);
                        end;
                end;
            }
        }
        addbefore(VerifyLines_Promoted)
        {
            actionref(JuulsDeletePriceline_Promoted; JuulsDeletePriceline)
            {
            }
        }
    }
}
