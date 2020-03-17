tableextension 50001 SalesPriceExtension extends "Sales Price"
{
    fields
    {



        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                Item.Get("Item No.");
                if (Item."Sales Price Unit of Measure" <> '') then
                    "Unit of Measure Code" := item."Sales Price Unit of Measure"
                else
                    "Unit of Measure Code" := Item."Base Unit of Measure";

            end;
        }


    }

    var
        myInt: Integer;
        Item: Record Item;
}