
report 50003 "Vendor Commissions Report - HT"
{   // EN1.00 2019-11-22 FS
    //Added Show all fields option on request Page and added extra fields
    // version JF9.00.00.00.9775
    // Copyright Axentia Solutions Corp.  1999-2013.
    // By opening this object you acknowledge that this object includes confidential information and intellectual
    // property of Axentia Solutions Corp. and that this work is protected by Canadian, U.S. and international
    // copyright laws and agreements.
    // 
    // JF38940SHR 20140107 - converted report
    // JF38941SHR 20140106 - add option to create payment commission jnls, consolidate other report into this report
    // JF40924SHR 20140724 - code added for "Pay Vend Comm. For Unpaid Doc"
    // JF43605SHR 20141028 - Corrected the line no. calc - was incrementing when it shouldn't
    // RD56163ATC 20150202 - "Line No." allocation was in the wrong place
    // RD55092ATC 20160208 - populate Commission Journal "Comm. Calc. Type"::Payment option
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/Rep50003.VendorCommissionsReportHT.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Date Filter", "Global Dimension 1 Code", "Global Dimension 2 Code";

            column(CompName;
            grecCompanyInfo.Name)
            {
            }
            column(gtxt_EmployeeFilters;
            gtxt_EmployeeFilters)
            {
            }
            column(gbol_ShowDetail;
            gbol_ShowDetail)
            {
            }
            column(gbol_newpage;
            gbol_newpage)
            {
            }
            column(gblnShowLineDetail;
            gblnShowLineDetail)
            {
            }
            column(No_Vendor;
            Vendor."No.")
            {
                IncludeCaption = true;
            }
            column(Name_Vendor;
            Vendor.Name)
            {
                IncludeCaption = true;
            }
            column(GlobalDimension1Code_Vendor;
            Vendor."Global Dimension 1 Code")
            {
                IncludeCaption = true;
            }
            column(GlobalDimension2Code_Vendor;
            Vendor."Global Dimension 2 Code")
            {
                IncludeCaption = true;
            }
            //<<EN1.00
            column(ShowAllFields; ShowAllFields)
            {

            }
            //>>EN1.00
            dataitem(CML;
            "Commission Ledger Entry")
            {
                DataItemLink = "Commission Type Code" = FIELD("No."), "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Commission Type", "Commission Type Code", "Posting Date") WHERE("Commission Type" = FILTER(Vendor), "Document Type" = FILTER(Invoice | Credit | Adjustment));
                RequestFilterFields = "Document Applied", Open;

                column(EntryNo_CML;
                CML."Entry No.")
                {
                }
                column(DocumentType_CML;
                CML."Document Type")
                {
                    IncludeCaption = true;
                }
                column(DocumentNo_CML;
                CML."Document No.")
                {
                    IncludeCaption = true;
                }
                column(PostingDate_CML;
                CML."Posting Date")
                {
                    IncludeCaption = true;
                }
                column(CommissionType_CML;
                CML."Commission Type")
                {
                    IncludeCaption = true;
                }
                column(AmountLCY_CML;
                CML."Amount (LCY)")
                {
                    IncludeCaption = true;
                }
                column(Open_CML;
                FORMAT(CML.Open))
                {
                }
                column(DocumentApplied_CML;
                FORMAT(CML."Document Applied"))
                {
                }
                column(gdec_InvAmt;
                gdec_InvAmt)
                {
                }
                column(gdec_CrAmt;
                gdec_CrAmt)
                {
                }
                column(gdec_AdjAmt;
                gdec_AdjAmt)
                {
                }
                column(gdec_CommAmount;
                gdec_CommAmount)
                {
                }
                column(gdecAmount;
                gdecAmount)
                {
                }
                column(gdecTotalInvAmt;
                gdecTotalInvAmt)
                {
                }
                column(gdecTotalCrAmt;
                gdecTotalCrAmt)
                {
                }
                column(gdecTotalAdjAmt;
                gdecTotalAdjAmt)
                {
                }
                column(gdecTotalCommAmount;
                gdecTotalCommAmount)
                {
                }
                column(gdecTotalAmount;
                gdecTotalAmount)
                {
                }
                column(CustMemberPONo;
                grec_Invoice."External Document No.")
                {
                }
                column(EDARate;
                grec_CommissionLine.Value)
                {
                }
                column(CommLineUom;
                grec_CommissionLine."Unit of Measure Code")
                {
                }

                dataitem(SIL;
                "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = FIELD("Document No.");
                    DataItemTableView = SORTING("Document No.", "Line No.");

                    column(No_SIL;
                    SIL."No.")
                    {
                        IncludeCaption = true;
                    }
                    column(Quantity_SIL;
                    SIL.Quantity)
                    {
                        IncludeCaption = true;
                    }
                    column(Amount_SIL;
                    SIL.Amount)
                    {
                        IncludeCaption = true;
                    }
                    column(Description_SIL;
                    Description)
                    {
                    }
                    column(GlobalDimension1Code_SIL;
                    "Shortcut Dimension 1 Code")
                    {
                        IncludeCaption = true;
                    }
                    column(UPC_SIL;
                    gtxt_UPC_SIL)
                    {
                    }
                    //<<EN1.00
                    column(Pack_Size_SIL; gtxt_PackSize_SIL)
                    {
                    }
                    column(GTIN_SIL; gtxt_GTIN_SIL)
                    {
                    }
                    //>>EN1.00
                    column(NetWgt_SIL;
                    SIL."Net Weight")
                    {
                    }
                    column(SellToCustomerNo_SIL;
                    SIL."Sell-to Customer No.")
                    {
                    }
                    column(SellToCustomerName_SIL;
                    SalesInvoiceHeader."Sell-to Customer Name")
                    {
                    }
                    trigger OnAfterGetRecord();
                    var
                        SalesShipmentLine: record "Sales Shipment Line";
                        ItemLedgerEntry: Record "Item Ledger Entry";
                    begin
                        if CML."Document Type" <> CML."Document Type"::Invoice then CurrReport.SKIP();
                        //>>DTP
                        //Item No.,Variant Code,Unit of Measure,Cross-Reference Type,Cross-Reference Type No.,Cross-Reference No.
                        clear(grec_ItemCrossReference);
                        clear(gtxt_PackSize_SIL);
                        clear(gtxt_GTIN_SIL);
                        clear(gtxt_UPC_SIL);
                        if ("Type" = Type::Item) and ("No." <> '') then begin
                            grec_ItemCrossReference.SetRange("Item No.", "No.");
                            if "Variant Code" <> '' then grec_ItemCrossReference.SetRange("Variant Code", "Variant Code");
                            grec_ItemCrossReference.SetRange("Unit of Measure", "Unit of Measure Code");
                            //if "Cross-Reference No." <> '' then
                            //  grec_ItemCrossReference.SetRange("Cross-Reference No.","Cross-Reference No.");
                            grec_ItemCrossReference.SetRange("Cross-Reference Type", grec_ItemCrossReference."Cross-Reference Type"::"Bar Code");
                            if grec_ItemCrossReference.FindFirst() then gtxt_PackSize_SIL := format(grec_ItemCrossReference."Std. Pack Size Quantity") + '-' + grec_ItemCrossReference."Std. Pack Size Unit of Measure";
                            if grec_ItemCrossReference."Bar Code Type Code" = 'GTIN' then
                                gtxt_GTIN_SIL := grec_ItemCrossReference."Cross-Reference No."
                            else begin
                                grec_ItemCrossReference.SetRange("Cross-Reference Type");
                                grec_ItemCrossReference.SetRange("Bar Code Type Code", 'GTIN');
                                if grec_ItemCrossReference.FindFirst() then gtxt_GTIN_SIL := grec_ItemCrossReference."Cross-Reference No.";
                            end;
                            grec_ItemCrossReference.SetRange("Bar Code Type Code", 'UPC');
                            if grec_ItemCrossReference.FindFirst() then gtxt_UPC_SIL := grec_ItemCrossReference."Cross-Reference No.";
                            //Find Net Weight from Item Ledger Entry
                            Clear(SalesShipmentLine);
                            SalesShipmentLine.SetFilter("Posting Date", '<=%1', SIL."Posting Date");
                            SalesShipmentLine.SetRange("Order No.", SIL."Order No.");
                            SalesShipmentLine.SetRange(Type, SIL.Type);
                            SalesShipmentLine.SetRange("No.", SIL."No.");
                            if SalesShipmentLine.FindLast() then begin
                                Clear(ItemLedgerEntry);
                                ItemLedgerEntry.SetRange("Posting Date", SalesShipmentLine."Posting Date");
                                ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Sales Shipment");
                                ItemLedgerEntry.SetRange("Document No.", SalesShipmentLine."Document No.");
                                ItemLedgerEntry.SetRange("Item No.", SalesShipmentLine."No.");
                                if ItemLedgerEntry.FindLast() then SIL."Net Weight" := SIL.quantity * (ItemLedgerEntry."Net Weight" / ItemLedgerEntry.Quantity);
                            end;
                        end;
                        if "Document No." <> SalesInvoiceHeader."No." then SalesInvoiceHeader.get("Document No.");
                        CML."Amount (LCY)" := grec_CommissionLine.Value * SIL."Net Weight";
                        //<<DTP
                    end;

                    trigger OnPreDataItem();
                    begin
                        //<JF01618AC>
                        if gblnCommDetailOnly then SETRANGE("Non-Commissionable", false);
                        //</JF01618AC>
                    end;
                }
                dataitem(SCML;
                "Sales Cr.Memo Line")
                {
                    DataItemLink = "Document No." = FIELD("Document No.");
                    DataItemTableView = SORTING("Document No.", "Line No.");

                    column(No_SCML;
                    SCML."No.")
                    {
                        IncludeCaption = true;
                    }
                    column(Quantity_SCML;
                    SCML.Quantity)
                    {
                        IncludeCaption = true;
                    }
                    column(Amount_SCML;
                    SCML.Amount)
                    {
                        IncludeCaption = true;
                    }
                    column(Description_SCML;
                    Description)
                    {
                    }
                    column(GlobalDimension1Code_SCML;
                    "Shortcut Dimension 1 Code")
                    {
                        IncludeCaption = true;
                    }
                    column(UPC_SCML;
                    gtxt_UPC_SCML)
                    {
                    }

                    column(NetWgt_SCML;
                    SCML."Net Weight")
                    {
                    }
                    column(SellToCustomerNo_SCML;
                    SCML."Sell-to Customer No.")
                    {
                    }
                    column(SellToCustomerName_SCML;
                    SalesCrMemoHeader."Sell-to Customer Name")
                    {
                    }
                    //<<EN1.00
                    column(Member_No; grec_customer."Member No.")
                    {
                    }
                    column(Member_Location; grec_customer."Member Location")
                    {
                    }
                    column(Member_DUNS; grec_customer."Member DUNS No.")
                    {
                    }
                    column(Member_Name; grec_customer."Member Name")
                    {
                    }
                    column(GetDocumentType; GetDocumentType)
                    {
                    }
                    column(Pack_Size_SCML; gtxt_PackSize_SCML)
                    {

                    }
                    column(GTIN_SCML; gtxt_GTIN_SCML)
                    {

                    }

                    //>>EN1.00                   
                    trigger OnAfterGetRecord();
                    var
                        SalesCrMemoLine: Record "Sales Cr.Memo Line";
                        ItemLedgerEntry: Record "Item Ledger Entry";
                    begin
                        if CML."Document Type" <> CML."Document Type"::Credit then CurrReport.SKIP();
                        //>>DTP
                        //Item No.,Variant Code,Unit of Measure,Cross-Reference Type,Cross-Reference Type No.,Cross-Reference No.
                        clear(grec_ItemCrossReference);
                        clear(gtxt_PackSize_SCML);
                        clear(gtxt_GTIN_SCML);
                        clear(gtxt_UPC_SCML);
                        if ("Type" = Type::Item) and ("No." <> '') then begin
                            grec_ItemCrossReference.SetRange("Item No.", "No.");
                            if "Variant Code" <> '' then grec_ItemCrossReference.SetRange("Variant Code", "Variant Code");
                            grec_ItemCrossReference.SetRange("Unit of Measure", "Unit of Measure Code");
                            //if "Cross-Reference No." <> '' then
                            //  grec_ItemCrossReference.SetRange("Cross-Reference No.","Cross-Reference No.");
                            grec_ItemCrossReference.SetRange("Cross-Reference Type", grec_ItemCrossReference."Cross-Reference Type"::"Bar Code");
                            if grec_ItemCrossReference.FindFirst() then gtxt_PackSize_SCML := format(grec_ItemCrossReference."Std. Pack Size Quantity") + '-' + grec_ItemCrossReference."Std. Pack Size Unit of Measure";
                            if grec_ItemCrossReference."Bar Code Type Code" = 'GTIN' then
                                gtxt_GTIN_SCML := grec_ItemCrossReference."Cross-Reference No."
                            else begin
                                grec_ItemCrossReference.SetRange("Cross-Reference Type");
                                grec_ItemCrossReference.SetRange("Bar Code Type Code", 'GTIN');
                                if grec_ItemCrossReference.FindFirst() then gtxt_GTIN_SCML := grec_ItemCrossReference."Cross-Reference No.";
                            end;
                            grec_ItemCrossReference.SetRange("Bar Code Type Code", 'UPC');
                            if grec_ItemCrossReference.FindFirst() then gtxt_UPC_SCML := grec_ItemCrossReference."Cross-Reference No.";
                            //Find Net Weight from Item Ledger Entry
                            clear(SalesCrMemoLine);
                            SalesCrMemoLine.SetFilter("Posting Date", '<=%1', SCML."Posting Date");
                            SalesCrMemoLine.setrange("Order No.", SCML."Document No.");
                            salesCrMemoline.setrange(type, SCML.type);
                            salesCrMemoline.SetRange("No.", SCML."No.");
                            if SalesCrMemoLine.findlast() then begin
                                Clear(ItemLedgerEntry);
                                ItemLedgerEntry.setrange("Posting Date", SalesCrMemoLine."Posting Date");
                                ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Sales Credit Memo");
                                ItemLedgerEntry.SetRange("Document No.", SalesCrMemoLine."Document No.");
                                ItemLedgerEntry.SetRange("Item No.", SalesCrMemoLine."No.");
                                if ItemLedgerEntry.findlast() then SCML."Net Weight" := SCMl.quantity * (ItemLedgerEntry."Net Weight" / ItemLedgerEntry.Quantity);
                            end;
                        end;
                        if "Document No." <> SalesCrMemoHeader."No." then SalesCrMemoHeader.get("Document No.");
                        CML."Amount (LCY)" := grec_CommissionLine.Value * SCML."Net Weight";
                        //<<DTP
                    end;

                    trigger OnPreDataItem();
                    begin
                        //<JF01618AC>
                        if gblnCommDetailOnly then SETRANGE("Non-Commissionable", false);
                        //</JF01618AC>
                    end;
                }
                trigger OnAfterGetRecord();
                begin
                    clear(grec_Customer); //DTP
                    clear(grec_Invoice); //DTP
                    case "Document Type" of
                        "Document Type"::Invoice:
                            begin
                                gdec_InvAmt += "Amount (LCY)";
                                gdecTotalInvAmt += "Amount (LCY)";
                                if grec_Invoice.GET("Document No.") then gtxt_CustomerName := grec_Invoice."Sell-to Customer Name";
                                grec_Customer.GET(grec_Invoice."Sell-to Customer No."); //DTP
                            end;
                        "Document Type"::Credit:
                            begin
                                gdec_CrAmt += "Amount (LCY)";
                                gdecTotalCrAmt += "Amount (LCY)";
                                if grec_Credit.GET("Document No.") then gtxt_CustomerName := grec_Credit."Sell-to Customer Name";
                                grec_Customer.GET(grec_Credit."Sell-to Customer No."); //DTP
                            end;
                        "Document Type"::Adjustment:
                            begin
                                gdec_AdjAmt += "Amount (LCY)";
                                gdecTotalAdjAmt += "Amount (LCY)";
                            end;
                    end;
                    gdecAmount += "Amount (LCY)";
                    gdecTotalAmount += "Amount (LCY)";
                    grecSalesSetup.GET();
                    if "Document Applied" or grecSalesSetup."Pay Vend Comm. For Unpaid Doc" then begin
                        gdecCommAmount := "Amount (LCY)";
                        gdec_CommAmount += "Amount (LCY)";
                        gdecTotalCommAmount += "Amount (LCY)";
                    end
                    else begin
                        gdecCommAmount := 0;
                        gdec_CommAmount += 0;
                    end;
                    //<RD56163ATC> - deleted code
                    if gbol_Create_JnlLines then begin
                        grceTempCommJnlLine.SETRANGE("Comm. Batch Name", gcod_CommBatch);
                        grceTempCommJnlLine.SETRANGE("Document Type", grceTempCommJnlLine."Document Type"::Payment);
                        grceTempCommJnlLine.SETRANGE("Commission Code", CML."Commission Code");
                        grceTempCommJnlLine.SETRANGE("Commission Type", CML."Commission Type");
                        grceTempCommJnlLine.SETRANGE("Commission Type Code", CML."Commission Type Code");
                        if grceTempCommJnlLine.FINDFIRST() then begin
                            grceTempCommJnlLine."Amount (LCY)" += gdecCommAmount;
                            grceTempCommJnlLine.MODIFY();
                        end
                        else begin
                            //<RD56163ATC>
                            gint_LineNo += 10000;
                            //</RD56163ATC>
                            grceTempCommJnlLine."Comm. Batch Name" := gcod_CommBatch;
                            grceTempCommJnlLine."Line No." := gint_LineNo;
                            grceTempCommJnlLine."Document Type" := grec_CommJnlLine."Document Type"::Payment;
                            grceTempCommJnlLine."Document No." := gcod_DocumentNo;
                            grceTempCommJnlLine."Commission Code" := CML."Commission Code";
                            grceTempCommJnlLine."Commission Type" := CML."Commission Type";
                            grceTempCommJnlLine."Commission Type Code" := CML."Commission Type Code";
                            grceTempCommJnlLine."Posting Date" := WORKDATE();
                            grceTempCommJnlLine."Amount (LCY)" := gdecCommAmount;
                            grceTempCommJnlLine.INSERT();
                        end;
                        //<RD56163ATC>
                        if ("Document Applied" or grecSalesSetup."Pay Vend Comm. For Unpaid Doc") then SetAppliesID(COPYSTR(gcod_CommBatch, 1, 3) + FORMAT(grceTempCommJnlLine."Line No."));
                        //</RD56163ATC>
                    end;
                    //>>DTP
                    //Commission Code,Type,Margin Cost Base,Value Type,Unit of Measure Code,Min. Level
                    clear(grec_CommissionLine);
                    grec_CommissionLine.SetRange("Commission Code", CML."Commission Code");
                    if grec_CommissionLine.FindFirst() then;
                    //>>DTP
                    gblnFound := true;
                end;
            }
            trigger OnAfterGetRecord();
            begin
                gblnFound := false;
                CLEAR(gdec_InvAmt);
                CLEAR(gdec_CrAmt);
                CLEAR(gdec_AdjAmt);
                CLEAR(gdecAmount);
                CLEAR(gdec_CommAmount);
                //<RD56163ATC> - removed code
            end;

            trigger OnPreDataItem();
            var
                ljftext000: Label 'Please Specify a Date filter for the report';
                ljfText001: Label 'Please Specify a "Commission Batch Name" on the Options Tab';
            begin
                grecCompanyInfo.GET();
                gtxt_EmployeeFilters := GETFILTERS();
                //Check if Date Filter is specified
                if ((Vendor.GETRANGEMIN("Date Filter") = 0D) and (Vendor.GETRANGEMAX("Date Filter") = 0D)) then ERROR(ljftext000);
                //Check if Batch is selected if insert lines is true
                //Get the last line from the Commission Journal line table
                if gbol_Create_JnlLines then begin
                    if gcod_CommBatch = '' then ERROR(ljfText001);
                    CLEAR(gcod_DocumentNo);
                    CLEAR(grec_CommJnlLine);
                    grec_CommJnlLine.SETRANGE("Comm. Batch Name", gcod_CommBatch);
                    if grec_CommJnlLine.FIND('+') then begin
                        gint_LineNo := grec_CommJnlLine."Line No.";
                        gcod_DocumentNo := grec_CommJnlLine."Document No.";
                    end
                    else
                        gint_LineNo := 0;
                    //Get the last document number
                    if gcod_DocumentNo = '' then begin
                        grec_CommJnlBatch.GET(gcod_CommBatch);
                        if grec_CommJnlBatch."No. Series" <> '' then begin
                            CLEAR(NoSeriesMgt);
                            gcod_DocumentNo := NoSeriesMgt.TryGetNextNo(grec_CommJnlBatch."No. Series", WORKDATE());
                        end;
                    end
                    else
                        gcod_DocumentNo := INCSTR(gcod_DocumentNo);
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    //field(gbol_ShowDetail;gbol_ShowDetail)
                    //{
                    //    Caption = 'Show Detail';
                    //}
                    //field(gblnShowLineDetail;gblnShowLineDetail)
                    //{
                    //    Caption = 'Show Line Detail';
                    //}
                    field(gblnCommDetailOnly; gblnCommDetailOnly)
                    {
                        ApplicationArea = "All";
                        Caption = 'Show Only Commissionable Details';
                    }
                    field(gbol_Create_JnlLines; gbol_Create_JnlLines)
                    {
                        ApplicationArea = "All";
                        Caption = 'Create Payment Lines';
                    }
                    field(gcod_CommBatch; gcod_CommBatch)
                    {
                        ApplicationArea = "All";
                        Caption = 'Commission Journal Batch Name';
                        TableRelation = "Commission Batch";
                    }
                    field(gbol_newpage; gbol_newpage)
                    {
                        ApplicationArea = "All";
                        Caption = 'New Page per Vendor';
                    }
                    //<<EN1.00
                    field(ShowAllFields; ShowAllFields)
                    {
                        ApplicationArea = "All";
                        Caption = 'Show All';
                    }
                    //>>EN1.00
                }
            }
        }
        actions
        {
        }
        trigger OnOpenPage();
        begin
            gbol_ShowDetail := true;
            gblnShowLineDetail := true;
            gbol_Create_JnlLines := false;
        end;
    }
    labels
    {
        Title = 'Vendor Commissions';
        CMLOpen = 'Open';
        CMLDocApp = 'Document Applied';
        TotalInvAmount = 'Total Invoice Amount:';
        TotalCrMemoAmount = 'Total Credit Memo Amount:';
        TotalAdjAmount = 'Total Adjustment Amount:';
        TotalAmount = 'Total Amount:';
        CommToBePaid = 'Commission to be Paid:';
        ReportTotals = 'REPORT TOTALS';
    }
    trigger OnPostReport();
    begin
        if gbol_Create_JnlLines then CreatePaymentLines();
    end;

    var
        grecCompanyInfo: Record "Company Information";
        grceTempCommJnlLine: Record "Commission Journal Line" temporary;
        grec_CommJnlLine: Record "Commission Journal Line";
        grec_CommJnlBatch: Record "Commission Batch";
        grec_Invoice: Record "Sales Invoice Header";
        grec_Credit: Record "Sales Cr.Memo Header";
        grecSalesSetup: Record "Sales & Receivables Setup";
        grec_Customer: Record Customer; //DTP
        grec_ItemCrossReference: Record "Item Cross Reference"; //DTP
        grec_CommissionLine: Record "Commission Line"; //DTP
        SalesInvoiceHeader: Record "Sales Invoice Header"; //DTP
        SalesCrMemoHeader: Record "Sales Cr.Memo Header"; //DTP        
        NoSeriesMgt: Codeunit NoSeriesManagement;
        gdec_InvAmt: Decimal;
        gdec_CrAmt: Decimal;
        gbol_ShowDetail: Boolean;
        gtxt_EmployeeFilters: Text[250];
        gdec_AdjAmt: Decimal;
        gblnFound: Boolean;
        gcod_DocumentNo: Code[20];
        gbol_Create_JnlLines: Boolean;
        gcod_CommBatch: Code[10];
        gint_LineNo: Integer;
        gtxt_CustomerName: Text[50];
        gdec_CommAmount: Decimal;
        gbol_newpage: Boolean;
        gblnShowLineDetail: Boolean;
        gblnCommDetailOnly: Boolean;
        gdecAmount: Decimal;
        gdecTotalAmount: Decimal;
        gdecTotalInvAmt: Decimal;
        gdecTotalCrAmt: Decimal;
        gdecTotalAdjAmt: Decimal;
        gdecTotalCommAmount: Decimal;
        gdecCommAmount: Decimal;
        gtxt_PackSize_SIL: Text[20]; //DTP
        gtxt_PackSize_SCML: Text[20]; //DTP
        gtxt_GTIN_SIL: Text[20]; //DTP
        gtxt_GTIN_SCML: Text[20]; //DTP
        gtxt_UPC_SIL: Text[20]; //DTP
        gtxt_UPC_SCML: Text[20]; //DTP
        ShowAllFields: Boolean;

    procedure CreatePaymentLines();
    begin
        grceTempCommJnlLine.RESET();
        if grceTempCommJnlLine.FINDSET() then
            repeat
                if grceTempCommJnlLine."Amount (LCY)" <> 0 then begin
                    grec_CommJnlLine."Comm. Batch Name" := grceTempCommJnlLine."Comm. Batch Name";
                    grec_CommJnlLine."Line No." := grceTempCommJnlLine."Line No.";
                    grec_CommJnlLine."Document Type" := grec_CommJnlLine."Document Type"::Payment;
                    grec_CommJnlLine."Document No." := gcod_DocumentNo;
                    grec_CommJnlLine."Commission Code" := grceTempCommJnlLine."Commission Code";
                    grec_CommJnlLine."Commission Type" := grceTempCommJnlLine."Commission Type";
                    grec_CommJnlLine."Commission Type Code" := grceTempCommJnlLine."Commission Type Code";
                    //<RD55092ATC>
                    grec_CommJnlLine."Comm. Calc. Type" := grec_CommJnlLine."Comm. Calc. Type"::Payment;
                    //</RD55092ATC>
                    grec_CommJnlLine."Posting Date" := WORKDATE();
                    grec_CommJnlLine."Amount (LCY)" := grceTempCommJnlLine."Amount (LCY)";
                    grec_CommJnlLine.INSERT();
                end;
            until grceTempCommJnlLine.NEXT() = 0;
    end;
}
