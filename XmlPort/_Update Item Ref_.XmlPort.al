xmlport 50009 "Update Item Ref"
{
    Caption = 'Update Item References', Comment = 'DAN="Opdater varereferencer"';
    Direction = Import;
    FieldSeparator = ';';
    Format = VariableText;
    UseRequestPage = false;
    TextEncoding = WINDOWS;

    schema
    {
    textelement(Root)
    {
    tableelement("Item Reference";
    "Item Reference")
    {
    AutoSave = false;
    XmlName = 'ItemReference';
    UseTemporary = true;

    fieldelement(ItemReferenceItemNo;
    "Item Reference"."Item No.") //P-nr.
    {
    }
    fieldelement(ItemReferenceUnitOfMeasure;
    "Item Reference"."Unit of Measure")
    {
    }
    fieldelement(ItemReferenceReferenceType;
    "Item Reference"."Reference Type")
    {
    }
    fieldelement(ItemReferenceReferenceNo;
    "Item Reference"."Reference No.")
    {
    }
    trigger OnAfterinsertRecord()
    begin
        CreateUpdateItemRef();
    end;
    }
    }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    local procedure CreateUpdateItemRef()
    var
        ItemRef: Record "Item Reference";
    begin
        ItemRef.setrange("Item No.", "Item Reference"."Item No.");
        ItemRef.setrange("Reference No.", "Item Reference"."Reference No.");
        IF ItemRef.FindFirst()then begin
            IF ItemRef."Unit of Measure" <> "Item Reference"."Unit of Measure" THEN ItemRef.Rename("Item Reference"."Item No.", "Item Reference"."Variant Code", "Item Reference"."Unit of Measure", "Item Reference"."Reference Type", "Item Reference"."Reference Type No.", "Item Reference"."Reference No.")end
        else
        begin
            ItemRef.Init();
            ItemRef."Item No.":="Item Reference"."Item No.";
            ItemRef."Reference Type":="Item Reference"."Reference Type";
            ItemRef."Unit of Measure":="Item Reference"."Unit of Measure";
            ItemRef."Reference No.":="Item Reference"."Reference No.";
            ItemRef.insert();
        end;
    end;
}
