report 50001 "Sales - Order Conf. (Word)-HT"
{
    // version JF13.1.190961.0
    // Copyright Axentia Solutions Corp.  1999-2014.
    // By opening this object you acknowledge that this object includes confidential information and intellectual
    // property of Axentia Solutions Corp. and that this work is protected by Canadian, U.S. and international
    // copyright laws and agreements.
    // 
    // JF45105AC 20141209 - Word layout only: add standard JF Order functionality (Item Charge amounts, Lots, Sales UOM)
    // JF50231AC 20150626 - add fields for FPP
    // JF50297TK - 20150825 - Using HelperFunctions for blank zero
    // RD52230ATC 20151008 - add formatting to BlankZero HelperFunctions
    // RD53450ATC 20151026 - import revamped SPUOM-oriented layout
    // RD55210SHR 20160108 - renamed/renumber report
    // RD55218SHR 20160108 - removed rdlc layout
    // RD55699NH 20160118 - Modify to Standardize report.
    // RD55211ATC 20160907 - merge in base Nav 800CU1 -> 900CU10 changes from REP1305
    // RD65294NH 20161230 - fix total net weight for variable weight items
    // RD01163ATC 20171119 - merge in base Nav 110RTM -> 111CTP16 changes from REP1305
    // RD4269KNL 20171218 - fix error for non-lot tracked items
    // RD07295ATC 20180402 - update 20977 to 21229: compile fix
    // RD14851ATC 20181015 - merge in base Nav 111CTP16 -> 13RTM changes from REP1305
    // RD15826OPO 20181108 -  fix issue with comment line double
    RDLCLayout = './src/report/layouts/Rep50001.SalesOrderConfWordHT.rdl';
    //WordLayout = './src/report/layouts/Rep50001.SalesOrderConfWordHT.docx';
    UsageCategory = "ReportsAndAnalysis";
    ApplicationArea = "#JustFood";
    Caption = 'Sales - Order Conf. (Word)-HT';
    DefaultLayout = Word;
    PreviewMode = PrintLayout;
    WordMergeDataItem = "Sales Header";

    dataset
    {
        dataitem("Sales Header";
        "Sales Header")
        {
            DataItemTableView = SORTING ("Document Type", "No.") WHERE ("Document Type" = CONST (Order));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Order';

            dataitem(Labels;
            "Integer")
            {
                DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                MaxIteration = 1;

                column(CopyText; CopyText)
                {

                }


                column(PhoneNo_CompanyLbl;
                CompanyInfoPhoneNoLbl)
                {
                }
                column(GiroNo_CompanyLbl;
                CompanyInfoGiroNoLbl)
                {
                }
                column(BankName_CompanyLbl;
                CompanyInfoBankNameLbl)
                {
                }
                column(BankBranchNo_CompanyLbl;
                CompanyInfo.FieldCaption("Bank Branch No."))
                {
                }
                column(BankAccountNo_CompanyLbl;
                CompanyInfoBankAccNoLbl)
                {
                }
                column(IBAN_CompanyLbl;
                CompanyInfo.FieldCaption(IBAN))
                {
                }
                column(SWIFT_CompanyLbl;
                CompanyInfo.FieldCaption("SWIFT Code"))
                {
                }
                column(RegistrationNumber_CompanyLbl;
                CompanyInfo.GetRegistrationNumberLbl())
                {
                }
                column(VATRegNo_CompanyLbl;
                CompanyInfo.GetVATRegistrationNumberLbl())
                {
                }
                column(VATRegistrationNo_CompanyLbl;
                CompanyInfo.GetVATRegistrationNumberLbl())
                {
                }
                column(LegalOffice_CompanyLbl;
                CompanyInfo.GetLegalOfficeLbl())
                {
                }
                column(CustomGiro_CompanyLbl;
                CompanyInfo.GetCustomGiroLbl())
                {
                }
                column(YourReference_HeaderLbl;
                "Sales Header".FieldCaption("Your Reference"))
                {
                }
                column(ShipmentMethodDescription_HeaderLbl;
                ShptMethodDescLbl)
                {
                }
                column(ShipmentDate_HeaderLbl;
                "Sales Header".FieldCaption("Shipment Date"))
                {
                }
                column(Shipment_HeaderLbl;
                ShipmentLbl)
                {
                }
                column(ShipToAddress_HeaderLbl;
                ShiptoAddrLbl)
                {
                }
                column(PaymentTermsDescription_HeaderLbl;
                PaymentTermsDescLbl)
                {
                }
                column(PaymentMethodDescription_HeaderLbl;
                PaymentMethodDescLbl)
                {
                }
                column(BilltoCustomerNo_HeaderLbl;
                "Sales Header".FieldCaption("Bill-to Customer No."))
                {
                }
                column(DocumentDate_HeaderLbl;
                "Sales Header".FieldCaption("Document Date"))
                {
                }
                column(DueDate_HeaderLbl;
                "Sales Header".FieldCaption("Due Date"))
                {
                }
                column(DocumentNo_HeaderLbl;
                InvNoLbl)
                {
                }
                column(QuoteNo_HeaderLbl;
                "Sales Header".FieldCaption("Quote No."))
                {
                }
                column(PricesIncludingVATYesNoHeaderLbl;
                Format("Sales Header"."Prices Including VAT"))
                {
                }
                column(SalesPerson_HeaderLbl;
                SalespersonLbl)
                {
                }
                column(SalesPersonBlank_HeaderLbl;
                SalesPersonText)
                {
                }
                column(SelltoCustomerNo_HeaderLbl;
                "Sales Header".FieldCaption("Sell-to Customer No."))
                {
                }
                column(VATRegistrationNo_HeaderLbl;
                "Sales Header".GetCustomerVATRegistrationNumberLbl())
                {
                }
                column(GlobalLocationNumber_HeaderLbl;
                "Sales Header".GetCustomerGlobalLocationNumberLbl())
                {
                }
                column(LegalEntityType_HeaderLbl;
                Cust.GetLegalEntityTypeLbl())
                {
                }
                column(Copy_HeaderLbl;
                CopyLbl)
                {
                }
                column(EMail_HeaderLbl;
                EMailLbl)
                {
                }
                column(HomePage_HeaderLbl;
                HomePageLbl)
                {
                }
                column(InvoiceDiscountBaseAmount_HeaderLbl;
                InvDiscBaseAmtLbl)
                {
                }
                column(InvoiceDiscountAmount_HeaderLbl;
                InvDiscountAmtLbl)
                {
                }
                column(LineAmountAfterInvoiceDiscount_HeaderLbl;
                LineAmtAfterInvDiscLbl)
                {
                }
                column(LocalCurrency_HeaderLbl;
                LocalCurrencyLbl)
                {
                }
                column(Page_HeaderLbl;
                PageLbl)
                {
                }
                column(SalesInvoiceLineDiscount_HeaderLbl;
                SalesInvLineDiscLbl)
                {
                }
                column(Subtotal_HeaderLbl;
                SubtotalLbl)
                {
                }
                column(Total_HeaderLbl;
                TotalLbl)
                {
                }
                column(VATAmount_HeaderLbl;
                VATAmtLbl)
                {
                }
                column(VATBase_HeaderLbl;
                VATBaseLbl)
                {
                }
                column(VATAmountSpecification_HeaderLbl;
                VATAmtSpecificationLbl)
                {
                }
                column(VATClauses_HeaderLbl;
                VATClausesLbl)
                {
                }
                column(VATIdentifier_HeaderLbl;
                VATIdentifierLbl)
                {
                }
                column(VATPercentage_HeaderLbl;
                VATPercentageLbl)
                {
                }
                column(VATClause_Lbl;
                VATClause.TableCaption())
                {
                }
                column(PricesIncludingVAT_Lbl;
                "Sales Header".FieldCaption("Prices Including VAT"))
                {
                }
                column(AmountExcludingVAT_LineLbl;
                Line.FieldCaption(Amount))
                {
                }
                column(AmountIncludingVAT_LineLbl;
                Line.FieldCaption("Amount Including VAT"))
                {
                    AutoFormatExpression = "Sales Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(Description_LineLbl;
                Line.FieldCaption(Description))
                {
                }
                column(LineAmount_LineLbl;
                Line.FieldCaption("Line Amount"))
                {
                }
                column(ItemNo_LineLbl;
                Line.FieldCaption("No."))
                {
                }
                column(ShipmentDate_LineLbl;
                PostedShipmentDateLbl)
                {
                }
                column(Quantity_LineLbl;
                Line.FieldCaption(Quantity))
                {
                }
                column(UnitPrice_LineLbl;
                Line.FieldCaption("Unit Price"))
                {
                }
                column(UnitOfMeasure_LineLbl;
                Line.FieldCaption("Unit of Measure"))
                {
                }
                column(VATIdentifier_LineLbl;
                Line.FieldCaption("VAT Identifier"))
                {
                }
                column(VATPct_LineLbl;
                Line.FieldCaption("VAT %"))
                {
                }
                column(InvoiceDiscountAmount_VATAmountLineLbl;
                VATAmountLine.FieldCaption("Invoice Discount Amount"))
                {
                }
                column(InvoiceDiscountBaseAmount_VATAmountLineLbl;
                VATAmountLine.FieldCaption("Inv. Disc. Base Amount"))
                {
                }
                column(LineAmount_VatAmountLineLbl;
                VATAmountLine.FieldCaption("Line Amount"))
                {
                }
                column(VATAmount_VatAmountLineLbl;
                VATAmountLine.FieldCaption("VAT Amount"))
                {
                }
                column(VATAmountLCY_VATAmountLineLbl;
                VATAmountLCYLbl)
                {
                }
                column(VATBase_VatAmountLineLbl;
                VATAmountLine.FieldCaption("VAT Base"))
                {
                }
                column(VATBaseLCY_VATAmountLineLbl;
                VATBaseLCYLbl)
                {
                }
                column(VATIdentifier_VatAmountLineLbl;
                VATAmountLine.FieldCaption("VAT Identifier"))
                {
                }
                column(VATPct_VatAmountLineLbl;
                VATAmountLine.FieldCaption("VAT %"))
                {
                }
                column(VATClauseCode_VATClauseLineLbl;
                VATClause.FieldCaption(Code))
                {
                }
                column(AmountSubjectToSalesTax_TotalsLbl;
                AmtSubjecttoSalesTaxLbl)
                {
                }
                column(AmountExemptFromSalesTax_TotalsLbl;
                AmtExemptfromSalesTaxLbl)
                {
                }
            }
            dataitem(Company;
            "Integer")
            {
                DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                MaxIteration = 1;

                column(Address1_Company;
                CompanyAddr[1])
                {
                }
                column(Address2_Company;
                CompanyAddr[2])
                {
                }
                column(Address3_Company;
                CompanyAddr[3])
                {
                }
                column(Address4_Company;
                CompanyAddr[4])
                {
                }
                column(Address5_Company;
                CompanyAddr[5])
                {
                }
                column(Address6_Company;
                CompanyAddr[6])
                {
                }
                column(HomePage_Company;
                CompanyInfo."Home Page")
                {
                }
                column(EMail_Company;
                CompanyInfo."E-Mail")
                {
                }
                column(Picture_Company;
                CompanyInfo.Picture)
                {
                }
                column(PhoneNo_Company;
                CompanyInfo."Phone No.")
                {
                }
                column(GiroNo_Company;
                CompanyInfo."Giro No.")
                {
                }
                column(BankName_Company;
                CompanyInfo."Bank Name")
                {
                }
                column(BankBranchNo_Company;
                CompanyInfo."Bank Branch No.")
                {
                }
                column(BankAccountNo_Company;
                CompanyInfo."Bank Account No.")
                {
                }
                column(IBAN_Company;
                CompanyInfo.IBAN)
                {
                }
                column(SWIFT_Company;
                CompanyInfo."SWIFT Code")
                {
                }
                column(LogoPosition_Company;
                CompanyLogoPosition)
                {
                }
                column(RegistrationNumber_Company;
                CompanyInfo.GetRegistrationNumber())
                {
                }
                column(VATRegNo_Company;
                CompanyInfo.GetVATRegistrationNumber())
                {
                }
                column(VATRegistrationNo_Company;
                CompanyInfo.GetVATRegistrationNumber())
                {
                }
                column(LegalOffice_Company;
                CompanyInfo.GetLegalOffice())
                {
                }
                column(CustomGiro_Company;
                CompanyInfo.GetCustomGiro())
                {
                }
                column(LegalStatement_Company;
                "Sales Header".GetLegalStatement())
                {
                }
            }
            dataitem(Header;
            "Integer")
            {
                DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                MaxIteration = 1;

                column(AmtShipNotInv; "Sales Header"."Amt. Ship. Not Inv. (LCY)")
                {

                }

                column(AmtShipNotInvBase; "Sales Header"."Amt. Ship. Not Inv. (LCY) Base")
                {

                }

                column(DocumentNo_Header;
                "Sales Header"."No.")
                {
                }
                column(LocationCode_Header;
                "Sales Header"."Location Code")
                {
                }
                column(LocationName_Header;
                Location.Name)
                {
                }
                column(BilltoCustumerNo_Header;
                "Sales Header"."Bill-to Customer No.")
                {
                }
                column(CustomerAddress1_Header;
                CustAddr[1])
                {
                }
                column(CustomerAddress2_Header;
                CustAddr[2])
                {
                }
                column(CustomerAddress3_Header;
                CustAddr[3])
                {
                }
                column(CustomerAddress4_Header;
                CustAddr[4])
                {
                }
                column(CustomerAddress5_Header;
                CustAddr[5])
                {
                }
                column(CustomerAddress6_Header;
                CustAddr[6])
                {
                }
                column(CustomerAddress7_Header;
                CustAddr[7])
                {
                }
                column(CustomerAddress8_Header;
                CustAddr[8])
                {
                }
                column(SelltoCustomerNo_Header;
                "Sales Header"."Sell-to Customer No.")
                {
                }
                column(VATRegistrationNo_Header;
                "Sales Header".GetCustomerVATRegistrationNumber())
                {
                }
                column(GlobalLocationNumber_Header;
                "Sales Header".GetCustomerGlobalLocationNumber())
                {
                }
                column(LegalEntityType_Header;
                Cust.GetLegalEntityType())
                {
                }
                column(CustomerPostalBarCode_Header;
                FormatAddr.PostalBarCode(1))
                {
                }
                column(YourReference_Header;
                "Sales Header"."Your Reference")
                {
                }
                column(ShipToAddress1_Header;
                ShipToAddr[1])
                {
                }
                column(ShipToAddress2_Header;
                ShipToAddr[2])
                {
                }
                column(ShipToAddress3_Header;
                ShipToAddr[3])
                {
                }
                column(ShipToAddress4_Header;
                ShipToAddr[4])
                {
                }
                column(ShipToAddress5_Header;
                ShipToAddr[5])
                {
                }
                column(ShipToAddress6_Header;
                ShipToAddr[6])
                {
                }
                column(ShipToAddress7_Header;
                ShipToAddr[7])
                {
                }
                column(ShipToAddress8_Header;
                ShipToAddr[8])
                {
                }
                column(ShippingInstructions1_Header;
                "Sales Header"."Shipping Instructions")
                {
                }
                column(ShippingInstructions2_Header;
                "Sales Header"."Shipping Instructions 2")
                {
                }
                column(ShipVia_Header;
                "Sales Header"."Shipment Method Code")
                {
                }
                column(ShipmentMethodDescription_Header;
                ShipmentMethod.Description)
                {
                }
                column(ShipViaCode_Header;
                "Sales Header"."Shipping Agent Code")
                {
                }
                column(ShipmentDate_Header;
                Format("Sales Header"."Shipment Date", 0, 4))
                {
                }
                column(ShippingAgentName_Header;
                ShippingAgent.Name)
                {
                }
                column(ShowShippingAddress_Header;
                ShowShippingAddr)
                {
                }
                column(DocumentCopyText_Header;
                StrSubstNo(DocumentCaption(), CopyText))
                {
                }
                column(DocumentDate_Header;
                Format("Sales Header"."Document Date", 0, 4))
                {
                }
                column(DueDate_Header;
                Format("Sales Header"."Due Date", 0, 4))
                {
                }
                column(QuoteNo_Header;
                "Sales Header"."Quote No.")
                {
                }
                column(PricesIncludingVAT_Header;
                "Sales Header"."Prices Including VAT")
                {
                }
                column(ExchangeRateAsText_Header;
                ExchangeRateText)
                {
                }
                column(DocumentTitle_Header;
                SalesConfirmationLbl)
                {
                }
                column(ExternalDocNo_Header;
                "Sales Header"."External Document No.")
                {
                }
                column(SalesPersonCode_Header;
                "Sales Header"."Salesperson Code")
                {
                }
                column(SalesPersonName_Header;
                SalespersonPurchaser.Name)
                {
                }
                column(PaymentTermsCode_Header;
                "Sales Header"."Payment Terms Code")
                {
                }
                column(PaymentTermsDescription_Header;
                PaymentTerms.Description)
                {
                }
                column(PaymentMethodCode_Header;
                "Sales Header"."Payment Method Code")
                {
                }
                column(PaymentMethodDescription_Header;
                PaymentMethod.Description)
                {
                }
                column(LogisticsRouteNo_Header;
                "Sales Header"."Logistics Route No.") //DTP 20190503 - Per Customer's request
                {
                }
            }
            dataitem(Line;
            "Sales Line")
            {
                DataItemLink = "Document No." = FIELD ("No.");
                DataItemTableView = SORTING ("Document No.", "Line No.");
                UseTemporary = true;

                column(LineNo_Line;
                "Line No.")
                {
                }
                column(AmountExcludingVAT_Line;
                HelperFunctions.rdBlankZeroAmount(Amount, "Currency Code"))
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(AmountIncludingVAT_Line;
                HelperFunctions.rdBlankZeroAmount("Amount Including VAT", "Currency Code"))
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(Description_Line;
                Description)
                {
                }
                column(LineDiscountPercent_Line;
                HelperFunctions.BlankZero("Line Discount %"))
                {
                }
                column(LineDiscountPercentText_Line;
                LineDiscountPctText)
                {
                }
                column(LineAmount_Line;
                HelperFunctions.rdBlankZeroAmount("Line Amount", "Currency Code"))
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(ItemNo_Line;
                "No.")
                {
                }
                column(ShipmentDate_Line;
                Format("Shipment Date"))
                {
                }
                column(Quantity_Line;
                FormattedQuantity)
                {
                }
                column(Type_Line;
                Format(Type))
                {
                }
                column(UnitPrice_Line;
                FormattedUnitPrice)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 2;
                }
                column(UnitOfMeasure_Line;
                "Unit of Measure")
                {
                }
                column(VATIdentifier_Line;
                "VAT Identifier")
                {
                }
                column(VATPct_Line;
                FormattedVATPct)
                {
                }
                column(TransHeaderAmount_Line;
                HelperFunctions.rdBlankZeroAmount(TransHeaderAmount, "Currency Code"))
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(OriginalOrderQty_Line;
                Format(HelperFunctions.rdBlankZeroQuantity("Original Order Qty."), 0, '<Precision,0:5>'))
                {
                }
                column(UnitOfMeasureCode;
                "Unit of Measure Code")
                {
                }
                column(LineDiscountAmount_Line;
                HelperFunctions.rdBlankZeroPrice("Line Discount Amount", "Sales Header"."Currency Code"))
                {
                }
                column(QtyShipped_Line;
                "Quantity Shipped") //DTP 20190503 - Per Customer's request
                {
                }
                dataitem(ItemLine;
                Item)
                {
                    DataItemLink = "No." = FIELD ("No.");

                    column(ItemCategoryCode_ItemLine;
                    "Item Category Code")
                    {
                    }
                    column(ManufacturerCode_ItemLine;
                    "Manufacturer Code")
                    {
                    }
                    column(BrandCode_ItemLine;
                    "Brand Code")
                    {
                    }
                    column(ItemAttributeValue_ItemLine;
                    ItemAttributeValue.Value)
                    {
                    }
                    trigger OnAfterGetRecord()
                    var
                        ItemAttribute: Record "Item Attribute";
                        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
                    begin
                        //>>GTC
                        if Line.Type = Line.Type::Item then begin
                            clear(ItemAttribute);
                            clear(ItemAttributeValueMapping);
                            clear(ItemAttributeValue);
                            ItemAttribute.SetRange(Name, 'CATEGORY');
                            if ItemAttribute.FindFirst() then if ItemAttributeValueMapping.Get(DATABASE::Item, Line."No.", ItemAttribute.ID) then ItemAttributeValue.GET(ItemAttributeValueMapping."Item Attribute ID", ItemAttributeValueMapping."Item Attribute Value ID");
                        end;
                        //<<GTC
                    end;
                }
                dataitem(CustomerUOMLine;
                "Integer")
                {
                    DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                    MaxIteration = 1;

                    column(CustUOM_CustomerUOMLine;
                    gcodCustUOM)
                    {
                    }
                    column(CustUOMQty_CustomerUOMLine;
                    HelperFunctions.rdBlankZeroQuantity(gdecCustUOMQty))
                    {
                    }
                    column(CustUOMPrice_CustomerUOMLine;
                    HelperFunctions.rdBlankZeroPrice(gdecCustUOMPrice, "Sales Header"."Currency Code"))
                    {
                    }
                    column(CustomerUOMNumber_CustomerUOMLine;
                    Number)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        //<JF45105AC>
                        if ((gcodCustUOM = '')) then CurrReport.Skip();
                        //</JF45105AC>
                    end;
                }
                dataitem(AssemblyLine;
                "Assembly Line")
                {
                    DataItemTableView = SORTING ("Document No.", "Line No.");

                    column(LineNo_AssemblyLine;
                    "No.")
                    {
                    }
                    column(Description_AssemblyLine;
                    Description)
                    {
                    }
                    column(Quantity_AssemblyLine;
                    Format(HelperFunctions.rdBlankZeroQuantity(Quantity), 0, '<Precision,0:5>'))
                    {
                    }
                    column(UnitOfMeasure_AssemblyLine;
                    GetUOMText("Unit of Measure Code"))
                    {
                    }
                    column(VariantCode_AssemblyLine;
                    "Variant Code")
                    {
                    }
                    trigger OnPreDataItem()
                    begin
                        if not DisplayAssemblyInformation then CurrReport.Break();
                        if not AsmInfoExistsForLine then CurrReport.Break();
                        SetRange("Document Type", AsmHeader."Document Type");
                        SetRange("Document No.", AsmHeader."No.");
                    end;
                }
                dataitem(LotDetailLine;
                "Integer")
                {
                    DataItemTableView = SORTING (Number) WHERE (Number = FILTER (> 0));

                    column(LotCaption_LotDetailLine;
                    gtxtLotCaption)
                    {
                    }
                    column(LotNo_LotDetailLine;
                    gtxtLotNo[Number])
                    {
                    }
                    column(gtxtLotNo1_LotDetailLine;
                    gtxtLotNo[1])
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        //<JF45105AC>
                        if ((Number > 1)) then gtxtLotCaption := '';
                        //</JF45105AC>
                    end;

                    trigger OnPreDataItem()
                    begin
                        //<JF45105AC>
                        SetRange(Number, 1, gintDetailLineNo);
                        //</JF45105AC>
                    end;
                }
                dataitem(LotDetailVerticalShowLine;
                "Integer")
                {
                    DataItemTableView = SORTING (Number) WHERE (Number = FILTER (> 0));
                    MaxIteration = 0;

                    column(LotNo_LotDetailVerticalShowLine;
                    gtxtLotNo2[Number])
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        //<RD55699NH>
                        if Number > 1 then;
                        //</RD55699NH>
                    end;

                    trigger OnPreDataItem()
                    begin
                        //<RD55699NH>
                        SetRange(Number, 1, gintLotsFound);
                        //</RD55699NH>
                    end;
                }
                trigger OnAfterGetRecord()
                var
                    lItem: Record Item;
                    lItemTrackingCode: Record "Item Tracking Code";
                    ldecLNWToShip: Decimal;
                    ldecLNWShipped: Decimal;
                    ldecLNWTotal: Decimal;
                    ldecLNWToInvoice: Decimal;
                    ldecLNWInvoiced: Decimal;
                begin
                    //<RD53450ATC>
                    Clear(gLineWeight);
                    //</RD53450ATC>
                    if Type = Type::"G/L Account" then "No." := '';
                    if "Line Discount %" = 0 then
                        LineDiscountPctText := ''
                    else
                        LineDiscountPctText := StrSubstNo('%1%', -Round("Line Discount %", 0.1));
                    if DisplayAssemblyInformation then AsmInfoExistsForLine := AsmToOrderExists(AsmHeader);
                    TransHeaderAmount += PrevLineAmount;
                    PrevLineAmount := "Line Amount";
                    TotalSubTotal += "Line Amount";
                    TotalInvDiscAmount -= "Inv. Discount Amount";
                    TotalAmount += Amount;
                    TotalAmountVAT += "Amount Including VAT" - Amount;
                    TotalAmountInclVAT += "Amount Including VAT";
                    TotalPaymentDiscOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");
                    //<RD55699NH>
                    // Deleted Code
                    //<JF45105AC>
                    Clear(gtxtLotCaption);
                    Clear(gtxtLotNo);
                    Clear(gintDetailLineNo);
                    if Type = Type::Item then nsjjGetLotNo();
                    if (Type = Type::"Charge (Item)") and ("No." = SalesSetup."Sales-Freight Item Charge") and not "Include IC in Unit Price" then gdecFRChargeAmt := gdecFRChargeAmt + "Line Amount";
                    if (Type = Type::"Charge (Item)") and ("No." = SalesSetup."Sales-Allowance Item Charge") and not "Include IC in Unit Price" then gdecSALChargeAmt := gdecSALChargeAmt + "Line Amount";
                    grecSalesLine.SetRange("Document Type", "Document Type");
                    grecSalesLine.SetRange("Document No.", "Document No.");
                    grecSalesLine.SetRange("Attached to Line No.", "Line No.");
                    grecSalesLine.SetRange(Type, grecSalesLine.Type::"Charge (Item)");
                    grecSalesLine.SetRange("Include IC in Unit Price", true);
                    if grecSalesLine.Find('-') then
                        repeat
                            "Line Amount" += grecSalesLine."Line Amount";
                            if Quantity = 0 then
                                "Unit Price" := 0
                            else
                                "Unit Price" := Round(("Line Amount" + "Line Discount Amount") / Quantity, 0.00001);
                        until grecSalesLine.Next() = 0;
                    FormatDocument.SetSalesLine(Line, FormattedQuantity, FormattedUnitPrice, FormattedVATPct, FormattedLineAmount);
                    if (Type = Type::"Charge (Item)") and ("Attached to Line No." <> 0) and "Include IC in Unit Price" then "Line Amount" := 0;
                    if "Gross Weight" = 0 then "Gross Weight" := "Net Weight";
                    gdecGrossWeight += Round(Quantity * "Gross Weight", 0.00001);
                    //<RD53450ATC>
                    gcodCustUOM := "Unit of Measure Code";
                    gdecCustUOMQty := Quantity;
                    gdecCustUOMPrice := "Unit Price";
                    //</RD53450ATC>
                    if ("Sales Price Unit of Measure" <> '') and ("Sales Price Unit of Measure" <> "Unit of Measure Code") and (Type = Type::Item) then begin
                        gcodCustUOM := "Sales Price Unit of Measure";
                        grecItemUOM.Get("No.", "Sales Price Unit of Measure");
                        if grecItemUOM."Qty. per Unit of Measure" < 1 then begin
                            grecItemUOM.TestField("Qty. per Base UOM");
                            gdecCustUOMQty := "Quantity (Base)" * grecItemUOM."Qty. per Base UOM";
                            //</RD65294NH> code deleted
                        end
                        else
                            gdecCustUOMQty := "Quantity (Base)" / grecItemUOM."Qty. per Unit of Measure";
                        //</RD65294NH> code deleted
                    end;
                    //</JF45105AC>
                    //<RD65294NH>
                    if Type = Type::Item then begin
                        lItem.Get("No.");
                        //<RD4269KNL>
                        if lItemTrackingCode.Get(lItem."Item Tracking Code") then
                            if (lItemTrackingCode."Variable Weight Tracking") and ((lItemTrackingCode."Lot Specific Tracking") or (lItemTrackingCode."Lot Sales Outbound Tracking") or (lItemTrackingCode."SN Specific Tracking") or (lItemTrackingCode."SN Sales Outbound Tracking")) then begin
                                jfCalcNetWeightFields(ldecLNWTotal, ldecLNWToShip, ldecLNWShipped, ldecLNWToInvoice, ldecLNWInvoiced);
                                gdecCustUOMQty := ldecLNWTotal;
                            end;
                        //<RD4269KNL>
                    end;
                    if (gdecCustUOMQty > 0) then gdecCustUOMPrice := Round(("Line Amount" + "Line Discount Amount") / gdecCustUOMQty, 0.00001);
                    //</RD65294NH>
                    //<RD53450ATC>
                    if ((Type = Type::Item)) then begin
                        lItem.Get("No.");
                        gLineWeight := lItem."Net Weight" * "Quantity (Base)";
                    end;
                    gTotalWeight += gLineWeight;
                    //</RD53450ATC>
                    //<JF50231AC>
                    if ((Type = Type::Item)) then begin
                        gdecTotalUnitCount += Quantity;
                        gdecTotalShippeddQty += "Quantity Shipped"; //DTP 20190503 - Per Customer's request
                    end;
                    //</JF50231AC>
                end;

                trigger OnPreDataItem()
                begin
                    //<RD55699NH>
                    //Deleted Code
                    FirstLineHasBeenOutput := false;
                    CompanyInfo.Picture := TempBlobCompanyLogo.Blob;
                end;
            }
            dataitem(WorkDescriptionLines;
            "Integer")
            {
                DataItemTableView = SORTING (Number) WHERE (Number = FILTER (1 .. 99999));

                column(WorkDescriptionLineNumber;
                Number)
                {
                }
                column(WorkDescriptionLine;
                WorkDescriptionLine)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if not TempBlobWorkDescription.MoreTextLines() then CurrReport.Break();
                    WorkDescriptionLine := TempBlobWorkDescription.ReadTextLine();
                end;

                trigger OnPostDataItem()
                begin
                    Clear(TempBlobWorkDescription);
                end;

                trigger OnPreDataItem()
                begin
                    if not ShowWorkDescription then CurrReport.Break();
                    TempBlobWorkDescription.Blob := "Sales Header"."Work Description";
                end;
            }
            dataitem(VATAmountLine;
            "VAT Amount Line")
            {
                DataItemTableView = SORTING ("VAT Identifier", "VAT Calculation Type", "Tax Group Code", "Use Tax", Positive);
                UseTemporary = true;

                column(InvoiceDiscountAmount_VATAmountLine;
                HelperFunctions.rdBlankZeroAmount("Invoice Discount Amount", "Sales Header"."Currency Code"))
                {
                    AutoFormatExpression = "Sales Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(InvoiceDiscountBaseAmount_VATAmountLine;
                HelperFunctions.rdBlankZeroAmount("Inv. Disc. Base Amount", "Sales Header"."Currency Code"))
                {
                    AutoFormatExpression = "Sales Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(LineAmount_VatAmountLine;
                HelperFunctions.rdBlankZeroAmount("Line Amount", "Sales Header"."Currency Code"))
                {
                    AutoFormatExpression = "Sales Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmount_VatAmountLine;
                HelperFunctions.rdBlankZeroAmount("VAT Amount", "Sales Header"."Currency Code"))
                {
                    AutoFormatExpression = "Sales Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmountLCY_VATAmountLine;
                HelperFunctions.rdBlankZeroAmount(VATAmountLCY, ''))
                {
                }
                column(VATBase_VatAmountLine;
                HelperFunctions.rdBlankZeroAmount("VAT Base", "Sales Header"."Currency Code"))
                {
                    AutoFormatExpression = "Sales Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATBaseLCY_VATAmountLine;
                HelperFunctions.rdBlankZeroAmount(VATBaseLCY, ''))
                {
                }
                column(VATIdentifier_VatAmountLine;
                "VAT Identifier")
                {
                }
                column(VATPct_VatAmountLine;
                Format(HelperFunctions.rdBlankZeroQuantity("VAT %"), 0, '<Precision,0:5>'))
                {
                }
                column(NoOfVATIdentifiers;
                Count())
                {
                }
                trigger OnAfterGetRecord()
                begin
                    VATBaseLCY := GetBaseLCY("Sales Header"."Posting Date", "Sales Header"."Currency Code", "Sales Header"."Currency Factor");
                    VATAmountLCY := GetAmountLCY("Sales Header"."Posting Date", "Sales Header"."Currency Code", "Sales Header"."Currency Factor");
                    TotalVATBaseLCY += VATBaseLCY;
                    TotalVATAmountLCY += VATAmountLCY;
                    if "VAT Clause Code" <> '' then begin
                        VATClauseLine := VATAmountLine;
                        if VATClauseLine.Insert() then;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    TotalVATBaseLCY := 0;
                    TotalVATAmountLCY := 0;
                    VATClauseLine.DeleteAll();
                end;
            }
            dataitem(VATClauseLine;
            "VAT Amount Line")
            {
                UseTemporary = true;

                column(VATIdentifier_VATClauseLine;
                "VAT Identifier")
                {
                }
                column(Code_VATClauseLine;
                VATClause.Code)
                {
                }
                column(Description_VATClauseLine;
                VATClause.Description)
                {
                }
                column(Description2_VATClauseLine;
                VATClause."Description 2")
                {
                }
                column(VATAmount_VATClauseLine;
                HelperFunctions.rdBlankZeroAmount("VAT Amount", "Sales Header"."Currency Code"))
                {
                    AutoFormatExpression = "Sales Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(NoOfVATClauses_VATClauseLine;
                Count())
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if "VAT Clause Code" = '' then CurrReport.Skip();
                    if not VATClause.Get("VAT Clause Code") then CurrReport.Skip();
                    VATClause.TranslateDescription("Sales Header"."Language Code");
                end;
            }
            dataitem(ChargeTotalsLine;
            "Integer")
            {
                DataItemTableView = SORTING (Number) WHERE (Number = FILTER (1 .. 4));

                column(ChargeDescription_ChargeTotalsLine;
                gtxtChargeDescription)
                {
                }
                column(ChargeAmount_ChargeTotalsLine;
                HelperFunctions.rdBlankZeroAmount(gdecChargeAmount, "Sales Header"."Currency Code"))
                {
                    AutoFormatType = 1;
                }
                trigger OnAfterGetRecord()
                var
                    lctxtFreight: Label 'Freight:';
                    lctxtAllowance: Label 'Allowance:';
                begin
                    //<JF45105AC>
                    case Number of
                        1:
                            begin
                                if ((VATAmountLine.GetAmtExemptFromSalesTax() = 0)) then CurrReport.Skip();
                                gdecChargeAmount := VATAmountLine.GetAmtExemptFromSalesTax();
                                gtxtChargeDescription := AmtExemptfromSalesTaxLbl;
                            end;
                        2:
                            begin
                                if ((VATAmountLine.GetAmtSubjectToSalesTax() = 0)) then CurrReport.Skip();
                                gdecChargeAmount := VATAmountLine.GetAmtSubjectToSalesTax();
                                gtxtChargeDescription := AmtSubjecttoSalesTaxLbl;
                            end;
                        3:
                            begin
                                if ((gdecFRChargeAmt = 0)) then CurrReport.Skip();
                                gdecChargeAmount := gdecFRChargeAmt;
                                gtxtChargeDescription := lctxtFreight;
                            end;
                        4:
                            begin
                                if ((gdecSALChargeAmt = 0)) then CurrReport.Skip();
                                gdecChargeAmount := gdecSALChargeAmt;
                                gtxtChargeDescription := lctxtAllowance;
                            end;
                        else
                            FieldError(Number);
                    end;
                    //</JF45105AC>
                end;
            }
            dataitem(OrdConfComments;
            "Sales Comment Line")
            {
                DataItemLink = "Document Type" = FIELD ("Document Type"), "No." = FIELD ("No.");
                DataItemTableView = WHERE ("Print On Order Confirmation" = CONST (true));

                column(Comment_OrdConf;
                Comment)
                {
                }
            }
            dataitem(PickComments;
            "Sales Comment Line")
            {
                DataItemLink = "Document Type" = FIELD ("Document Type"), "No." = FIELD ("No.");
                DataItemTableView = WHERE ("Print On Pick Ticket" = CONST (true));
                RequestFilterHeading = 'Pick Comments ';

                column(Comment_Pick;
                Comment)
                {
                }
            }
            dataitem(ReportTotalsLine;
            "Report Totals Buffer")
            {
                DataItemTableView = SORTING ("Line No.");
                UseTemporary = true;

                column(Description_ReportTotalsLine;
                Description)
                {
                }
                column(Amount_ReportTotalsLine;
                HelperFunctions.rdBlankZeroAmount(Amount, "Sales Header"."Currency Code"))
                {
                }
                column(AmountFormatted_ReportTotalsLine;
                "Amount Formatted")
                {
                }
                column(FontBold_ReportTotalsLine;
                "Font Bold")
                {
                }
                column(FontUnderline_ReportTotalsLine;
                "Font Underline")
                {
                }
                trigger OnPreDataItem()
                begin
                    CreateReportTotalLines();
                end;
            }
            dataitem(LetterText;
            "Integer")
            {
                DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));

                column(GreetingText;
                GreetingLbl)
                {
                }
                column(BodyText;
                BodyLbl)
                {
                }
                column(ClosingText;
                ClosingLbl)
                {
                }
                column(PmtDiscText;
                PmtDiscText)
                {
                }
                trigger OnPreDataItem()
                begin
                    PmtDiscText := '';
                    if "Sales Header"."Payment Discount %" <> 0 then PmtDiscText := StrSubstNo(PmtDiscTxt, "Sales Header"."Pmt. Discount Date", "Sales Header"."Payment Discount %");
                end;
            }
            dataitem(Totals;
            "Integer")
            {
                DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));

                column(TotalNetAmount_Totals;
                HelperFunctions.rdBlankZeroAmount(TotalAmount, "Sales Header"."Currency Code"))
                {
                    AutoFormatExpression = "Sales Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalVATBaseLCY_Totals;
                HelperFunctions.rdBlankZeroAmount(TotalVATBaseLCY, ''))
                {
                }
                column(TotalAmountIncludingVAT_Totals;
                HelperFunctions.rdBlankZeroAmount(TotalAmountInclVAT, "Sales Header"."Currency Code"))
                {
                    AutoFormatExpression = "Sales Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalVATAmount_Totals;
                HelperFunctions.rdBlankZeroAmount(TotalAmountVAT, "Sales Header"."Currency Code"))
                {
                    AutoFormatExpression = "Sales Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalVATAmountLCY_Totals;
                HelperFunctions.rdBlankZeroAmount(TotalVATAmountLCY, ''))
                {
                }
                column(TotalInvoiceDiscountAmount_Totals;
                HelperFunctions.rdBlankZeroAmount(TotalInvDiscAmount, "Sales Header"."Currency Code"))
                {
                    AutoFormatExpression = "Sales Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalPaymentDiscountOnVAT_Totals;
                HelperFunctions.rdBlankZeroAmount(TotalPaymentDiscOnVAT, "Sales Header"."Currency Code"))
                {
                }
                column(TotalVATAmountText_Totals;
                VATAmountLine.VATAmountText())
                {
                }
                column(TotalExcludingVATText_Totals;
                TotalExclVATText)
                {
                }
                column(TotalIncludingVATText_Totals;
                TotalInclVATText)
                {
                }
                column(TotalSubTotal;
                HelperFunctions.rdBlankZeroAmount(TotalSubTotal, "Sales Header"."Currency Code"))
                {
                    AutoFormatExpression = "Sales Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalSubTotalMinusInvoiceDiscount_Totals;
                HelperFunctions.rdBlankZeroAmount(TotalSubTotal + TotalInvDiscAmount, "Sales Header"."Currency Code"))
                {
                }
                column(TotalText_Totals;
                TotalText)
                {
                }
                column(AmountSubjectToSalesTax_Totals;
                HelperFunctions.rdBlankZeroAmount(VATAmountLine.GetAmtSubjectToSalesTax(), "Sales Header"."Currency Code"))
                {
                }
                column(AmountExemptFromSalesTax_Totals;
                HelperFunctions.rdBlankZeroAmount(VATAmountLine.GetAmtExemptFromSalesTax(), "Sales Header"."Currency Code"))
                {
                }
                column(TotalUnitCount_Totals;
                HelperFunctions.rdBlankZeroQuantity(gdecTotalUnitCount))
                {
                }
                column(TotalQtyShipped_Totals;
                HelperFunctions.rdBlankZeroQuantity(gdecTotalShippeddQty)) //DTP 20190503 - Per Customer's request
                {
                }
                column(TotalWeight_Totals;
                HelperFunctions.rdBlankZeroQuantity(gTotalWeight))
                {
                }
            }
            trigger OnAfterGetRecord()
            var
                CurrencyExchangeRate: Record "Currency Exchange Rate";
                ArchiveManagement: Codeunit ArchiveManagement;
                SalesPost: Codeunit "Sales-Post";
            begin
                CalcFields("Amt. Ship. Not Inv. (LCY)", "Amt. Ship. Not Inv. (LCY) Base");
                FirstLineHasBeenOutput := false;
                //<JF45105AC>
                Clear(gdecFRChargeAmt);
                Clear(gdecSALChargeAmt);
                Clear(gdecGrossWeight);
                //</JF45105AC>
                Clear(Line);
                Clear(SalesPost);
                VATAmountLine.DeleteAll();
                Line.DeleteAll();
                SalesPost.GetSalesLines("Sales Header", Line, 0);
                if "Tax Area Code" = '' then begin
                    Line.CalcVATAmountLines(0, "Sales Header", Line, VATAmountLine);
                    Line.UpdateVATOnLines(0, "Sales Header", Line, VATAmountLine)
                end
                else
                    Line.CalcSalesTaxLines("Sales Header", Line);
                if not IsReportInPreviewMode() then CODEUNIT.Run(CODEUNIT::"Sales-Printed", "Sales Header");
                CurrReport.Language := Language.GetLanguageID("Language Code");
                CalcFields("Work Description");
                ShowWorkDescription := "Work Description".HasValue();
                FormatAddr.GetCompanyAddr("Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
                FormatAddr.SalesHeaderBillTo(CustAddr, "Sales Header");
                ShowShippingAddr := FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, "Sales Header");
                if not Cust.Get("Bill-to Customer No.") then Clear(Cust);
                if "Currency Code" <> '' then begin
                    CurrencyExchangeRate.FindCurrency("Posting Date", "Currency Code", 1);
                    CalculatedExchRate := Round(1 / "Currency Factor" * CurrencyExchangeRate."Exchange Rate Amount", 0.000001);
                    ExchangeRateText := StrSubstNo(ExchangeRateTxt, CalculatedExchRate, CurrencyExchangeRate."Exchange Rate Amount");
                end;
                FormatDocumentFields("Sales Header");
                if not IsReportInPreviewMode() and (CurrReport.UseRequestPage() and ArchiveDocument or not CurrReport.UseRequestPage() and SalesSetup."Archive Orders") then ArchiveManagement.StoreSalesDocument("Sales Header", LogInteraction);
                TotalSubTotal := 0;
                TotalInvDiscAmount := 0;
                TotalAmount := 0;
                TotalAmountVAT := 0;
                TotalAmountInclVAT := 0;
                TotalPaymentDiscOnVAT := 0;
                //<JF45105AC>
                if not grecShipAgent.Get("Shipping Agent Code") then Clear(grecShipAgent);
                if "No. Pallets" <> 0 then
                    gtxtPallets := 'No. Pallets:'
                else
                    gtxtPallets := '';
                //</JF45105AC>
                //<JF50231AC>
                Clear(gdecTotalUnitCount);
                //</JF50231AC>
                clear(gdecTotalShippeddQty); //DTP 20190503 - Per Customer's request
                                             //<RD53450ATC>
                Clear(gTotalWeight);
                //</RD53450ATC>
                //<RD54708NH>
                if "Location Code" <> '' then Location.Get("Location Code");
                if "Shipping Agent Code" <> '' then ShippingAgent.Get("Shipping Agent Code");
                //</RD54708NH>
            end;

            trigger OnPreDataItem()
            begin
                FirstLineHasBeenOutput := false;
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

                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies if you want to record the related interactions with the involved contact person in the Interaction Log Entry table.';
                    }
                    field(DisplayAsmInformation; DisplayAssemblyInformation)
                    {
                        ApplicationArea = Assembly;
                        Caption = 'Show Assembly Components';
                        ToolTip = 'Specifies if you want the report to include information about components that were used in linked assembly orders that supplied the item(s) being sold.';
                        Visible = false;
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Archive Document';
                        ToolTip = 'Specifies if the document is archived after you print it.';

                        trigger OnValidate()
                        begin
                            if not ArchiveDocument then LogInteraction := false;
                        end;
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnInit()
        begin
            LogInteractionEnable := true;
            ArchiveDocument := SalesSetup."Archive Orders";
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction();
            LogInteractionEnable := LogInteraction;
        end;
    }
    labels
    {
    }
    trigger OnInitReport()
    begin
        GLSetup.Get();
        CompanyInfo.SetAutoCalcFields(Picture);
        CompanyInfo.Get();
        SalesSetup.Get();
        CompanyInfo.VerifyAndSetPaymentInfo();
        TempBlobCompanyLogo.Blob := CompanyInfo.Picture;
        TempBlobCompanyLogo.Insert();
    end;

    trigger OnPostReport()
    begin
        if LogInteraction and not IsReportInPreviewMode() then
            if "Sales Header".FindSet() then
                repeat
                    "Sales Header".CalcFields("No. of Archived Versions");
                    if "Sales Header"."Bill-to Contact No." <> '' then
                        SegManagement.LogDocument(3, "Sales Header"."No.", "Sales Header"."Doc. No. Occurrence", "Sales Header"."No. of Archived Versions", DATABASE::Contact, "Sales Header"."Bill-to Contact No.", "Sales Header"."Salesperson Code", "Sales Header"."Campaign No.", "Sales Header"."Posting Description", "Sales Header"."Opportunity No.")
                    else
                        SegManagement.LogDocument(3, "Sales Header"."No.", "Sales Header"."Doc. No. Occurrence", "Sales Header"."No. of Archived Versions", DATABASE::Customer, "Sales Header"."Bill-to Customer No.", "Sales Header"."Salesperson Code", "Sales Header"."Campaign No.", "Sales Header"."Posting Description", "Sales Header"."Opportunity No.");
                until Header.Next() = 0;
    end;

    trigger OnPreReport()
    begin
        if "Sales Header".GetFilters() = '' then Error(NoFilterSetErr);
        if not CurrReport.UseRequestPage() then InitLogInteraction();
        CompanyLogoPosition := SalesSetup."Logo Position on Documents";
    end;

    var
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        TempBlobCompanyLogo: Record TempBlob temporary;
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        RespCenter: Record "Responsibility Center";
        Language: Record Language;
        VATClause: Record "VAT Clause";
        AsmHeader: Record "Assembly Header";
        TempBlobWorkDescription: Record TempBlob;
        grecShipAgent: Record "Shipping Agent";
        grecSalesLine: Record "Sales Line";
        grecItemUOM: Record "Item Unit of Measure";
        ShippingAgent: Record "Shipping Agent";
        Location: Record Location;
        ItemAttributeValue: Record "Item Attribute Value";
        HelperFunctions: Codeunit "Word Report Helper Functions";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        SalesConfirmationLbl: Label 'Order Confirmation';
        SalespersonLbl: Label 'Sales person';
        CompanyInfoBankAccNoLbl: Label 'Account No.';
        CompanyInfoBankNameLbl: Label 'Bank';
        CompanyInfoGiroNoLbl: Label 'Giro No.';
        CompanyInfoPhoneNoLbl: Label 'Phone No.';
        CopyLbl: Label 'Copy';
        EMailLbl: Label 'Email';
        HomePageLbl: Label 'Home Page';
        InvDiscBaseAmtLbl: Label 'Invoice Discount Base Amount';
        InvDiscountAmtLbl: Label 'Invoice Discount';
        InvNoLbl: Label 'Order No.';
        LineAmtAfterInvDiscLbl: Label 'Payment Discount on VAT';
        LocalCurrencyLbl: Label 'Local Currency';
        PageLbl: Label 'Page';
        PaymentTermsDescLbl: Label 'Payment Terms';
        PaymentMethodDescLbl: Label 'Payment Method';
        PostedShipmentDateLbl: Label 'Shipment Date';
        SalesInvLineDiscLbl: Label 'Discount %';
        ShipmentLbl: Label 'Shipment';
        ShiptoAddrLbl: Label 'Ship-to Address';
        ShptMethodDescLbl: Label 'Shipment Method';
        SubtotalLbl: Label 'Subtotal';
        TotalLbl: Label 'Total';
        VATAmtSpecificationLbl: Label 'Tax Amount Specification';
        VATAmtLbl: Label 'Tax Amount';
        VATAmountLCYLbl: Label 'Tax Amount ($)';
        VATBaseLbl: Label 'Tax Base';
        VATBaseLCYLbl: Label 'Tax Base ($)';
        VATClausesLbl: Label 'Tax Clause';
        VATIdentifierLbl: Label 'Tax Identifier';
        VATPercentageLbl: Label 'Tax %';
        CustAddr: array[8] of Text[90];
        ShipToAddr: array[8] of Text[90];
        CompanyAddr: array[8] of Text[90];
        SalesPersonText: Text[50];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        LineDiscountPctText: Text;
        FormattedVATPct: Text;
        FormattedUnitPrice: Text;
        FormattedQuantity: Text;
        FormattedLineAmount: Text;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
        TransHeaderAmount: Decimal;
        [InDataSet]
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        AsmInfoExistsForLine: Boolean;
        CompanyLogoPosition: Integer;
        FirstLineHasBeenOutput: Boolean;
        CalculatedExchRate: Decimal;
        ExchangeRateText: Text;
        ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = '%1 and %2 are both amounts.';
        VATBaseLCY: Decimal;
        VATAmountLCY: Decimal;
        TotalVATBaseLCY: Decimal;
        TotalVATAmountLCY: Decimal;
        PrevLineAmount: Decimal;
        NoFilterSetErr: Label 'You must specify one or more filters to avoid accidently printing all documents.';
        GreetingLbl: Label 'Hello';
        ClosingLbl: Label 'Sincerely';
        PmtDiscTxt: Label 'If we receive the payment before %1, you are eligible for a 2% payment discount.', Comment = '%1 Discount Due Date %2 = value of Payment Discount % ';
        BodyLbl: Label 'Thank you for your business. Your order confirmation is attached to this message.';
        PmtDiscText: Text;
        ShowWorkDescription: Boolean;
        WorkDescriptionLine: Text;
        AmtSubjecttoSalesTaxLbl: Label 'Amount Subject to Sales Tax';
        AmtExemptfromSalesTaxLbl: Label 'Amount Exempt from Sales Tax';
        gdecFRChargeAmt: Decimal;
        gdecSALChargeAmt: Decimal;
        gdecGrossWeight: Decimal;
        gtxtPallets: Text[30];
        gintDetailLineNo: Integer;
        gtxtLotCaption: Text[30];
        gtxtLotNo: array[1000] of Text[250];
        gcodCustUOM: Code[10];
        gdecCustUOMQty: Decimal;
        gdecCustUOMPrice: Decimal;
        gtxtChargeDescription: Text[30];
        gdecChargeAmount: Decimal;
        gdecTotalUnitCount: Decimal;
        gLineWeight: Decimal;
        gTotalWeight: Decimal;
        gtxtLotNo2: array[250] of Text;
        gintLotsFound: Integer;
        TotalTaxLbl: Label 'Total Tax';
        gdecTotalShippeddQty: Decimal; //DTP 20190503 - Per Customer's request

    procedure SetCopyText(pCopyText: Text[30])
    begin
        CopyText := pCopyText;
    end;

    local procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(3) <> '';
    end;

    local procedure DocumentCaption(): Text[250]
    begin
        exit(SalesConfirmationLbl);
    end;

    [Scope('Personalization')]
    procedure InitializeRequest(NewLogInteraction: Boolean;
    DisplayAsmInfo: Boolean)
    begin
        LogInteraction := NewLogInteraction;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview() or MailManagement.IsHandlingGetEmailBody());
    end;

    local procedure FormatDocumentFields(SalesHeader: Record "Sales Header")
    begin
        with SalesHeader do begin
            FormatDocument.SetTotalLabels("Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
            FormatDocument.SetSalesPerson(SalespersonPurchaser, "Salesperson Code", SalesPersonText);
            FormatDocument.SetPaymentTerms(PaymentTerms, "Payment Terms Code", "Language Code");
            FormatDocument.SetPaymentMethod(PaymentMethod, "Payment Method Code", "Language Code");
            FormatDocument.SetShipmentMethod(ShipmentMethod, "Shipment Method Code", "Language Code");
        end;
    end;

    local procedure GetUOMText(UOMCode: Code[10]): Text[10]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.Get(UOMCode) then exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;

    local procedure CreateReportTotalLines()
    var
        TempSalesTaxAmountLine: Record "Sales Tax Amount Line" temporary;
        TaxArea: Record "Tax Area";
    begin
        ReportTotalsLine.DeleteAll();
        if "Sales Header"."Tax Area Code" <> '' then if TaxArea.Get("Sales Header"."Tax Area Code") then;
        if ("Sales Header"."Tax Area Code" = '') or (TaxArea."Country/Region" = TaxArea."Country/Region"::US) then begin
            CreateUSReportTotalLines();
            exit;
        end;
        if (TotalInvDiscAmount <> 0) or (TotalAmountVAT <> 0) then ReportTotalsLine.Add(SubtotalLbl, TotalSubTotal, true, false, false);
        if TotalInvDiscAmount <> 0 then begin
            ReportTotalsLine.Add(InvDiscountAmtLbl, TotalInvDiscAmount, false, false, false);
            if TotalAmountVAT <> 0 then ReportTotalsLine.Add(TotalExclVATText, TotalAmount, true, false, false);
        end;
        if TotalAmountVAT <> 0 then begin
            GetTaxSummarizedLines(TempSalesTaxAmountLine);
            TempSalesTaxAmountLine.SetCurrentKey("Print Order");
            TempSalesTaxAmountLine.Ascending(true);
            if TempSalesTaxAmountLine.FindSet() then
                repeat
                    ReportTotalsLine.Add(TempSalesTaxAmountLine."Print Description", TempSalesTaxAmountLine."Tax Amount", false, true, false);
                until TempSalesTaxAmountLine.Next() = 0;
        end;
    end;

    local procedure CreateUSReportTotalLines()
    begin
        ReportTotalsLine.DeleteAll();
        ReportTotalsLine.Add(SubtotalLbl, TotalSubTotal, true, false, false);
        ReportTotalsLine.Add(InvDiscountAmtLbl, TotalInvDiscAmount, false, false, false);
        ReportTotalsLine.Add(TotalTaxLbl, TotalAmountVAT, false, true, false);
    end;

    local procedure GetTaxSummarizedLines(var TempSalesTaxAmountLine: Record "Sales Tax Amount Line" temporary)
    var
        TaxArea: Record "Tax Area";
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
    begin
        if not TaxArea.Get("Sales Header"."Tax Area Code") then exit;
        SalesTaxCalculate.StartSalesTaxCalculation();
        Line.SetRange("Document Type", "Sales Header"."Document Type");
        Line.SetRange("Document No.", "Sales Header"."No.");
        Line.SetFilter(Type, '>0');
        Line.SetFilter(Quantity, '<>0');
        if Line.Find('-') then
            repeat
                if not TaxArea."Use External Tax Engine" then SalesTaxCalculate.AddSalesLine(Line);
            until Line.Next() = 0;
        TempSalesTaxAmountLine.DeleteAll();
        if TaxArea."Use External Tax Engine" then
            SalesTaxCalculate.CallExternalTaxEngineForSales("Sales Header", true)
        else
            SalesTaxCalculate.EndSalesTaxCalculation("Sales Header"."Posting Date");
        SalesTaxCalculate.GetSalesTaxAmountLineTable(TempSalesTaxAmountLine);
        SalesTaxCalculate.GetSummarizedSalesTaxTable(TempSalesTaxAmountLine);
    end;

    local procedure nsjjGetLotNo(): Text[30]
    var
        lrecItem: Record Item;
        lrecReservEntry: Record "Reservation Entry";
        lrecTrackingSpecification: Record "Tracking Specification";
        lintCount: Integer;
        lintCountonEachLine: Integer;
    begin
        //<JF45105AC>
        //How many charators to print on each line
        lintCountonEachLine := 100;
        gintDetailLineNo := 0;
        //<RD54708NH>
        gintLotsFound := 0;
        //</RD54708NH>
        lrecReservEntry.Reset();
        lrecReservEntry.SetCurrentKey("Source ID", "Source Ref. No.", "Source Type", "Source Subtype");
        lrecReservEntry.SetRange("Source ID", Line."Document No.");
        lrecReservEntry.SetRange("Source Ref. No.", Line."Line No.");
        lrecReservEntry.SetRange("Source Type", 37);
        lrecReservEntry.SetRange("Source Subtype", Line."Document Type");
        if lrecReservEntry.Find('-') then begin
            if gintDetailLineNo = 0 then gintDetailLineNo := 1;
            lrecItem.Get(lrecReservEntry."Item No.");
            repeat
                if lrecReservEntry."Lot No." <> '' then begin
                    gtxtLotCaption := 'Lot No.:';
                    if (StrLen(gtxtLotNo[gintDetailLineNo]) + StrLen(lrecReservEntry."Lot No.") + StrLen(Format(-lrecReservEntry."Quantity (Base)")) + StrLen(Format(lrecItem."Base Unit of Measure")) + 6) < lintCountonEachLine then begin
                        if lintCount = 0 then
                            gtxtLotNo[gintDetailLineNo] := lrecReservEntry."Lot No." + ' (' + Format(-lrecReservEntry."Quantity (Base)") + ' ' + Format(lrecItem."Base Unit of Measure") + ')'
                        else
                            gtxtLotNo[gintDetailLineNo] := gtxtLotNo[gintDetailLineNo] + ', ' + lrecReservEntry."Lot No." + ' (' + Format(-lrecReservEntry."Quantity (Base)") + ' ' + Format(lrecItem."Base Unit of Measure") + ')';
                        lintCount := lintCount + 1;
                    end
                    else begin
                        gintDetailLineNo += 1;
                        lintCount := 0;
                        if lintCount = 0 then
                            gtxtLotNo[gintDetailLineNo] := lrecReservEntry."Lot No." + ' (' + Format(-lrecReservEntry."Quantity (Base)") + ' ' + Format(lrecItem."Base Unit of Measure") + ')'
                        else
                            gtxtLotNo[gintDetailLineNo] := gtxtLotNo[gintDetailLineNo] + ', ' + lrecReservEntry."Lot No." + ' (' + Format(-lrecReservEntry."Quantity (Base)") + ' ' + Format(lrecItem."Base Unit of Measure") + ')';
                        lintCount := lintCount + 1;
                    end;
                    //<RD55699NH>
                    // Iteration for Vertical show.
                    gintLotsFound := gintLotsFound + 1;
                    gtxtLotNo2[gintLotsFound] := lrecReservEntry."Lot No." + ' (' + Format(-lrecReservEntry."Quantity (Base)") + ' ' + Format(lrecItem."Base Unit of Measure") + ')';
                    //</RD55699NH>
                end;
            until lrecReservEntry.Next() = 0;
        end;
        lrecTrackingSpecification.SetCurrentKey("Source ID", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
        lrecTrackingSpecification.SetRange("Source ID", Line."Document No.");
        lrecTrackingSpecification.SetRange("Source Type", DATABASE::"Sales Line");
        lrecTrackingSpecification.SetRange("Source Subtype", Line."Document Type");
        lrecTrackingSpecification.SetRange("Source Batch Name", '');
        lrecTrackingSpecification.SetRange("Source Prod. Order Line", 0);
        lrecTrackingSpecification.SetRange("Source Ref. No.", Line."Line No.");
        if lrecTrackingSpecification.Find('-') then begin
            if gintDetailLineNo = 0 then gintDetailLineNo := 1;
            lrecItem.Get(lrecTrackingSpecification."Item No.");
            repeat
                if lrecTrackingSpecification."Lot No." <> '' then begin
                    gtxtLotCaption := 'Lot No.:';
                    if (StrLen(gtxtLotNo[gintDetailLineNo]) + StrLen(lrecTrackingSpecification."Lot No.") + StrLen(Format(-lrecTrackingSpecification."Quantity (Base)")) + StrLen(Format(lrecItem."Base Unit of Measure")) + 6) < lintCountonEachLine then begin
                        if lintCount = 0 then
                            gtxtLotNo[gintDetailLineNo] := lrecTrackingSpecification."Lot No." + ' (' + Format(-lrecTrackingSpecification."Quantity (Base)") + ' ' + Format(lrecItem."Base Unit of Measure") + ')'
                        else
                            gtxtLotNo[gintDetailLineNo] := gtxtLotNo[gintDetailLineNo] + ', ' + lrecTrackingSpecification."Lot No." + ' (' + Format(-lrecTrackingSpecification."Quantity (Base)") + ' ' + Format(lrecItem."Base Unit of Measure") + ')';
                        lintCount := lintCount + 1;
                    end
                    else begin
                        gintDetailLineNo += 1;
                        lintCount := 0;
                        if lintCount = 0 then
                            gtxtLotNo[gintDetailLineNo] := lrecTrackingSpecification."Lot No." + ' (' + Format(-lrecTrackingSpecification."Quantity (Base)") + ' ' + Format(lrecItem."Base Unit of Measure") + ')'
                        else
                            gtxtLotNo[gintDetailLineNo] := gtxtLotNo[gintDetailLineNo] + ', ' + lrecTrackingSpecification."Lot No." + ' (' + Format(-lrecTrackingSpecification."Quantity (Base)") + ' ' + Format(lrecItem."Base Unit of Measure") + ')';
                        lintCount := lintCount + 1;
                    end;
                    //<RD55699NH>
                    // Iteration for Vertical show.
                    gintLotsFound := gintLotsFound + 1;
                    gtxtLotNo2[gintLotsFound] := lrecTrackingSpecification."Lot No." + ' (' + Format(-lrecTrackingSpecification."Quantity (Base)") + ' ' + Format(lrecItem."Base Unit of Measure") + ')';
                    //</RD55699NH>
                end;
            until lrecTrackingSpecification.Next() = 0;
        end;
        if gtxtLotNo[1] = '' then gintDetailLineNo := 0;
        //</JF45105AC>
    end;

    local procedure jfCalcNetWeightFields(var pdecLNWTotal: Decimal;
    var pdecLNWToShip: Decimal;
    var pdecLNWShipped: Decimal;
    var pdecLNWToInvoice: Decimal;
    var pdecLNWInvoiced: Decimal)
    var
        lcduCWMgt: Codeunit "Catch Weight Management";
        lrfRecordRef: RecordRef;
    begin
        //<RD65294NH>
        pdecLNWToShip := 0;
        pdecLNWShipped := 0;
        pdecLNWTotal := 0;
        pdecLNWToInvoice := 0;
        pdecLNWInvoiced := 0;
        lrfRecordRef.GetTable(Line);
        lcduCWMgt.jfCalcNetWeightTotals(DATABASE::"Sales Line", lrfRecordRef, pdecLNWTotal, pdecLNWToShip, pdecLNWShipped, pdecLNWToInvoice, pdecLNWInvoiced, 0);
        //</RD65294NH>
    end;
}
