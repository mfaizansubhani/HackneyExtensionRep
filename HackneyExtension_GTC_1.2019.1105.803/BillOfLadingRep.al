report 50006 "Posted Whse. Shipment - HT"
{
    // Copyright Axentia Solutions Corp.  1999-2015.
    // By opening this object you acknowledge that this object includes confidential information and intellectual
    // property of Axentia Solutions Corp. and that this work is protected by Canadian, U.S. and international
    // copyright laws and agreements.
    // 
    // JF48674AC 20150429 - new report based on a Save-As of
    //                    - major change: page break per Source document
    //                    - added Word Layout
    // JF50231AC 20150626 - add fields for FPP
    // JF50297TK - 20150825 - Using HelperFunctions for blank zero
    // RD52230ATC 20151008 - add formatting to BlankZero HelperFunctions
    // RD53093ATC 20151013 - import revamped layout
    // RD55215SHR 20160108 - renamed report
    // RD55218SHR 20160108 - removed rdlc layout
    // RD55697NH 20160127 - Modify to Standardize report.
    // RD59633MG 20160614 - Replace hard-coded weight caption with Standard Weight UOM from Inventory Setup
    // RD62954ATC 20160919 - renumber Word Report Helper Functions
    // RD15608SHR 20181029 - Increase Address variables from 50 to 90
    RDLCLayout = './src/report/layouts/Posted Whse. Shipment (Word).rdlc';
    WordLayout = './src/report/layouts/Posted Whse. Shipment (Word).docx';
    UsageCategory = "ReportsAndAnalysis";
    ApplicationArea = All;
    Caption = 'Posted Whse. Shipment (Word) - HT';
    DefaultLayout = Word;
    WordMergeDataItem = SourceDocument;

    dataset
    {
        dataitem(PostedWhseShipmentHeader; "Posted Whse. Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                //<RD55697NH>
                Header.Init;
                Header := PostedWhseShipmentHeader;
                Header.Insert;

                gintSourceDocumentCount := 0;
                grecPostedWhseShipmentLine.Reset;
                grecPostedWhseShipmentLine.SetRange("No.", "No.");
                if grecPostedWhseShipmentLine.FindSet then
                    repeat

                        Line.Init;
                        Line := grecPostedWhseShipmentLine;
                        Line.Insert;

                        SourceDocument.Reset;
                        SourceDocument.SetRange("No.", grecPostedWhseShipmentLine."No.");
                        SourceDocument.SetRange("Source Type", grecPostedWhseShipmentLine."Source Type");
                        SourceDocument.SetRange("Source Subtype", grecPostedWhseShipmentLine."Source Subtype");
                        SourceDocument.SetRange("Source No.", grecPostedWhseShipmentLine."Source No.");
                        if SourceDocument.IsEmpty then begin
                            SourceDocument.Init;
                            SourceDocument := grecPostedWhseShipmentLine;
                            gintSourceDocumentCount += 1;
                            SourceDocument."Line No." := gintSourceDocumentCount;
                            SourceDocument.Insert;
                        end;
                    until grecPostedWhseShipmentLine.Next = 0;

                SourceDocument.Reset;
                //</RD55697NH>

                //<RD59633MG>
                gInventorySetup.Get;
                //</RD59633MG>
            end;
        }
        dataitem(SourceDocument; "Posted Whse. Shipment Line")
        {
            DataItemTableView = SORTING("No.", "Line No.");
            UseTemporary = true;
            dataitem(Labels; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                MaxIteration = 1;
                column(PhoneNo_CompanyLbl; CompanyInfoPhoneNoLbl)
                {
                }
                column(GiroNo_CompanyLbl; CompanyInfoGiroNoLbl)
                {
                }
                column(BankName_CompanyLbl; CompanyInfoBankNameLbl)
                {
                }
                column(BankBranchNo_CompanyLbl; CompanyInfo.FieldCaption("Bank Branch No."))
                {
                }
                column(BankAccountNo_CompanyLbl; CompanyInfoBankAccNoLbl)
                {
                }
                column(IBAN_CompanyLbl; CompanyInfo.FieldCaption(IBAN))
                {
                }
                column(SWIFT_CompanyLbl; CompanyInfo.FieldCaption("SWIFT Code"))
                {
                }
                column(VATRegNo_CompanyLbl; CompanyInfo.GetVATRegistrationNumberLbl)
                {
                }
                column(RegistrationNumber_CompanyLbl; CompanyInfo.GetRegistrationNumberLbl)
                {
                }
                column(VATRegistrationNo_CompanyLbl; CompanyInfo.GetVATRegistrationNumberLbl)
                {
                }
                column(LegalOffice_CompanyLbl; CompanyInfo.GetLegalOfficeLbl)
                {
                }
                column(CustomGiro_CompanyLbl; CompanyInfo.GetCustomGiroLbl)
                {
                }
                column(AssgndUID_HeaderLbl; Header.FieldCaption("Assigned User ID"))
                {
                }
                column(LocCode_HeaderLbl; Header.FieldCaption("Location Code"))
                {
                }
                column(No_HeaderLbl; Header.FieldCaption("No."))
                {
                }
                column(CurrReportPAGENO_HeaderLbl; CurrReportPAGENOCaptionLbl)
                {
                }
                column(WarehousePostedShipment_HeaderLbl; WarehousePostedShipmentCaptionLbl)
                {
                }
                column(ExternalDocumentNo_HeaderLbl; lblExternalDocumentNo)
                {
                }
                column(PaymentTerms_HeaderLbl; lblPaymentTerms)
                {
                }
                column(ShipVia_HeaderLbl; lblShipVia)
                {
                }
                column(ShippingAgentCode_Lbl; lblShippingAgentCode)
                {
                }
                column(ShippingAgentServiceCode_HeaderLbl; lblShippingAgentServiceCode)
                {
                }
                column(BillToPhoneNo_HeaderLbl; lblBillToPhoneNo)
                {
                }
                column(SellToPhoneNo_HeaderLbl; lblSellToPhoneNo)
                {
                }
                column(ShipToPhoneNo_HeaderLbl; lblShipToPhoneNo)
                {
                }
                column(Salespserson_HeaderLbl; lblSalespserson)
                {
                }
                column(Ship_HeaderLbl; lblShip)
                {
                }
                column(From_HeaderLbl; lblFrom)
                {
                }
                column(ShelfNo_LineLbl; Line.FieldCaption("Shelf No."))
                {
                }
                column(ItemNo_LineLbl; Line.FieldCaption("Item No."))
                {
                }
                column(Desc_LineLbl; Line.FieldCaption(Description))
                {
                }
                column(UOM_LineLbl; Line.FieldCaption("Unit of Measure Code"))
                {
                }
                column(Qty_LineLbl; Line.FieldCaption(Quantity))
                {
                }
                column(SourceNo_LineLbl; Line.FieldCaption("Source No."))
                {
                }
                column(SourceDoc_LineLbl; Line.FieldCaption("Source Document"))
                {
                }
                column(ZoneCode_LineLbl; Line.FieldCaption("Zone Code"))
                {
                }
                column(BinCode_LineLbl; Line.FieldCaption("Bin Code"))
                {
                }
                column(LocCode_LineLbl; Line.FieldCaption("Location Code"))
                {
                }
                column(ShelfZone_LineLbl; gtxtShelfZoneCaption)
                {
                }
                column(ShelfZoneValue_LineLbl; gtxtShelfZoneValue)
                {
                }
            }
            dataitem(Company; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                MaxIteration = 1;
                column(Address1_Company; gtxtCompanyAddress[1])
                {
                }
                column(Address2_Company; gtxtCompanyAddress[2])
                {
                }
                column(Address3_Company; gtxtCompanyAddress[3])
                {
                }
                column(Address4_Company; gtxtCompanyAddress[4])
                {
                }
                column(Address5_Company; gtxtCompanyAddress[5])
                {
                }
                column(Address6_Company; gtxtCompanyAddress[6])
                {
                }
                column(Address7_Company; gtxtCompanyAddress[7])
                {
                }
                column(Address8_Company; gtxtCompanyAddress[8])
                {
                }
                column(HomePage_Company; CompanyInfo."Home Page")
                {
                }
                column(EMail_Company; CompanyInfo."E-Mail")
                {
                }
                column(Picture_Company; CompanyInfo.Picture)
                {
                }
                column(PhoneNo_Company; CompanyInfo."Phone No.")
                {
                }
                column(GiroNo_Company; CompanyInfo."Giro No.")
                {
                }
                column(BankName_Company; CompanyInfo."Bank Name")
                {
                }
                column(BankBranchNo_Company; CompanyInfo."Bank Branch No.")
                {
                }
                column(BankAccountNo_Company; CompanyInfo."Bank Account No.")
                {
                }
                column(IBAN_Company; CompanyInfo.IBAN)
                {
                }
                column(SWIFT_Company; CompanyInfo."SWIFT Code")
                {
                }
                column(RegistrationNumber_Company; CompanyInfo.GetRegistrationNumber)
                {
                }
                column(VATRegNo_Company; CompanyInfo.GetVATRegistrationNumber)
                {
                }
                column(VATRegistrationNo_Company; CompanyInfo.GetVATRegistrationNumber)
                {
                }
                column(LegalOffice_Company; CompanyInfo.GetLegalOffice)
                {
                }
                column(CustomGiro_Company; CompanyInfo.GetCustomGiro)
                {
                }
            }
            dataitem(Header; "Posted Whse. Shipment Header")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("No.");
                UseTemporary = true;
                column(CompanyName_Header; CompanyName)
                {
                }
                column(UserID_Header; UserId)
                {
                }
                column(TodayFormatted_Header; Format(Today, 0, 4))
                {
                }
                column(AssgndUID_Header; Header."Assigned User ID")
                {
                }
                column(No_Header; Header."No.")
                {
                }
                column(SourceType_Header; SourceDocument."Source Type")
                {
                }
                column(SourceSubtype_Header; SourceDocument."Source Subtype")
                {
                }
                column(SourceNo_Header; SourceDocument."Source No.")
                {
                }
                column(LocCode_Header; Header."Location Code")
                {
                }
                column(LocName_Header; Location.Name)
                {
                }
                column(BinMandatoryShow1_Header; not Location."Bin Mandatory")
                {
                }
                column(BinMandatoryShow2_Header; Location."Bin Mandatory")
                {
                }
                column(ShipmentMethodCode_Header; grecTempSourceDocument."Shipment Method Code")
                {
                }
                column(ShipmentMethodDesc_Header; grecShipmentMethod.Description)
                {
                }
                column(PaymentTermsCode_Header; grecTempSourceDocument."Payment Terms Code")
                {
                }
                column(PaymentTermsDesc_Header; grecPaymentTerms.Description)
                {
                }
                column(SalesPurchPersonCode_Header; grecTempSourceDocument."Salesperson Code")
                {
                }
                column(SalesPurchPersonName_Header; grecSalesPurchPerson.Name)
                {
                }
                column(ExternalDocumentNo_Header; grecTempSourceDocument."External Document No.")
                {
                }
                column(ShippingAgentCode_Header; grecTempSourceDocument."Shipping Agent Code")
                {
                }
                column(ShippingAgentName_Header; ShippingAgent.Name)
                {
                }
                column(ShippingAgentServiceCode_Header; grecTempSourceDocument."Shipping Agent Service Code")
                {
                }
                column(ShippingInstructions1_Header; grecTempSourceDocument."Shipping Instructions")
                {
                }
                column(ShippingInstructions2_Header; grecTempSourceDocument."Shipping Instructions 2")
                {
                }
                column(BillToAddress1_Header; gtxtBillToAddress[1])
                {
                }
                column(BillToAddress2_Header; gtxtBillToAddress[2])
                {
                }
                column(BillToAddress3_Header; gtxtBillToAddress[3])
                {
                }
                column(BillToAddress4_Header; gtxtBillToAddress[4])
                {
                }
                column(BillToAddress5_Header; gtxtBillToAddress[5])
                {
                }
                column(BillToAddress6_Header; gtxtBillToAddress[6])
                {
                }
                column(BillToAddress7_Header; gtxtBillToAddress[7])
                {
                }
                column(BillToAddress8_Header; gtxtBillToAddress[8])
                {
                }
                column(BillToPhone_Header; gtxtBillToPhone)
                {
                }
                column(ShipToAddress1_Header; gtxtShipToAddress[1])
                {
                }
                column(ShipToAddress2_Header; gtxtShipToAddress[2])
                {
                }
                column(ShipToAddress3_Header; gtxtShipToAddress[3])
                {
                }
                column(ShipToAddress4_Header; gtxtShipToAddress[4])
                {
                }
                column(ShipToAddress5_Header; gtxtShipToAddress[5])
                {
                }
                column(ShipToAddress6_Header; gtxtShipToAddress[6])
                {
                }
                column(ShipToAddress7_Header; gtxtShipToAddress[7])
                {
                }
                column(ShipToAddress8_Header; gtxtShipToAddress[8])
                {
                }
                column(ShipToPhone_Header; gtxtShipToPhone)
                {
                }
                column(ShipFromAddress1_Header; gtxtShipFromAddress[1])
                {
                }
                column(ShipFromAddress2_Header; gtxtShipFromAddress[2])
                {
                }
                column(ShipFromAddress3_Header; gtxtShipFromAddress[3])
                {
                }
                column(ShipFromAddress4_Header; gtxtShipFromAddress[4])
                {
                }
                column(ShipFromAddress5_Header; gtxtShipFromAddress[5])
                {
                }
                column(ShipFromAddress6_Header; gtxtShipFromAddress[6])
                {
                }
                column(ShipFromAddress7_Header; gtxtShipFromAddress[7])
                {
                }
                column(ShipFromAddress8_Header; gtxtShipFromAddress[8])
                {
                }
                column(SellToPhone_Header; gtxtSellToPhone)
                {
                }
                column(PostingDateFormatted_Header; Format(Header."Posting Date", 0, 4))
                {
                }
                column(SellToCustomerNo_Header; grecTempSourceDocument."Sell-to Customer No.")
                {
                }
                column(ExternalDocNo_Header; grecTempSourceDocument."External Document No.")
                {
                }
                column(OrderDate_Header; Format(grecTempSourceDocument."Order Date"))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    GetLocation("Location Code");

                    if (
                      ("External Document No." <> '')
                      and (grecTempSourceDocument."External Document No." = '')
                    ) then begin
                        grecTempSourceDocument."External Document No." := "External Document No.";
                    end;

                    if (
                      ("Shipping Agent Code" <> '')
                    ) then begin
                        grecTempSourceDocument."Shipping Agent Code" := "Shipping Agent Code";
                    end;
                    if (
                      ("Shipping Agent Service Code" <> '')
                    ) then begin
                        grecTempSourceDocument."Shipping Agent Service Code" := "Shipping Agent Service Code";
                    end;
                    if (
                      ("Shipment Method Code" <> '')
                    ) then begin
                        grecTempSourceDocument."Shipment Method Code" := "Shipment Method Code";
                    end;

                    Clear(grecShipmentMethod);
                    Clear(grecPaymentTerms);
                    Clear(grecSalesPurchPerson);

                    with grecTempSourceDocument do begin
                        if (
                          ("Shipment Method Code" <> '')
                        ) then begin
                            grecShipmentMethod.Get("Shipment Method Code");
                        end;

                        if (
                          ("Payment Terms Code" <> '')
                        ) then begin
                            grecPaymentTerms.Get("Payment Terms Code");
                        end;

                        if (
                          ("Salesperson Code" <> '')
                        ) then begin
                            grecSalesPurchPerson.Get("Salesperson Code");
                        end;

                        //<RD55697NH>
                        if "Shipping Agent Code" <> '' then
                            ShippingAgent.Get("Shipping Agent Code");
                        //</RD55697NH>

                    end;

                    Clear(gdecTotalNetWeight);
                    Clear(gdecTotalQuantity);
                    //</JF48674AC>
                end;
            }
            dataitem(Line; "Posted Whse. Shipment Line")
            {
                DataItemLink = "No." = FIELD("No."), "Source Type" = FIELD("Source Type"), "Source Subtype" = FIELD("Source Subtype"), "Source No." = FIELD("Source No.");
                DataItemLinkReference = SourceDocument;
                DataItemTableView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                UseTemporary = true;
                column(ShelfNo_Line; "Shelf No.")
                {
                }
                column(ItemNo_Line; "Item No.")
                {
                }
                column(Desc_Line; Description)
                {
                }
                column(UOM_Line; "Unit of Measure Code")
                {
                }
                column(LocCode_Line; "Location Code")
                {
                }
                column(Qty_Line; HelperFunctions.rdBlankZeroDecimalWithFormat(Quantity, '<Precision,2:2><Standard Format,0>'))
                {
                }
                column(SourceNo_Line; "Source No.")
                {
                }
                column(SourceDoc_Line; "Source Document")
                {
                }
                column(ZoneCode_Line; "Zone Code")
                {
                }
                column(BinCode_Line; "Bin Code")
                {
                }
                column(LineNo_Line; Line."Line No.")
                {
                }
                column(LineNetWeight_Line; HelperFunctions.rdBlankZeroDecimalWithFormat("Line Net Weight", '<Precision,2:2><Standard Format,0>'))
                {
                }
                dataitem(ItemLine; Item)
                {
                    DataItemLink = "No." = FIELD("Item No.");
                    column(ItemCategoryCode_ItemLine; "Item Category Code")
                    {
                    }
                    column(ManufacturerCode_ItemLine; "Manufacturer Code")
                    {
                    }
                    column(BrandCode_ItemLine; "Brand Code")
                    {
                    }
                    column(SpecialEquipment_ItemLine; "Special Equipment Code")
                    {
                    }
                }
                dataitem(LotDetailLine; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = FILTER(> 0));
                    column(LotCaption_LotDetailLine; gtxtLotDetail)
                    {
                    }
                    column(LotNo_LotDetailLine; gtxtLotNo[Number])
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if Number > 1 then begin
                        end;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetRange(Number, 1, gintDetailLineNo);
                    end;
                }
                dataitem(LotDetailVerticalShowLine; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(LotCaption_LotDetailVerticalShowLine; gtxtLotDetail)
                    {
                    }
                    column(LotDetail_LotDetailVerticalShowLine; grecILETMP.Description)
                    {
                    }
                    column(SerialNo_LotDetailVerticalShowLine; grecILETMP."Serial No.")
                    {
                    }
                    column(LotNo_LotDetailVerticalShowLine; grecILETMP."Lot No.")
                    {
                    }
                    column(Quantity_LotDetailVerticalShowLine; HelperFunctions.rdBlankZeroDecimalWithFormat(grecILETMP.Quantity, '<Precision,2:2><Standard Format,0>'))
                    {
                    }
                    column(BaseUnitOfMeasure_LotDetailLine; grecItem."Base Unit of Measure")
                    {
                    }
                    column(NetWeight_LotDetailVerticalShowLine; HelperFunctions.rdBlankZeroDecimalWithFormat(Abs(grecILETMP."Net Weight"), '<Precision,2:2><Standard Format,0>'))
                    {
                    }
                    column(WeightUOM_LotDetailVerticalShowLine; gInventorySetup."Standard Weight UOM")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if Number <> 1 then
                            grecILETMP.Next;

                        if Number = 1 then
                            gtxtLotDetail := JFText001
                        else
                            gtxtLotDetail := '';
                    end;

                    trigger OnPreDataItem()
                    begin
                        if not gblnPrintLotDetail then
                            CurrReport.Break;

                        if grecILETMP.Count = 0 then
                            CurrReport.Break;

                        SetRange(Number, 1, grecILETMP.Count);
                        grecILETMP.Find('-');
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    if gblnPrintLotDetail then
                        //<RD55697NH>
                        rdGetGetLotNo();
                    //</RD55697NH>

                    //<JF48674AC>
                    gdecTotalNetWeight += "Line Net Weight";
                    gdecTotalQuantity += Quantity;

                    if (
                      (Location."Bin Mandatory")
                    ) then begin
                        gtxtShelfZoneCaption := Line.FieldCaption("Zone Code");
                        gtxtShelfZoneValue := Line."Zone Code";
                        gtxtBinCodeCaption := Line.FieldCaption("Bin Code");
                    end else begin
                        gtxtShelfZoneCaption := Line.FieldCaption("Shelf No.");
                        gtxtShelfZoneValue := Line."Shelf No.";
                        gtxtBinCodeCaption := '';
                    end;
                    //</JF48674AC>
                end;
            }
            dataitem(CommentLine; "Warehouse Comment Line")
            {
                DataItemLinkReference = SourceDocument;
                DataItemTableView = SORTING("Table Name", Type, "No.", "Line No.");
                UseTemporary = true;
                column(Comment_CommentLine; CommentLine.Comment)
                {
                }
            }
            dataitem(Totals; "Integer")
            {
                DataItemTableView = SORTING(Number);
                MaxIteration = 1;
                column(TotalNetWeight_Totals; HelperFunctions.rdBlankZeroDecimalWithFormat(gdecTotalNetWeight, '<Precision,2:2><Standard Format,0>'))
                {
                    //DecimalPlaces = 0:5;
                }
                column(TotalQuantity_Totals; HelperFunctions.rdBlankZeroDecimalWithFormat(gdecTotalQuantity, '<Precision,2:2><Standard Format,0>'))
                {
                    //DecimalPlaces = 0:5;
                }
                column(WeightUOM_Totals; gInventorySetup."Standard Weight UOM")
                {
                }
            }

            trigger OnAfterGetRecord()
            var
                lrecSalesShipmentHeader: Record "Sales Shipment Header";
                lrecReturnShipmentHeader: Record "Return Shipment Header";
                lrecTransferShipmentHeader: Record "Transfer Shipment Header";
                lrecSellToCustomer: Record Customer;
                lrecBillToCustomer: Record Customer;
                lrecShipToAddress: Record "Ship-to Address";
                lrecBuyFromVendor: Record Vendor;
                lrecPayToVendor: Record Vendor;
                lrecTransferToLocation: Record Location;
            begin
                //<JF48674AC>
                Clear(grecTempSourceDocument);

                Clear(gtxtBillToPhone);
                Clear(gtxtSellToPhone);
                Clear(gtxtShipToPhone);

                Clear(gtxtBillToAddress);
                Clear(gtxtShipToAddress);


                //<<EN1.00
                if ((lrecSalesShipmentHeader.Get("Posted Source No."))) then begin
                    lrecSellToCustomer.Get(lrecSalesShipmentHeader."Sell-to Customer No.");
                    if lrecSellToCustomer."Print on Document" = lrecSellToCustomer."Print on Document"::"Pro-Forma" then
                        CurrReport.Skip();
                end;
                //>>EN1.00

                case SourceDocument."Posted Source Document" of
                    "Posted Source Document"::"Posted Shipment":
                        begin
                            if (
                              (lrecSalesShipmentHeader.Get("Posted Source No."))
                            ) then begin

                                grecTempSourceDocument."External Document No." := lrecSalesShipmentHeader."External Document No.";
                                grecTempSourceDocument."Salesperson Code" := lrecSalesShipmentHeader."Salesperson Code";
                                grecTempSourceDocument."Shipping Agent Code" := lrecSalesShipmentHeader."Shipping Agent Code";
                                grecTempSourceDocument."Shipping Agent Service Code" := lrecSalesShipmentHeader."Shipping Agent Service Code";
                                grecTempSourceDocument."Shipment Method Code" := lrecSalesShipmentHeader."Shipment Method Code";
                                grecTempSourceDocument."Payment Terms Code" := lrecSalesShipmentHeader."Payment Terms Code";

                                //<RD55697NH>
                                grecTempSourceDocument."Sell-to Customer No." := lrecSalesShipmentHeader."Sell-to Customer No.";
                                grecTempSourceDocument."External Document No." := lrecSalesShipmentHeader."External Document No.";
                                grecTempSourceDocument."Order Date" := lrecSalesShipmentHeader."Order Date";
                                grecTempSourceDocument."Shipping Instructions" := lrecSalesShipmentHeader."Shipping Instructions";
                                grecTempSourceDocument."Shipping Instructions 2" := lrecSalesShipmentHeader."Shipping Instructions 2";
                                //</RD55697NH>


                                lrecBillToCustomer.Get(lrecSalesShipmentHeader."Bill-to Customer No.");
                                lrecSellToCustomer.Get(lrecSalesShipmentHeader."Sell-to Customer No.");
                                if (
                                  (lrecShipToAddress.Get(lrecSalesShipmentHeader."Sell-to Customer No.", lrecSalesShipmentHeader."Ship-to Code"))
                                ) then begin
                                    ;
                                end;
                                gtxtBillToPhone := Format(lrecBillToCustomer."Phone No.");
                                gtxtSellToPhone := Format(lrecSellToCustomer."Phone No.");
                                gtxtShipToPhone := Format(lrecShipToAddress."Phone No.");

                                gcduFormatAddress.SalesShptBillTo(gtxtBillToAddress, gtxtBillToAddress, lrecSalesShipmentHeader);
                                gcduFormatAddress.SalesShptShipTo(gtxtShipToAddress, lrecSalesShipmentHeader);

                            end;

                        end;
                    "Posted Source Document"::"Posted Return Shipment":
                        begin
                            if (
                              (lrecReturnShipmentHeader.Get("Posted Source No."))
                            ) then begin

                                // no "External Document No."
                                grecTempSourceDocument."Salesperson Code" := lrecReturnShipmentHeader."Purchaser Code";
                                // no "Shipping Agent Service Code", "Shipping Agent Service Code"
                                grecTempSourceDocument."Shipment Method Code" := lrecReturnShipmentHeader."Shipment Method Code";
                                grecTempSourceDocument."Payment Terms Code" := lrecReturnShipmentHeader."Payment Terms Code";

                                //<RD55697NH>
                                grecTempSourceDocument."Shipping Instructions" := lrecReturnShipmentHeader."Shipping Instructions";
                                grecTempSourceDocument."Shipping Instructions 2" := lrecReturnShipmentHeader."Shipping Instructions 2";
                                //</RD55697NH>

                                lrecPayToVendor.Get(lrecReturnShipmentHeader."Pay-to Vendor No.");
                                lrecBuyFromVendor.Get(lrecReturnShipmentHeader."Buy-from Vendor No.");
                                gtxtBillToPhone := Format(lrecBillToCustomer."Phone No.");
                                gtxtSellToPhone := Format(lrecSellToCustomer."Phone No.");

                                gcduFormatAddress.PurchShptPayTo(gtxtBillToAddress, lrecReturnShipmentHeader);
                                gcduFormatAddress.PurchShptShipTo(gtxtShipToAddress, lrecReturnShipmentHeader);

                            end;
                        end;
                    "Posted Source Document"::"Posted Transfer Shipment":
                        begin
                            if (
                              (lrecTransferShipmentHeader.Get("Posted Source No."))
                            ) then begin

                                grecTempSourceDocument."External Document No." := lrecTransferShipmentHeader."External Document No.";
                                // no "Salesperson Code"
                                grecTempSourceDocument."Shipping Agent Code" := lrecTransferShipmentHeader."Shipping Agent Code";
                                grecTempSourceDocument."Shipping Agent Service Code" := lrecTransferShipmentHeader."Shipping Agent Service Code";
                                grecTempSourceDocument."Shipment Method Code" := lrecTransferShipmentHeader."Shipment Method Code";
                                // no "Payment Terms Code"

                                //<RD55697NH>
                                grecTempSourceDocument."Shipping Instructions" := lrecTransferShipmentHeader."Shipping Instructions";
                                grecTempSourceDocument."Shipping Instructions 2" := lrecTransferShipmentHeader."Shipping Instructions 2";
                                //</RD55697NH>

                                lrecTransferToLocation.Get(lrecTransferShipmentHeader."Transfer-to Code");
                                gtxtSellToPhone := lrecTransferToLocation."Phone No.";
                                gtxtShipToPhone := lrecTransferToLocation."Phone No. 2";

                                gcduFormatAddress.TransferShptTransferTo(gtxtShipToAddress, lrecTransferShipmentHeader);

                            end;
                        end;
                end;
                //<JF48674AC>

                //<RD55697NH>
                Clear(gtxtShipFromAddress);
                GetLocation("Location Code");
                gcduFormatAddress.jfLocation(gtxtShipFromAddress, Location);

                CommentLine.DeleteAll;
                rdLoadComments(CommentLine, "No.", 0, gintNoOfCommentsLinesToPrint);
                //</RD55697NH>
            end;
        }
    }

    requestpage
    {
        Caption = 'Whse. - Posted Shipment';
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(gblnPrintLotDetail; gblnPrintLotDetail)
                    {
                        ApplicationArea = JustFood;
                        Caption = 'Show Lot Detail';
                        ToolTip = 'Select to show the item''s lot detail.';
                    }
                    field(gintNoOfCommentsLinesToPrint; gintNoOfCommentsLinesToPrint)
                    {
                        ApplicationArea = JustFood;
                        Caption = 'No Of Comments Lines To Print';
                        ToolTip = 'Enter the number of comment lines you want to print on the document.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        //<RD55697NH>
        gintNoOfCommentsLinesToPrint := 5;
        //</RD55697NH>
    end;

    trigger OnPreReport()
    begin
        //<RD55697NH>
        CompanyInfo.Get;
        CompanyInfo.VerifyAndSetPaymentInfo;
        CompanyInfo.CalcFields(Picture);
        gcduFormatAddress.Company(gtxtCompanyAddress, CompanyInfo);
        //</RD55697NH>
    end;

    var
        Location: Record Location;
        CurrReportPAGENOCaptionLbl: Label 'Page';
        WarehousePostedShipmentCaptionLbl: Label 'Warehouse Posted Shipment';
        CompanyInformation: Record "Company Information";
        grecILE: Record "Item Ledger Entry";
        grecILETMP: Record "Item Ledger Entry" temporary;
        grecItem: Record Item;
        gblnPrintLotDetail: Boolean;
        gtxtLotDetail: Text[30];
        JFText001: Label 'Serial/Lot Detail:';
        gintSourceDocumentCount: Integer;
        grecTempSourceDocument: Record "Sales Shipment Header" temporary;
        grecShipmentMethod: Record "Shipment Method";
        grecPaymentTerms: Record "Payment Terms";
        grecSalesPurchPerson: Record "Salesperson/Purchaser";
        gtxtBillToPhone: Text[30];
        gtxtSellToPhone: Text[30];
        gtxtShipToPhone: Text[30];
        gcduFormatAddress: Codeunit "Format Address";
        gtxtShipFromAddress: array[8] of Text[90];
        gdecTotalNetWeight: Decimal;
        gdecTotalQuantity: Decimal;
        gtxtShelfZoneCaption: Text[30];
        gtxtShelfZoneValue: Text[30];
        gtxtBinCodeCaption: Text[30];
        gtxtBillToAddress: array[8] of Text[90];
        gtxtShipToAddress: array[8] of Text[90];
        gtxtCompanyAddress: array[8] of Text[90];
        HelperFunctions: Codeunit "Word Report Helper Functions";
        CompanyInfo: Record "Company Information";
        CompanyInfoBankAccNoLbl: Label 'Account No.';
        CompanyInfoBankNameLbl: Label 'Bank';
        CompanyInfoGiroNoLbl: Label 'Giro No.';
        CompanyInfoPhoneNoLbl: Label 'Phone No.';
        lblExternalDocumentNo: Label 'P.O. Number';
        lblPaymentTerms: Label 'Payment Terms';
        lblShipVia: Label 'Ship Via';
        lblShippingAgentCode: Label 'Shipping Agent Code';
        lblShippingAgentServiceCode: Label 'Shipping Agent Service Code';
        lblBillToPhoneNo: Label 'Bill-To Phone No.';
        lblSellToPhoneNo: Label 'Sell-To Phone No.';
        lblShipToPhoneNo: Label 'Ship-To Phone No.';
        lblSalespserson: Label 'Salesperson';
        lblShip: Label 'Ship';
        lblFrom: Label 'From:';
        lblNetWeight: Label 'Net Weight';
        lblTotalNetWeight: Label 'Total Net Weight';
        lblTotalQuantity: Label 'Total Quantity';
        lblTo: Label 'To:';
        lblBill: Label 'Bill';
        grecPostedWhseShipmentLine: Record "Posted Whse. Shipment Line";
        gtxtLotNo: array[1000] of Text[250];
        gintDetailLineNo: Integer;
        gintLotsFound: Integer;
        ShippingAgent: Record "Shipping Agent";
        gintNoOfCommentsLinesToPrint: Integer;
        gintCommentLines: Integer;
        gInventorySetup: Record "Inventory Setup";

    local procedure GetLocation(LocationCode: Code[10])
    begin
        if LocationCode = '' then
            Location.Init
        else
            if Location.Code <> LocationCode then
                Location.Get(LocationCode);
    end;

    local procedure rdGetGetLotNo(): Text[30]
    var
        lrecItem: Record Item;
        lcduItemTrackingMgt: Codeunit "Item Tracking Management";
        lintCount: Integer;
        lintCountonEachLine: Integer;
        ltxtValueEntryRef: Text[250];
    begin
        //<RD55697NH>
        lintCountonEachLine := 100;
        gintDetailLineNo := 0;
        gintLotsFound := 0;

        grecILETMP.DeleteAll;
        grecILE.SetCurrentKey("Document No.", "Posting Date");
        grecILE.SetRange("Document No.", Line."Posted Source No.");
        grecILE.SetRange("Document Line No.", Line."Posted Source Line No.");
        grecILE.SetRange("Item No.", Line."Item No.");
        grecILE.SetRange(Positive, false);
        if grecILE.Find('-') then begin
            repeat
                grecILETMP := grecILE;
                grecILETMP.Quantity := -grecILETMP.Quantity;
                grecILETMP.Description := grecILETMP."Lot No." +
                   ' (' + Format(grecILETMP.Quantity) + ' ' + Format(lrecItem."Base Unit of Measure") + ')';
                if not grecILETMP.Insert then;
            until grecILE.Next = 0;
            grecItem.Get(grecILETMP."Item No.");
        end;

        //Horizontal per line
        grecILETMP.Reset;
        if grecILETMP.FindSet then begin

            repeat
                if gintDetailLineNo = 0 then
                    gintDetailLineNo := 1;

                lrecItem.Get(grecILETMP."Item No.");

                if grecILETMP."Lot No." <> '' then begin
                    gtxtLotDetail := JFText001;

                    if (StrLen(gtxtLotNo[gintDetailLineNo]) +
                       StrLen(grecILETMP."Lot No.") +
                       StrLen(Format(grecILETMP.Quantity)) +
                       StrLen(Format(lrecItem."Base Unit of Measure")) + 6) <
                       lintCountonEachLine
                    then begin
                        if lintCount = 0 then begin
                            gtxtLotNo[gintDetailLineNo] :=
                              grecILETMP."Lot No." +
                              ' (' + Format(grecILETMP.Quantity) + ' ' +
                                     Format(lrecItem."Base Unit of Measure") + ')';
                        end else begin
                            gtxtLotNo[gintDetailLineNo] :=
                              gtxtLotNo[gintDetailLineNo] + ', ' + grecILETMP."Lot No." +
                              ' (' + Format(grecILETMP.Quantity) + ' ' +
                                     Format(lrecItem."Base Unit of Measure") + ')';

                        end;
                        lintCount := lintCount + 1;

                    end else begin
                        gintDetailLineNo += 1;
                        lintCount := 0;
                        if lintCount = 0 then begin
                            gtxtLotNo[gintDetailLineNo] :=
                              grecILETMP."Lot No." +
                              ' (' + Format(grecILETMP.Quantity) + ' ' +
                                     Format(lrecItem."Base Unit of Measure") + ')'
                        end else begin
                            gtxtLotNo[gintDetailLineNo] :=
                              gtxtLotNo[gintDetailLineNo] + ', ' + grecILETMP."Lot No." +
                              ' (' + Format(grecILETMP.Quantity) + ' ' +
                                     Format(lrecItem."Base Unit of Measure") + ')';
                        end;

                        lintCount := lintCount + 1;

                    end;

                end;
            until grecILETMP.Next = 0;

            if gtxtLotNo[1] = '' then
                gintDetailLineNo := 0;
        end;
        //</RD55697NH>
    end;

    local procedure rdLoadComments(var pComments: Record "Warehouse Comment Line" temporary; pcodDocNo: Code[20]; pintLineNo: Integer; pIntNoOfLinesToShow: Integer)
    var
        lrecWhseCommentLine: Record "Warehouse Comment Line";
    begin
        //<RD55697NH>
        gintCommentLines := 0;
        pComments.DeleteAll;
        with lrecWhseCommentLine do begin
            Reset;
            SetRange("No.", pcodDocNo);
            SetRange("Table Name", "Table Name"::"Posted Whse. Shipment");
            if FindSet then
                repeat
                    gintCommentLines += 1;
                    pComments.Init;
                    pComments := lrecWhseCommentLine;
                    pComments.Insert;
                until (Next = 0) or (gintCommentLines = pIntNoOfLinesToShow);
        end;
        //</RD55697NH>
    end;
}

