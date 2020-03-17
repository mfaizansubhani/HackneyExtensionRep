report 50005 "Sales Price Sheet"
{   // EN1.00 10-10-2019 FS
    //  Report Created to display price list sheet with respect to price sequence attribute.
    // EN1.01 1/6/2019 FS
    //  Made changes for Asterik  


    //---------------------------------------------------------

    // Copyright Axentia Solutions Corp.  1999-2013.
    // By opening this object you acknowledge that this object includes confidential information and intellectual
    // property of Axentia Solutions Corp. and that this work is protected by Canadian, U.S. and international
    // copyright laws and agreements.
    // 
    // JF00029FC
    //   Updated to use new Sales Price primary key:
    //     From: Item No.,Sales Type,Sales Code,Starting Date,Currency Code,Variant Code,Unit of Measure Code,Minimum Quantity
    //     To:   Item No.,Sales Type,Sales Code,Ship-To Code,Starting Date,Currency Code,Variant Code,Unit of Measure Code,Minimum Quantity
    // 
    // JF000xxMG
    //   20060505 - compress report to print only on a single line per item
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/List Price Sheet.rdl';

    ApplicationArea = Basic, Suite;
    Caption = 'Sales Price Sheet';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Attribute Value"; "Item Attribute Value")
        {
            DataItemTableView = SORTING (Value) ORDER(Ascending) WHERE ("Attribute ID" = CONST (1));
            column(ItemValue; "Item Attribute Value".Value)
            {
            }
            column(ItemValBool; ItemValBool)
            {
            }
            dataitem("Item Attribute Value Mapping"; "Item Attribute Value Mapping")
            {
                DataItemLink = "Item Attribute Value ID" = FIELD (ID);
                DataItemTableView = WHERE ("Table ID" = CONST (27), "Item Attribute ID" = CONST (1));
                dataitem(Item; Item)
                {
                    DataItemLink = "No." = FIELD ("No.");
                    RequestFilterFields = "No.", "Search Description", "Inventory Posting Group", "Variant Filter";
                    column(MainTitle; MainTitle)
                    {
                    }
                    column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
                    {
                    }
                    column(TIME; Time)
                    {
                    }
                    column(CompanyInformation_Name; CompanyInformation.Name)
                    {
                    }
                    column(CurrReport_PAGENO; CurrReport.PageNo)
                    {
                    }
                    column(USERID; UserId)
                    {
                    }
                    column(SubTitle; SubTitle)
                    {
                    }
                    column(SalesPrice_FIELDCAPTION__Currency_Code____________Currency_Code; SalesPrice.FieldCaption("Currency Code") + ': ' + Currency.Code)
                    {
                    }
                    column(CustPriceGr_TABLECAPTION__________CustPriceGrCode; CustPriceGr.TableCaption + ': ' + CustPriceGrCode)
                    {
                    }
                    column(All_Customers_; 'All Customers')
                    {
                    }
                    column(Cust_TABLECAPTION__________CustNo; Cust.TableCaption + ': ' + CustNo)
                    {
                    }
                    column(Campaign_TABLECAPTION__________CampNo; Campaign.TableCaption + ': ' + CampNo)
                    {
                    }
                    column(Item_TABLECAPTION__________ItemFilter; Item.TableCaption + ': ' + ItemFilter)
                    {
                    }
                    column(Item__No__; Item."No.")
                    {
                    }
                    column(Item_Description; Description)
                    {
                    }
                    column(Currency_Code; Currency.Code)
                    {
                    }
                    column(ShowSalesType; ShowSalesType)
                    {
                    }
                    column(CustPriceGrCode; CustPriceGrCode)
                    {
                    }
                    column(CustNo; CustNo)
                    {
                    }
                    column(ItemFilter; ItemFilter)
                    {
                    }
                    column(CampNo; CampNo)
                    {
                    }
                    column(Item_Variant_Filter; "Variant Filter")
                    {
                    }
                    column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                    {
                    }
                    column(Item_DescriptionCaption; FieldCaption(Description))
                    {
                    }
                    column(Item__No__Caption; FieldCaption("No."))
                    {
                    }
                    column(Sales_Price__Unit_of_Measure_Code_Caption; "Sales Price".FieldCaption("Unit of Measure Code"))
                    {
                    }
                    column(Sales_Price__Variant_Code_Caption; "Sales Price".FieldCaption("Variant Code"))
                    {
                    }
                    column(Sales_Price__Minimum_Quantity_Caption; "Sales Price".FieldCaption("Minimum Quantity"))
                    {
                    }
                    column(Sales_Price__Unit_Price_Caption; "Sales Price".FieldCaption("Unit Price"))
                    {
                    }
                    column(Sales_Price__Starting_Date_Caption; "Sales Price".FieldCaption("Starting Date"))
                    {
                    }
                    column(Sales_Price__Ending_Date_Caption; "Sales Price".FieldCaption("Ending Date"))
                    {
                    }
                    dataitem("Sales Price"; "Sales Price")
                    {
                        DataItemLink = "Item No." = FIELD ("No."), "Variant Code" = FIELD ("Variant Filter");
                        DataItemTableView = SORTING ("Item No.", "Sales Type", "Sales Code", "Ship-To Code", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity");
                        column(Sales_Price__Unit_of_Measure_Code_; "Unit of Measure Code")
                        {
                        }
                        column(Sales_Price__Variant_Code_; "Variant Code")
                        {
                        }
                        column(Sales_Price__Minimum_Quantity_; "Minimum Quantity")
                        {
                        }
                        column(Sales_Price__Unit_Price_; "Unit Price")
                        {
                        }
                        //column(SalesPriceAsterik; format("Unit Price") + ' ' + Asterik)
                        //{

                        //}
                        column(SalesPriceAsterik; UnitPriceText)
                        {

                        }

                        column(Sales_Price__Starting_Date_; "Starting Date")
                        {
                        }
                        column(Sales_Price__Ending_Date_; "Ending Date")
                        {
                        }
                        column(Sales_Price_Item_No_; "Item No.")
                        {
                        }
                        column(Sales_Price_Sales_Type; "Sales Type")
                        {
                        }
                        column(Sales_Price_Sales_Code; "Sales Code")
                        {
                        }
                        column(Sales_Price_Currency_Code; "Currency Code")
                        {
                        }
                        column(AnySalesPriceFound_; AnySalesPriceFound)
                        {
                        }
                        column(SalesPriceDescription; Item.Description)
                        {
                        }
                        column(PricePerUnit; PricePerUnit)
                        {
                        }
                        column(BaseUOM; BaseUOM)
                        {
                        }

                        column(Asterik; Asterik) //EN1.01
                        {

                        }

                        trigger OnAfterGetRecord()
                        var
                            IUOM: Record "Item Unit of Measure";
                            ICalcPrice: Record "Item Sales Price Calculation";
                            CustomerRec: Record "Customer"; //EN1.01
                        begin
                            Asterik := ''; //EN1.01
                            ItemValLetter := CopyStr("Item Attribute Value".Value, 1, 1);
                            if (ItemValLetter <> ItemValLetter2) and (ItemValLetter2 <> '') then
                                ItemValBool := true
                            else
                                ItemValBool := false;

                            if ItemValLetter2 <> ItemValLetter then
                                ItemValLetter2 := ItemValLetter;

                            if "Unit of Measure Code" = '' then
                                "Unit of Measure Code" := Item."Base Unit of Measure";

                            if "Currency Code" <> Currency.Code then
                                "Unit Price" :=
                                  CurrencyExchRate.ExchangeAmtFCYToFCY(DateReq, "Currency Code", Currency.Code, "Unit Price");

                            Asterik := FindPrevPriceChange("Sales Price"."Item No.", "Sales Price"."Starting Date", "Sales Price"."Unit Price");

                            if SalesType = SalesType::"Customer Price Group" then begin
                                ICalcPrice.Reset;
                                ICalcPrice.SetFilter(Code, "Sales Price"."Item No.");
                                ICalcPrice.SetFilter("Sales Code", SalesCode);
                                if ICalcPrice.FindFirst then
                                    "Unit Price" := "Unit Price" + ICalcPrice.Value
                                else
                                    "Unit Price" := 0;
                            end;

                            "Unit Price" := Round("Unit Price", 0.01, '=');

                            if IUOM.Get("Sales Price"."Item No.", 'LB') then begin
                                BaseUOM := "Unit Price" * IUOM."Qty. per Base UOM";
                                BaseUOM := Round(BaseUOM, 0.01, '=');
                            end;

                            if IUOM.Get("Sales Price"."Item No.", 'UP') then begin
                                PricePerUnit := BaseUOM / IUOM."Qty. per Base UOM";
                                PricePerUnit := Round(PricePerUnit, 0.01, '=');
                            end;

                            Decimals := "Unit Price" - ROUND("Unit Price", 1, '<');
                            IF Decimals = 0 THEN
                                UnitPriceText := FORMAT("Unit Price", 0, 0) +
                                    COPYSTR(FORMAT(0.01), 2, 1) +
                                    PADSTR('', STRLEN(FORMAT(0.01)) - 2, '0') + ' ' + Asterik
                            ELSE
                                UnitPriceText := FORMAT("Unit Price", 0, 0) +
                                    PADSTR('', STRLEN(FORMAT(0.01)) - STRLEN(FORMAT(Decimals)), '0') + ' ' + Asterik;
                        end;

                        trigger OnPostDataItem()
                        begin
                            ItemValBool := false;
                        end;

                        trigger OnPreDataItem()
                        begin
                            if SalesType = SalesType::"All Customers" then begin
                                SetRange("Sales Type", SalesType::Customer);
                                SetFilter("Sales Code", SalesCode);
                            end
                            else
                                if SalesType = SalesType::Customer then begin
                                    SetRange("Sales Type", SalesType::Customer);
                                    SetFilter("Sales Code", SalesCode);
                                end
                                else
                                    if SalesType = SalesType::"Customer Price Group" then begin
                                        SetFilter("Sales Code", 'MARKET');
                                    end
                                    else begin
                                        SetRange("Sales Type", SalesType);
                                        SetFilter("Sales Code", SalesCode);
                                    end;
                            SetFilter("Currency Code", '%1|%2', Currency.Code, '');

                            SetRange("Starting Date", 0D, DateReq);
                            SetFilter("Ending Date", '%1|%2..', 0D, DateReq);

                            AnySalesPriceFound := FindSet;
                            if AnySalesPriceFound then begin
                                SetRange("Starting Date", "Starting Date");
                                SetRange("Ending Date");

                            end else
                                CurrReport.Break;
                        end;
                    }
                    dataitem(NoSalesPrice; "Integer")
                    {
                        DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                        column(Sales_Price___Unit_Price_; "Sales Price"."Unit Price")
                        {
                        }
                        column(Sales_Price___Unit_of_Measure_Code_; "Sales Price"."Unit of Measure Code")
                        {
                        }
                        column(NoSalesPrice_Number; Number)
                        {
                        }
                        column(SalesPriceItemNo; "Sales Price"."Item No.")
                        {
                        }
                        column(SalesPriceDescriptionNo; "Sales Price".Description)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            /*//MESSAGE('%1',Item."No.");
                            //IF AnySalesPriceFound THEN
                              //BEGIN
                               //CLEAR("Sales Price");
                              //IF "Sales Price".FINDSET THEN
                               // REPEAT
                                "Sales Price"."Unit of Measure Code" := Item."Base Unit of Measure";
                                "Sales Price"."Item No." := Item."No.";
                                "Sales Price".Description:= Item.Description;
                                "Sales Price"."Starting Date" := TODAY;
                                //MESSAGE('%1',Item.Description);
                                IF "Sales Price"."Currency Code" <> Currency.Code THEN
                                  "Sales Price"."Unit Price" :=
                                    CurrencyExchRate.ExchangeAmtFCYToFCY(
                                      DateReq,"Sales Price"."Currency Code",Currency.Code,"Sales Price"."Unit Price");
                                //UNTIL "Sales Price".NEXT = 0;
                            
                            
                                //MESSAGE('%1',Item."Unit Price");
                            
                            
                             // END;
                            
                             */

                        end;

                        trigger OnPreDataItem()
                        begin
                            //MESSAGE('%1',Item."No.");
                            //IF AnySalesPriceFound THEN
                            CurrReport.Break;
                        end;
                    }

                    trigger OnPreDataItem()
                    begin
                        CustNo := '';
                        CustPriceGrCode := '';
                        CampNo := '';
                        ShowSalesType := 0;
                        case SalesType of
                            SalesType::Customer:
                                begin
                                    Cust.Get(SalesCode);
                                    CustNo := Cust."No.";
                                    CustPriceGrCode := Cust."Customer Price Group";
                                    ShowSalesType := 1;
                                end;
                            SalesType::"Customer Price Group":
                                begin
                                    CustPriceGr.Get(SalesCode);
                                    CustPriceGrCode := SalesCode;
                                    ShowSalesType := 2;
                                end;
                            SalesType::Campaign:
                                begin
                                    Campaign.Get(SalesCode);
                                    CampNo := Campaign."No.";
                                    ShowSalesType := 3;
                                end;
                        end;
                    end;
                }
            }

            trigger OnPreDataItem()
            begin
                ItemValBool := false;
            end;
        }

    }


    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(DateReq; DateReq)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Date';
                        ToolTip = 'Specifies the date when the prices are valid.';
                    }
                    field(SalesType; SalesType)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales Type';
                        OptionCaption = 'Customer,Customer Price Group,All Customers,Campaign';
                        ToolTip = 'Specifies the type of sales that you want to print on the report, such as customer or campaign.';

                        trigger OnValidate()
                        begin
                            SalesCodeCtrlEnable := (SalesType <> SalesType::"All Customers");
                            SalesCode := '';
                        end;
                    }
                    field(SalesCodeCtrl; SalesCode)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales Code';
                        Enabled = SalesCodeCtrlEnable;
                        ToolTip = 'Specifies the customer or the campaign that you want to include in the report. The available options depend on your selection in the Sales Type field.';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            CustList: Page "Customer List";
                            CustPriceGrList: Page "Customer Price Groups";
                            CampList: Page "Campaign List";
                        begin
                            case SalesType of
                                SalesType::Customer:
                                    begin
                                        CustList.LookupMode := true;
                                        CustList.SetRecord(Cust);
                                        if CustList.RunModal = ACTION::LookupOK then begin
                                            CustList.GetRecord(Cust);
                                            SalesCode := Cust."No.";
                                        end;
                                    end;
                                SalesType::"Customer Price Group":
                                    begin
                                        CustPriceGrList.LookupMode := true;
                                        CustPriceGrList.SetRecord(CustPriceGr);
                                        if CustPriceGrList.RunModal = ACTION::LookupOK then begin
                                            CustPriceGrList.GetRecord(CustPriceGr);
                                            SalesCode := CustPriceGr.Code;
                                        end;
                                    end;
                                SalesType::Campaign:
                                    begin
                                        CampList.LookupMode := true;
                                        CampList.SetRecord(Campaign);
                                        if CampList.RunModal = ACTION::LookupOK then begin
                                            CampList.GetRecord(Campaign);
                                            SalesCode := Campaign."No.";
                                        end;
                                    end;
                            end;
                        end;
                    }
                    field("Currency.Code"; Currency.Code)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Currency Code';
                        TableRelation = Currency;
                        ToolTip = 'Specifies the currency that prices are shown in.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            SalesCodeCtrlEnable := true;
        end;

        trigger OnOpenPage()
        begin
            if DateReq = 0D then
                DateReq := WorkDate;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        MainTitle := StrSubstNo(Text000, DateReq);
        CompanyInformation.Get;
        SubTitle := StrSubstNo(Text001, CompanyInformation."Phone No.");
        if CustPriceGr.Code <> '' then
            CustPriceGr.Find;
        if Currency.Code = '' then
            CurrencyExchRate."Exchange Rate Amount" := 100
        else begin
            Currency.Find;
            CurrencyExchRate.SetRange("Currency Code", Currency.Code);
            CurrencyExchRate.SetRange("Starting Date", 0D, WorkDate);
            CurrencyExchRate.FindLast;
        end;
        ItemFilter := Item.GetFilters;
    end;

    //EN1.01                             
    local procedure FindPrevPriceChange(ItemCode: Code[10]; CurrStartDate: Date; CurrPrice: Decimal) PriceChanged: Text[1]
    var
        SalesPrice1: Record "Sales Price";
        CustomerRec: Record Customer;
        PrvEndDate: Date;
    begin
        IF CurrStartDate <> 0D Then
            PrvEndDate := CurrStartDate - 1;
        case SalesType of
            SalesType::Customer:
                BEGIN
                    CustomerRec.GET(SalesCode);
                    //Find Customer Price List
                    SalesPrice1.SETRANGE("Item No.", ItemCode);
                    SalesPrice1.SETRANGE("Sales Type", SalesPrice1."Sales Type"::Customer);
                    SalesPrice1.SETRANGE("Sales Code", CustomerRec."Bill-to Customer No.");
                    SalesPrice1.SETRANGE("Ending Date", PrvEndDate);
                    IF SalesPrice1.FINDFIRST THEN BEGIN
                        IF SalesPrice1."Unit Price" = CurrPrice THEN
                            EXIT('')
                        ELSE
                            EXIT('*');
                    END;
                END;
            SalesType::"Customer Price Group":
                BEGIN
                    SalesPrice1.RESET;
                    SalesPrice1.SETRANGE("Item No.", ItemCode);
                    SalesPrice1.SETRANGE("Sales Type", SalesPrice1."Sales Type"::"Price List Group");
                    SalesPrice1.SETRANGE("Sales Code", 'MARKET');
                    SalesPrice1.SETRANGE("Ending Date", PrvEndDate);
                    IF SalesPrice1.FINDFIRST THEN BEGIN
                        IF SalesPrice1."Unit Price" = CurrPrice THEN
                            EXIT('')
                        ELSE
                            EXIT('*');
                    END;
                END;

            SalesType::"All Customers":
                BEGIN
                    SalesPrice1.RESET;
                    SalesPrice1.SETRANGE("Item No.", ItemCode);
                    SalesPrice1.SETRANGE("Sales Type", SalesPrice1."Sales Type"::"All Customers");
                    SalesPrice1.SETRANGE("Ending Date", PrvEndDate);
                    IF SalesPrice1.FINDFIRST THEN BEGIN
                        IF SalesPrice1."Unit Price" = CurrPrice THEN
                            EXIT('')
                        ELSE
                            EXIT('*');
                    END;
                END;
        END




    end;

    var
        CompanyInformation: Record "Company Information";
        CustPriceGr: Record "Customer Price Group";
        Cust: Record Customer;
        Currency: Record Currency;
        CurrencyExchRate: Record "Currency Exchange Rate";
        SalesPrice: Record "Sales Price";
        Campaign: Record Campaign;
        DateReq: Date;
        MainTitle: Text[132];
        SubTitle: Text[132];
        ItemFilter: Text;
        Text000: Label 'List Price Sheet as of %1';
        Text001: Label 'Phone: %1';
        SalesType: Option Customer,"Customer Price Group","All Customers",Campaign,"Price List Group";
        SalesCode: Code[20];
        CustNo: Code[20];
        CustPriceGrCode: Code[20];
        CampNo: Code[20];
        AnySalesPriceFound: Boolean;
        ShowSalesType: Integer;
        [InDataSet]
        SalesCodeCtrlEnable: Boolean;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        ItemAttribute: Record "Item Attribute";
        Text002: Label 'Hello';
        PricePerUnit: Decimal;
        BaseUOM: Decimal;
        ItemValBool: Boolean;
        ItemValLetter: Text[10];
        ItemValLetter2: Text[10];
        Asterik: Text[1]; //EN1.01
        Decimals: Decimal; //EN1.01
        UnitPriceText: Text[30]; //EN1.01
}
