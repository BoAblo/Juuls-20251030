pageextension 50008 "CST Bank Account Card" extends "Bank Account Card"
{
    layout
    {
        addafter(IBAN)
        {
            field("IBAN (EURO)"; Rec."IBAN (EURO)")
            {
                ApplicationArea = All;
            }
        }
    }
}
