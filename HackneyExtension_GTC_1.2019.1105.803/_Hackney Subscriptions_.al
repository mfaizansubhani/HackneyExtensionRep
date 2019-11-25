codeunit 50000 "Hackney Subscriptions"
{
    EventSubscriberInstance = StaticAutomatic;

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
    begin
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
                        REPORT.RunModal(ReportSelection."Report ID", true, false, PostedWhseShipmentHeader);
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
                        REPORT.RunModal(ReportSelection."Report ID", true, false, SalesHeader);
                    until ReportSelection.Next() = 0;
            end; //if SalesHeader.FindFirst() then begin
        end; //if ProFormaFilter <> '' then begin
    end;
}
