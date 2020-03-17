pageextension 50001 SalesPricePageExt extends "sales prices"
{
    layout
    {
        // Add changes to page layout here

        addafter("Unit Price")
        {
            field("Margin (Unit Cost)"; UnitCostMargin)
            {
                Caption = 'Margin (Unit Cost)';
                DecimalPlaces = 0 : 5;

            }

            field("Item Unit Cost"; ItemUnitCost)
            {
                Caption = 'Item Unit Cost';
                DecimalPlaces = 0 : 5;
            }

            field("Item Standard Cost"; ItemStandardCost)
            {
                Caption = 'Item Standard Cost';
                DecimalPlaces = 0 : 5;
            }

            field("Margin (Standard Cost)"; StandardCostMargin)
            {
                Caption = 'Margin (Standard Cost)';
                DecimalPlaces = 0 : 5;
            }
        }
        addafter("Delivered Unit Price")
        {
            field("Net Weight"; NetWeight)
            {
                Caption = 'Net Weight';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        If Item.Get("Item No.") and ("Unit of Measure Code" <> '') then begin

            ItemUnitCost := Item."Unit Cost";
            ItemStandardCost := Item."Standard Cost";
            NetWeight := Item."Net Weight";
            IF "Unit of Measure Code" <> Item."Base Unit of Measure" then begin
                ItemUOM.Get("Item No.", "Unit of Measure Code");
                ItemUnitCost := ItemUnitCost / ItemUOM."Qty. per Base UOM";
                ItemStandardCost := ItemStandardCost / ItemUOM."Qty. per Base UOM";
            end;
            If "Unit Price" <> 0 then begin
                UnitCostMargin := ("Unit Price" - ItemUnitCost) / "Unit Price";
                StandardCostMargin := ("Unit Price" - ItemStandardCost) / "Unit Price";
            end
            else begin
                UnitCostMargin := 0.0;
                StandardCostMargin := 0.0;

            end;
        end;
    end;

    var
        ItemUnitCost: Decimal;
        ItemStandardCost: Decimal;
        StandardCostMargin: Decimal;
        UnitCostMargin: Decimal;
        NetWeight: Decimal;
        Item: Record Item;
        ItemUOM: Record "Item Unit of Measure";

}