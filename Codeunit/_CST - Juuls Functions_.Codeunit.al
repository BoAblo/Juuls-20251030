codeunit 50004 "CST - Juuls Functions"
{
    procedure MultiGTINNumre("No.": code[20]): Boolean var
        ItemReference: Record "Item Reference";
        Item: Record Item;
        Item2: Record Item;
    begin
        Clear(Item);
        clear(Item2);
        Clear(ItemReference);
        Item.get("No."); //Varen på linjen.
        if item.GTIN <> '' Then begin
            ItemReference.Setfilter("Item No.", '<>%1', "No."); //Må ikke være den vare der er på linjen
            ItemReference.SetRange("Reference Type", ItemReference."Reference Type"::"Bar Code"); //Reference type = Stregkode
            ItemReference.SetRange("Reference No.", Item.GTIN); //Referencenr = varen på linjens GTIN nr.
            if not ItemReference.IsEmpty()then Exit(true);
            //Hvis der ikke findes en varereference med stregkoden, så tjek GTIN nr på varerne i stedet
            Item2.Setfilter("No.", '<>%1', "No."); //Må ikke være den vare der er på linjen
            Item2.setrange(GTIN, Item.GTIN); //Samme GTIN nr som varn på linjen
            If not item2.IsEmpty()then exit(true);
        end;
        exit(false);
    end;
}
