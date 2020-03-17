codeunit 50000 "Hackney Subscriptions"
{
    EventSubscriberInstance = StaticAutomatic;

    //[EventSubscriber(ObjectType::Codeunit, Codeunit::"Test Event", 'OnAfterTest', '', true, true)]
    local procedure PrintLogRunDocs(LogRunHeader: Record "Logistics Run Header"; pblnPackageOnly: Boolean)
    var
        ReportSelection: record "Logistics Report Selections";
        DriverManifestReport: Report "Driver Manifest - HT";
    begin


        LogRunHeader.SETRANGE("No.", LogRunHeader."No.");
        ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"Logistics Run");
        ReportSelection.SETFILTER("Report ID", '<>0');

        IF pblnPackageOnly THEN BEGIN
            ReportSelection.SETRANGE("Include In Logistics Package", TRUE);
        END;

        IF ReportSelection.FINDSET THEN BEGIN
            REPEAT
                if ReportSelection."Report ID" = 50004 then begin

                    DriverManifestReport.UseRequestPage(false);
                    DriverManifestReport.SetTableView(LogRunHeader);
                    DriverManifestReport.SetCopyText(CopyString);
                    DriverManifestReport.Run();
                end else
                    REPORT.RUNMODAL(ReportSelection."Report ID", FALSE, FALSE, LogRunHeader);
            UNTIL ReportSelection.NEXT = 0;
        END ELSE BEGIN
            IF NOT pblnPackageOnly THEN
                ReportSelection.FINDFIRST;
        END;
    end;

    local procedure PrintLogRunSourceDocs(LogRunHeader: Record "Logistics Run Header"; pblnPackageOnly: Boolean)
    var
        ReportSelection: record "Logistics Report Selections";
        lrecLogRunLine: record "Logistics Run Line";
        lrecTEMPWhseShipmentHeader: record "Warehouse Shipment Header" temporary;
        lrecWhseShipmentHeader: record "Warehouse Shipment Header";
        lrecTEMPPostWhseShipmentHeader: Record "Posted Whse. Shipment Header" temporary;
        lrecPostWhseShipmentHeader: Record "Posted Whse. Shipment Header";
        lrecTEMPWhseRcptHeader: Record "Warehouse Receipt Header" temporary;
        lrecWhseRcptHeader: Record "Warehouse Receipt Header";
        lrecTEMPPostWhseRcptHeader: Record "Posted Whse. Receipt Header" temporary;
        lrecPostWhseRcptHeader: Record "Posted Whse. Receipt Header";
        ltxtFilterString: Text[1024];
        BillofLadingReport: Report "Posted Whse. Shipment - HT";
    begin


        //-- Process Warehouse Shipment Lines
        ltxtFilterString := '';

        lrecLogRunLine.SETCURRENTKEY("Source Type", "Source Subtype", "Source No.");

        lrecLogRunLine.SETRANGE("Source Type", DATABASE::"Warehouse Shipment Header");
        lrecLogRunLine.SETRANGE("Source Subtype");
        lrecLogRunLine.SETRANGE("Source No.");
        lrecLogRunLine.SETRANGE("Run No.", LogRunHeader."No.");
        lrecLogRunLine.SETRANGE("Line No.");

        IF lrecLogRunLine.FINDSET THEN BEGIN
            REPEAT
                IF lrecWhseShipmentHeader.GET(lrecLogRunLine."Source No.") THEN BEGIN
                    //-- open
                    lrecTEMPWhseShipmentHeader."No." := lrecLogRunLine."Source No.";
                    IF lrecTEMPWhseShipmentHeader.INSERT THEN;
                END ELSE BEGIN
                    //-- posted
                    lrecTEMPPostWhseShipmentHeader."No." := lrecLogRunLine."Source No.";
                    IF lrecTEMPPostWhseShipmentHeader.INSERT THEN;
                END;
            UNTIL lrecLogRunLine.NEXT = 0;
        END;

        //-- Open Whse. Shipments

        //<JF19291SHR>
        ltxtFilterString := '';
        //</JF19291SHR>

        IF lrecTEMPWhseShipmentHeader.FINDSET THEN BEGIN
            REPEAT
                IF ltxtFilterString = '' THEN
                    ltxtFilterString := lrecTEMPWhseShipmentHeader."No."
                ELSE
                    ltxtFilterString := ltxtFilterString + '|' + lrecTEMPWhseShipmentHeader."No.";
            UNTIL lrecTEMPWhseShipmentHeader.NEXT = 0;
        END;

        IF ltxtFilterString <> '' THEN BEGIN
            lrecWhseShipmentHeader.SETFILTER("No.", ltxtFilterString);

            ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"Warehouse Shipment");
            ReportSelection.SETFILTER("Report ID", '<>0');
            IF pblnPackageOnly THEN
                ReportSelection.SETRANGE("Include In Logistics Package", TRUE);
            IF ReportSelection.FINDSET THEN BEGIN
                REPEAT
                    REPORT.RUNMODAL(ReportSelection."Report ID", TRUE, FALSE, lrecWhseShipmentHeader);
                UNTIL ReportSelection.NEXT = 0;
            END ELSE BEGIN
                IF NOT pblnPackageOnly THEN
                    ReportSelection.FINDFIRST;
            END;
        END;

        //-- Posted Whse. Shipment Lines

        //<JF19291SHR>
        ltxtFilterString := '';
        //</JF19291SHR>

        IF lrecTEMPPostWhseShipmentHeader.FINDSET THEN BEGIN
            REPEAT
                IF ltxtFilterString = '' THEN
                    ltxtFilterString := lrecTEMPPostWhseShipmentHeader."No."
                ELSE
                    ltxtFilterString := ltxtFilterString + '|' + lrecTEMPPostWhseShipmentHeader."No.";
            UNTIL lrecTEMPPostWhseShipmentHeader.NEXT = 0;
        END;

        IF ltxtFilterString <> '' THEN BEGIN
            lrecPostWhseShipmentHeader.SETFILTER("Whse. Shipment No.", ltxtFilterString);
            ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"Posted Whse. Shipment");
            ReportSelection.SETFILTER("Report ID", '<>0');

            IF pblnPackageOnly THEN
                ReportSelection.SETRANGE("Include In Logistics Package", TRUE);

            if ReportSelection.FindSet() then
                repeat
                    if ReportSelection."Report ID" = 50006 then begin

                        BillofLadingReport.UseRequestPage(false);
                        BillofLadingReport.SetTableView(lrecPostWhseShipmentHeader);
                        BillofLadingReport.SetCopyText(CopyString);
                        BillofLadingReport.Run();
                    end else
                        REPORT.RunModal(ReportSelection."Report ID", false, false, lrecPostWhseShipmentHeader);
                until ReportSelection.Next() = 0;
        END ELSE BEGIN
            IF NOT pblnPackageOnly THEN
                ReportSelection.FINDFIRST;
        END;

        /*  IF ReportSelection.FINDSET THEN BEGIN
              REPEAT
                  REPORT.RUNMODAL(ReportSelection."Report ID", TRUE, FALSE, lrecPostWhseShipmentHeader);
              UNTIL ReportSelection.NEXT = 0;
          END ELSE BEGIN
              IF NOT pblnPackageOnly THEN
                  ReportSelection.FINDFIRST;
          END;
      END;
  */
        //-- Process Warehouse receipt Lines

        ltxtFilterString := '';

        lrecLogRunLine.SETCURRENTKEY("Source Type", "Source Subtype", "Source No.");

        lrecLogRunLine.SETRANGE("Source Type", DATABASE::"Warehouse Receipt Header");
        lrecLogRunLine.SETRANGE("Source Subtype");
        lrecLogRunLine.SETRANGE("Source No.");
        lrecLogRunLine.SETRANGE("Run No.", LogRunHeader."No.");
        lrecLogRunLine.SETRANGE("Line No.");

        IF lrecLogRunLine.FINDSET THEN BEGIN
            REPEAT
                IF lrecWhseRcptHeader.GET(lrecLogRunLine."Source No.") THEN BEGIN
                    //-- Open
                    lrecTEMPWhseRcptHeader."No." := lrecLogRunLine."Source No.";
                    IF lrecTEMPWhseRcptHeader.INSERT THEN;
                END ELSE BEGIN
                    //-- Posted
                    lrecTEMPPostWhseRcptHeader."No." := lrecLogRunLine."Source No.";
                    IF lrecTEMPPostWhseRcptHeader.INSERT THEN;
                END;
            UNTIL lrecLogRunLine.NEXT = 0;
        END;

        //-- Open Whse. Receipts

        //<JF19291SHR>
        ltxtFilterString := '';
        //</JF19291SHR>

        IF lrecTEMPWhseRcptHeader.FINDSET THEN BEGIN
            REPEAT
                IF ltxtFilterString = '' THEN
                    ltxtFilterString := lrecTEMPWhseRcptHeader."No."
                ELSE
                    ltxtFilterString := ltxtFilterString + '|' + lrecTEMPWhseRcptHeader."No.";
            UNTIL lrecTEMPWhseRcptHeader.NEXT = 0;
        END;

        IF ltxtFilterString <> '' THEN BEGIN
            lrecWhseRcptHeader.SETFILTER("No.", ltxtFilterString);

            ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"Warehouse Receipt");
            ReportSelection.SETFILTER("Report ID", '<>0');

            IF pblnPackageOnly THEN
                ReportSelection.SETRANGE("Include In Logistics Package", TRUE);

            IF ReportSelection.FINDSET THEN BEGIN
                REPEAT
                    REPORT.RUNMODAL(ReportSelection."Report ID", TRUE, FALSE, lrecWhseRcptHeader);
                UNTIL ReportSelection.NEXT = 0;
            END ELSE BEGIN
                IF NOT pblnPackageOnly THEN
                    ReportSelection.FINDFIRST;
            END;
        END;

        //-- Posted Whse. Receipts

        //<JF19291SHR>
        ltxtFilterString := '';
        //</JF19291SHR>

        IF lrecTEMPPostWhseRcptHeader.FINDSET THEN BEGIN
            REPEAT
                IF ltxtFilterString = '' THEN
                    ltxtFilterString := lrecTEMPPostWhseRcptHeader."No."
                ELSE
                    ltxtFilterString := ltxtFilterString + '|' + lrecTEMPPostWhseRcptHeader."No.";
            UNTIL lrecTEMPPostWhseRcptHeader.NEXT = 0;
        END;

        IF ltxtFilterString <> '' THEN BEGIN
            lrecPostWhseRcptHeader.SETFILTER("Whse. Receipt No.", ltxtFilterString);

            ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"Posted Whse. Receipt");
            ReportSelection.SETFILTER("Report ID", '<>0');

            IF pblnPackageOnly THEN
                ReportSelection.SETRANGE("Include In Logistics Package", TRUE);

            IF ReportSelection.FINDSET THEN BEGIN
                REPEAT
                    REPORT.RUNMODAL(ReportSelection."Report ID", TRUE, FALSE, lrecPostWhseRcptHeader);
                UNTIL ReportSelection.NEXT = 0;
            END ELSE BEGIN
                IF NOT pblnPackageOnly THEN
                    ReportSelection.FINDFIRST;
            END;
        END;

    end;

    local procedure PrintLogRunSourceRefDocs(LogRunHeader: Record "Logistics Run Header"; pblnPackageOnly: Boolean)
    var
        ReportSelection: record "Logistics Report Selections";
        lrecLogRunLine: record "Logistics Run Line";

        lrecSalesOrder: Record "Sales Header";
        lrecPurchOrder: Record "Purchase Header";
        lrecShipment: Record "Sales Shipment Header";
        lrecReceipt: Record "Purch. Rcpt. Header";
        lrecTransOrder: Record "Transfer Header";
        lrecTransShipHeader: Record "Transfer Shipment Header";
        lrecTransRcptHeader: Record "Transfer Receipt Header";
        lrecTEMPSalesOrder: Record "Sales Header" temporary;
        lrecTEMPPurchOrder: Record "Purchase Header" temporary;
        lrecTEMPShipment: Record "Sales Shipment Header" temporary;
        lrecTEMPReceipt: Record "Purch. Rcpt. Header" temporary;
        lrecTEMPTransOrder: Record "Transfer Header" temporary;
        lrecTEMPTransShipHeader: Record "Transfer Shipment Header" temporary;
        lrecTEMPTransRcptHeader: Record "Transfer Receipt Header" temporary;
        ltxtFilterString: Text[1024];

    begin


        //-- Sales Shipment
        ltxtFilterString := '';

        lrecLogRunLine.SETCURRENTKEY("Source Doc. Ref. Type", "Source Doc. Ref. No.");

        lrecLogRunLine.SETRANGE("Source Doc. Ref. Type", lrecLogRunLine."Source Doc. Ref. Type"::"Posted Sales Shipment");
        lrecLogRunLine.SETRANGE("Source Doc. Ref. No.");
        lrecLogRunLine.SETRANGE("Run No.", LogRunHeader."No.");
        lrecLogRunLine.SETRANGE("Line No.");

        IF lrecLogRunLine.FINDSET THEN BEGIN
            REPEAT
                lrecTEMPShipment."No." := lrecLogRunLine."Source Doc. Ref. No.";
                IF lrecTEMPShipment.INSERT THEN;
            UNTIL lrecLogRunLine.NEXT = 0;
        END;

        IF lrecTEMPShipment.FINDSET THEN BEGIN
            REPEAT
                IF ltxtFilterString = '' THEN
                    ltxtFilterString := lrecTEMPShipment."No."
                ELSE
                    ltxtFilterString := ltxtFilterString + '|' + lrecTEMPShipment."No.";
            UNTIL lrecTEMPShipment.NEXT = 0;
        END;

        IF ltxtFilterString <> '' THEN BEGIN
            lrecShipment.SETFILTER("No.", ltxtFilterString);

            ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"Sales Shipment");
            ReportSelection.SETFILTER("Report ID", '<>0');

            IF pblnPackageOnly THEN
                ReportSelection.SETRANGE("Include In Logistics Package", TRUE);

            IF ReportSelection.FINDSET THEN BEGIN
                REPEAT
                    REPORT.RUNMODAL(ReportSelection."Report ID", TRUE, FALSE, lrecShipment);
                UNTIL ReportSelection.NEXT = 0;
            END ELSE BEGIN
                IF NOT pblnPackageOnly THEN
                    ReportSelection.FINDFIRST;
            END;
        END;


        //-- Transfer Order
        ltxtFilterString := '';

        lrecLogRunLine.SETCURRENTKEY("Source Doc. Ref. Type", "Source Doc. Ref. No.");

        lrecLogRunLine.SETRANGE("Source Doc. Ref. Type", lrecLogRunLine."Source Doc. Ref. Type"::"Transfer Order");
        lrecLogRunLine.SETRANGE("Source Doc. Ref. No.");
        lrecLogRunLine.SETRANGE("Run No.", LogRunHeader."No.");
        lrecLogRunLine.SETRANGE("Line No.");

        IF lrecLogRunLine.FINDSET THEN BEGIN
            REPEAT
                lrecTEMPTransOrder."No." := lrecLogRunLine."Source Doc. Ref. No.";
                IF lrecTEMPTransOrder.INSERT THEN;
            UNTIL lrecLogRunLine.NEXT = 0;
        END;

        IF lrecTEMPTransOrder.FINDSET THEN BEGIN
            REPEAT
                IF ltxtFilterString = '' THEN
                    ltxtFilterString := lrecTEMPTransOrder."No."
                ELSE
                    ltxtFilterString := ltxtFilterString + '|' + lrecTEMPTransOrder."No.";
            UNTIL lrecTEMPTransOrder.NEXT = 0;
        END;

        IF ltxtFilterString <> '' THEN BEGIN
            lrecTransOrder.SETFILTER("No.", ltxtFilterString);

            ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"Transfer Order");
            ReportSelection.SETFILTER("Report ID", '<>0');

            IF pblnPackageOnly THEN
                ReportSelection.SETRANGE("Include In Logistics Package", TRUE);

            IF ReportSelection.FINDSET THEN BEGIN
                REPEAT
                    REPORT.RUNMODAL(ReportSelection."Report ID", TRUE, FALSE, lrecTransOrder);
                UNTIL ReportSelection.NEXT = 0;
            END ELSE BEGIN
                IF NOT pblnPackageOnly THEN
                    ReportSelection.FINDFIRST;
            END;
        END;


        //-- Transfer Shipment
        ltxtFilterString := '';

        lrecLogRunLine.SETCURRENTKEY("Source Doc. Ref. Type", "Source Doc. Ref. No.");

        lrecLogRunLine.SETRANGE("Source Doc. Ref. Type", lrecLogRunLine."Source Doc. Ref. Type"::"Posted Transfer Shipment");
        lrecLogRunLine.SETRANGE("Source Doc. Ref. No.");
        lrecLogRunLine.SETRANGE("Run No.", LogRunHeader."No.");
        lrecLogRunLine.SETRANGE("Line No.");

        IF lrecLogRunLine.FINDSET THEN BEGIN
            REPEAT
                lrecTEMPTransShipHeader."No." := lrecLogRunLine."Source Doc. Ref. No.";
                IF lrecTEMPTransShipHeader.INSERT THEN;
            UNTIL lrecLogRunLine.NEXT = 0;
        END;

        IF lrecTEMPTransShipHeader.FINDSET THEN BEGIN
            REPEAT
                IF ltxtFilterString = '' THEN
                    ltxtFilterString := lrecTEMPTransShipHeader."No."
                ELSE
                    ltxtFilterString := ltxtFilterString + '|' + lrecTEMPTransShipHeader."No.";
            UNTIL lrecTEMPTransShipHeader.NEXT = 0;
        END;

        IF ltxtFilterString <> '' THEN BEGIN
            lrecTransShipHeader.SETFILTER("No.", ltxtFilterString);

            ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"Transfer Shipment");
            ReportSelection.SETFILTER("Report ID", '<>0');

            IF pblnPackageOnly THEN
                ReportSelection.SETRANGE("Include In Logistics Package", TRUE);

            IF ReportSelection.FINDSET THEN BEGIN
                REPEAT
                    REPORT.RUNMODAL(ReportSelection."Report ID", TRUE, FALSE, lrecTransShipHeader);
                UNTIL ReportSelection.NEXT = 0;
            END ELSE BEGIN
                IF NOT pblnPackageOnly THEN
                    ReportSelection.FINDFIRST;
            END;
        END;

        //-- Purchase Order
        ltxtFilterString := '';

        lrecLogRunLine.SETCURRENTKEY("Source Doc. Ref. Type", "Source Doc. Ref. No.");

        lrecLogRunLine.SETRANGE("Source Doc. Ref. Type", lrecLogRunLine."Source Doc. Ref. Type"::"Purchase Order");
        lrecLogRunLine.SETRANGE("Source Doc. Ref. No.");
        lrecLogRunLine.SETRANGE("Run No.", LogRunHeader."No.");
        lrecLogRunLine.SETRANGE("Line No.");

        IF lrecLogRunLine.FINDSET THEN BEGIN
            REPEAT
                lrecTEMPPurchOrder."No." := lrecLogRunLine."Source Doc. Ref. No.";
                IF lrecTEMPPurchOrder.INSERT THEN;
            UNTIL lrecLogRunLine.NEXT = 0;
        END;

        IF lrecTEMPPurchOrder.FINDSET THEN BEGIN
            REPEAT
                IF ltxtFilterString = '' THEN
                    ltxtFilterString := lrecTEMPPurchOrder."No."
                ELSE
                    ltxtFilterString := ltxtFilterString + '|' + lrecTEMPPurchOrder."No.";
            UNTIL lrecTEMPPurchOrder.NEXT = 0;
        END;

        IF ltxtFilterString <> '' THEN BEGIN
            lrecPurchOrder.SETRANGE("Document Type", lrecPurchOrder."Document Type"::Order);
            lrecPurchOrder.SETFILTER("No.", ltxtFilterString);

            ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"Purchase Order");
            ReportSelection.SETFILTER("Report ID", '<>0');

            IF pblnPackageOnly THEN
                ReportSelection.SETRANGE("Include In Logistics Package", TRUE);

            IF ReportSelection.FINDSET THEN BEGIN
                REPEAT
                    REPORT.RUNMODAL(ReportSelection."Report ID", TRUE, FALSE, lrecPurchOrder);
                UNTIL ReportSelection.NEXT = 0;
            END ELSE BEGIN
                IF NOT pblnPackageOnly THEN
                    ReportSelection.FINDFIRST;
            END;
        END;


        //-- Purhase Receipt
        ltxtFilterString := '';

        lrecLogRunLine.SETCURRENTKEY("Source Doc. Ref. Type", "Source Doc. Ref. No.");

        lrecLogRunLine.SETRANGE("Source Doc. Ref. Type", lrecLogRunLine."Source Doc. Ref. Type"::"Posted Purchase Receipt");
        lrecLogRunLine.SETRANGE("Source Doc. Ref. No.");
        lrecLogRunLine.SETRANGE("Run No.", LogRunHeader."No.");
        lrecLogRunLine.SETRANGE("Line No.");

        IF lrecLogRunLine.FINDSET THEN BEGIN
            REPEAT
                lrecTEMPReceipt."No." := lrecLogRunLine."Source Doc. Ref. No.";
                IF lrecTEMPReceipt.INSERT THEN;
            UNTIL lrecLogRunLine.NEXT = 0;
        END;

        IF lrecTEMPReceipt.FINDSET THEN BEGIN
            REPEAT
                IF ltxtFilterString = '' THEN
                    ltxtFilterString := lrecTEMPReceipt."No."
                ELSE
                    ltxtFilterString := ltxtFilterString + '|' + lrecTEMPReceipt."No.";
            UNTIL lrecTEMPReceipt.NEXT = 0;
        END;

        IF ltxtFilterString <> '' THEN BEGIN
            lrecReceipt.SETFILTER("No.", ltxtFilterString);

            ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"Purchase Receipt");
            ReportSelection.SETFILTER("Report ID", '<>0');

            IF pblnPackageOnly THEN
                ReportSelection.SETRANGE("Include In Logistics Package", TRUE);

            IF ReportSelection.FINDSET THEN BEGIN
                REPEAT
                    REPORT.RUNMODAL(ReportSelection."Report ID", TRUE, FALSE, lrecReceipt);
                UNTIL ReportSelection.NEXT = 0;
            END ELSE BEGIN
                IF NOT pblnPackageOnly THEN
                    ReportSelection.FINDFIRST;
            END;
        END;

        //-- Transfer Receipt
        ltxtFilterString := '';

        lrecLogRunLine.SETCURRENTKEY("Source Doc. Ref. Type", "Source Doc. Ref. No.");

        lrecLogRunLine.SETRANGE("Source Doc. Ref. Type", lrecLogRunLine."Source Doc. Ref. Type"::"Posted Transfer Receipt");
        lrecLogRunLine.SETRANGE("Source Doc. Ref. No.");
        lrecLogRunLine.SETRANGE("Run No.", LogRunHeader."No.");
        lrecLogRunLine.SETRANGE("Line No.");

        IF lrecLogRunLine.FINDSET THEN BEGIN
            REPEAT
                lrecTEMPTransRcptHeader."No." := lrecLogRunLine."Source Doc. Ref. No.";
                IF lrecTEMPTransRcptHeader.INSERT THEN;
            UNTIL lrecLogRunLine.NEXT = 0;
        END;

        IF lrecTEMPTransRcptHeader.FINDSET THEN BEGIN
            REPEAT
                IF ltxtFilterString = '' THEN
                    ltxtFilterString := lrecTEMPTransRcptHeader."No."
                ELSE
                    ltxtFilterString := ltxtFilterString + '|' + lrecTEMPTransRcptHeader."No.";
            UNTIL lrecTEMPTransRcptHeader.NEXT = 0;
        END;

        IF ltxtFilterString <> '' THEN BEGIN
            lrecTransRcptHeader.SETFILTER("No.", ltxtFilterString);

            ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"Transfer Receipt");
            ReportSelection.SETFILTER("Report ID", '<>0');

            IF pblnPackageOnly THEN
                ReportSelection.SETRANGE("Include In Logistics Package", TRUE);

            IF ReportSelection.FINDSET THEN BEGIN
                REPEAT
                    REPORT.RUNMODAL(ReportSelection."Report ID", TRUE, FALSE, lrecTransRcptHeader);
                UNTIL ReportSelection.NEXT = 0;
            END ELSE BEGIN
                IF NOT pblnPackageOnly THEN
                    ReportSelection.FINDFIRST;
            END;
        END;

    end;

    [EventSubscriber(ObjectType::Page, Page::"Logistics Run", 'OnAfterActionEvent', 'LogisticsPackage', true, true)]

    local procedure PrintCustomerLogisticsDocuments(var Rec: Record "Logistics Run Header")
    var
        LogisticsRunLine: Record "Logistics Run Line";
        SalesHeader: Record "Sales Header";
        Cust: Record "Customer";
        PostedWhseShipmentHeader: Record "Posted Whse. Shipment Header";
        ReportSelection: Record "Logistics Report Selections";
        BillOfLadingFilter: Text;
        ProFormaFilter: Text;
        Log: Codeunit "Logistics Document-Print";
        i: Integer;
        Copies: Integer;
        DriverManifest: Report "Driver Manifest - HT";
        SalesConfReport: Report "Sales - Order Conf. (Word)-HT";
        BillofLadingReport: Report "Posted Whse. Shipment - HT";
        ReportParameters: Text[2048];
    begin
        ReportParameters := DriverManifest.RunRequestPage();
        Copies := drivermanifest.GetNoOfCopies();
        CopyString := '';

        //Log.jfCheckConfirmedLines(rec);
        for i := 0 to Copies Do BEGIN
            if i <> 0 then
                CopyString := 'COPY';
            PrintLogRunDocs(Rec, TRUE);
            PrintLogRunSourceDocs(Rec, TRUE);
            PrintLogRunSourceRefDocs(Rec, TRUE);
            clear(BillOfLadingFilter);
            Clear(ProFormaFilter);
            clear(LogisticsRunLine);
            LogisticsRunLine.setrange("Run No.", Rec."No.");
            LogisticsRunLine.FindSet();
            //create filters
            repeat
                clear(SalesHeader);
                clear(Cust);
                case LogisticsRunLine."Source Doc. Ref. Type" of
                    LogisticsRunLine."Source Doc. Ref. Type"::"Sales Order":
                        if SalesHeader.get(SalesHeader."Document Type"::Order, LogisticsRunLine."Source Doc. Ref. No.") then
                            Cust.get(SalesHeader."Sell-to Customer No.");
                end; //case LogisticsRunLine."Source Doc. Ref. Type" of
                if Cust."No." <> '' then begin
                    if (Cust."Print on Document" = Cust."Print on Document"::"Bill of Lading") or (Cust."Print on Document" = Cust."Print on Document"::Both) then
                        case LogisticsRunLine."Source Type" of
                            7320: //Warehouse Shipment Header
                                if BillOfLadingFilter = '' then
                                    BillOfLadingFilter := LogisticsRunLine."Source No."
                                else
                                    if StrPos(BillOfLadingFilter, LogisticsRunLine."Source No.") = 0 then BillOfLadingFilter := BillOfLadingFilter + '|' + LogisticsRunLine."Source No.";
                        end; //case LogisticsRunLine."Source Doc. Ref. Type" of
                    if (Cust."Print on Document" = Cust."Print on Document"::"Pro-Forma") or (Cust."Print on Document" = Cust."Print on Document"::Both) then
                        if SalesHeader."No." <> '' then
                            if LogisticsRunLine."Source Doc. Ref. Type" = LogisticsRunLine."Source Doc. Ref. Type"::"Sales Order" then
                                if ProFormaFilter = '' then
                                    ProFormaFilter := LogisticsRunLine."Source Doc. Ref. No."
                                else
                                    if StrPos(ProFormaFilter, LogisticsRunLine."Source Doc. Ref. No.") = 0 then ProFormaFilter := ProFormaFilter + '|' + LogisticsRunLine."Source Doc. Ref. No.";
                end; //if Cust."No." <> '' then begin
            until LogisticsRunLine.Next() = 0;
            if BillOfLadingFilter <> '' then begin
                Clear(ReportSelection);
                Clear(PostedWhseShipmentHeader);
                PostedWhseShipmentHeader.SetFilter("Whse. Shipment No.", BillOfLadingFilter); //The Logistics Run Line has the unposted Whse Shipment Doc No.
                if PostedWhseShipmentHeader.FindFirst() then begin
                    ReportSelection.SetRange(Usage, ReportSelection.Usage::"Bill of Lading");
                    ReportSelection.SetFilter("Report ID", '<>0');
                    ReportSelection.SetRange("Include In Logistics Package", true); //EN1.00
                    if ReportSelection.FindSet() then
                        repeat
                            if ReportSelection."Report ID" = 50006 then begin

                                BillofLadingReport.UseRequestPage(false);
                                BillofLadingReport.SetTableView(PostedWhseShipmentHeader);
                                BillofLadingReport.SetCopyText(CopyString);
                                BillofLadingReport.Run();
                            end else
                                REPORT.RunModal(ReportSelection."Report ID", false, false, PostedWhseShipmentHeader);
                        until ReportSelection.Next() = 0;
                end; //if PostedWhseShipmentHeader.FindFirst() then begin
            end; //if BillOfLadingFilter <> '' then begin
            if ProFormaFilter <> '' then begin
                Clear(ReportSelection);
                SalesHeader.setrange("Document Type", SalesHeader."Document Type"::Order);
                SalesHeader.SetFilter("No.", ProFormaFilter);
                if SalesHeader.FindFirst() then begin
                    ReportSelection.SetRange(Usage, ReportSelection.Usage::"Sales Order");
                    ReportSelection.SetFilter("Report ID", '<>0');
                    ReportSelection.SetRange("Include In Logistics Package", true); //EN1.00
                    if ReportSelection.FindSet() then
                        repeat
                            if ReportSelection."Report ID" = 50001 then begin

                                SalesConfReport.UseRequestPage(false);
                                SalesConfReport.SetTableView(SalesHeader);
                                SalesConfReport.SetCopyText(CopyString);
                                SalesConfReport.Run();
                            end else
                                REPORT.RunModal(ReportSelection."Report ID", false, false, SalesHeader);

                        until ReportSelection.Next() = 0;
                end; //if SalesHeader.FindFirst() then begin
            end; //if ProFormaFilter <> '' then begin
        end;
    end;

    var
        CopyString: Text[20];
}

