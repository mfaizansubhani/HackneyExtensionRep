report 50004 "Driver Manifest - HT"
{
  // Copyright Axentia Solutions Corp. 1999-2013.
  // By opening this object you acknowledge that this object includes confidential information and intellectual
  // property of Axentia Solutions Corp. and that this work is protected by Canadian, U.S. and international
  // copyright laws and agreements.
  // 
  // JF04930AC
  //   20090826
  //     support for Transfer Line-level comments
  // 
  // JF5352SHR
  //   20091009 - Added new dataitem and code to include Misc. Logistic Run Lines
  // 
  // JF07785AC
  //   20100422 - dummy param for fn
  // 
  // JF12957AC
  //   20110527 - rename Date/Time fields (OLD --> NEW)
  //     Planned Pickup Date --> Planned Arrival Date
  //     Planned Pickup Time --> Planned Arrival Time
  //     Planned Load Date --> Planned Departure Date
  //     Planned Load Time --> Planned Departure Time
  //     Pickup Arrival Date --> Actual Arrival Date
  //     Pickup Arrival Time --> Actual Arrival Time
  //     Pickup Departure Date --> Actual Departure Date
  //     Pickup Departure Time --> Actual Departure Time
  // 
  // JF13410AC
  //   20110623
  //     rename existing "Trailer No." to "Trailer Reference No."
  // 
  // JF32297BB
  //   20130718 Modified Trigger: CopyLoop - OnAfterGetRecord.
  // RD15608SHR 20181029 - Increase Address variables from 50 to 90
  DefaultLayout = RDLC;
  RDLCLayout = './src/report/layouts/Rep50004.DriverManifestHT.rdl';
  UsageCategory = ReportsAndAnalysis;
  ApplicationArea = All;
  Caption = 'Driver Manifest';

  dataset
  {
  dataitem("Logistics Run Header";
  "Logistics Run Header")
  {
  DataItemTableView = SORTING("No.");
  RequestFilterFields = "No.";

  column(Logistics_Run_Header_No_;
  "No.")
  {
  }
  column(CompInfoPic;
  CompanyInformation.Picture)
  {
  }
  dataitem("Logistics Run Line";
  "Logistics Run Line")
  {
  DataItemLink = "Run No."=FIELD("No.");
  DataItemTableView = SORTING("Appointment Date", "Appointment Time")ORDER(Ascending);

  trigger OnAfterGetRecord()begin
    grecTEMPLogLine.Init();
    grecTEMPLogLine.TransferFields("Logistics Run Line");
    grecTEMPLogLine.Insert();
  end;
  }
  dataitem("Misc. Logistics Run Line";
  "Misc. Logistics Run Line")
  {
  DataItemLink = "Run No."=FIELD("No.");
  DataItemTableView = SORTING("Appointment Date", "Appointment Time")ORDER(Ascending);

  trigger OnAfterGetRecord()begin
    //<JF5352SHR>
    grecTEMPLogLine.Init();
    grecTEMPLogLine."Run No.":="Misc. Logistics Run Line"."Run No.";
    grecTEMPLogLine."Line No.":=gintLineNo;
    grecTEMPLogLine.Type:="Misc. Logistics Run Line".Type;
    grecTEMPLogLine."Appointment Date":="Misc. Logistics Run Line"."Appointment Date";
    grecTEMPLogLine."Appointment Time":="Misc. Logistics Run Line"."Appointment Time";
    grecTEMPLogLine."Appointment No.":="Misc. Logistics Run Line"."Appointment No.";
    grecTEMPLogLine."Seal No.":="Misc. Logistics Run Line"."Seal No.";
    grecTEMPLogLine.Insert();
    grecTEMPMiscLogRunLine.Init();
    grecTEMPMiscLogRunLine.TransferFields("Misc. Logistics Run Line");
    grecTEMPMiscLogRunLine."Line No.":=gintLineNo;
    grecTEMPMiscLogRunLine.Insert();
    gintLineNo:=gintLineNo + 10000;
  //<JF5352SHR>
  end;
  trigger OnPreDataItem()begin
    //<JF5352SHR>
    Clear(grecTEMPMiscLogRunLine);
    Clear(gintLineNo);
    grecTEMPLogLine.Reset();
    grecTEMPLogLine.SetCurrentKey("Run No.", "Line No.");
    if grecTEMPLogLine.FindLast()then gintLineNo:=grecTEMPLogLine."Line No." + 10000
    else
      gintLineNo:=10000;
  //</JF5352SHR>
  end;
  }
  dataitem(CopyLoop;
  "Integer")
  {
  DataItemTableView = SORTING(Number);

  dataitem(PageLoop;
  "Integer")
  {
  DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

  column(CopyNo;
  CopyNo)
  {
  }
  column(CarrierAddress_1_;
  CarrierAddress[1])
  {
  }
  column(CarrierAddress_2_;
  CarrierAddress[2])
  {
  }
  column(CarrierAddress_3_;
  CarrierAddress[3])
  {
  }
  column(CarrierAddress_4_;
  CarrierAddress[4])
  {
  }
  column(CopyTxt;
  CopyTxt)
  {
  }
  column(CompanyAddress_5_;
  CompanyAddress[5])
  {
  }
  column(CompanyAddress_4_;
  CompanyAddress[4])
  {
  }
  column(CurrReport_PAGENO;
  CurrReport.PageNo())
  {
  }
  column(CompanyAddress_3_;
  CompanyAddress[3])
  {
  }
  column(CompanyAddress_2_;
  CompanyAddress[2])
  {
  }
  column(Logistics_Run_Header___Date_Created_;
  "Logistics Run Header"."Date Created")
  {
  }
  column(CompanyAddress_1_;
  CompanyAddress[1])
  {
  }
  column(CarrierAddress_5_;
  CarrierAddress[5])
  {
  }
  column(CarrierAddress_6_;
  CarrierAddress[6])
  {
  }
  column(CarrierAddress_7_;
  CarrierAddress[7])
  {
  }
  column(CarrierAddress_8_;
  CarrierAddress[8])
  {
  }
  column(Logistics_Run_Header___Driver_Name_;
  "Logistics Run Header"."Driver Name")
  {
  }
  column(FORMAT__Logistics_Run_Header___Total_Distance_____________Logistics_Run_Header___Total_Distance_Unit_of_Measure_;
  Format("Logistics Run Header"."Total Distance") + '  ' + "Logistics Run Header"."Total Distance Unit of Measure")
  {
  }
  column(Logistics_Run_Header___Trailer_Reference_No__;
  "Logistics Run Header"."Trailer Reference No.")
  {
  }
  column(Logistics_Run_Header___Planned_Arrival_DateTime_;
  "Logistics Run Header"."Planned Arrival DateTime")
  {
  }
  column(Logistics_Run_Header___Pickup_Location_Code_;
  "Logistics Run Header"."Pickup Location Code")
  {
  }
  column(Logistics_Run_Header___Pickup_Dock_No__;
  "Logistics Run Header"."Pickup Dock No.")
  {
  }
  column(Page_Caption;
  Page_CaptionLbl)
  {
  }
  column(DateCaption;
  DateCaptionLbl)
  {
  }
  column(Run_No_Caption;
  Run_No_CaptionLbl)
  {
  }
  column(CarrierCaption;
  CarrierCaptionLbl)
  {
  }
  column(DRIVER_MANIFESTCaption;
  DRIVER_MANIFESTCaptionLbl)
  {
  }
  column(Driver_NameCaption;
  Driver_NameCaptionLbl)
  {
  }
  column(Total_DistanceCaption;
  Total_DistanceCaptionLbl)
  {
  }
  column(Logistics_Run_Header___Trailer_Reference_No__Caption;
  Logistics_Run_Header___Trailer_Reference_No__CaptionLbl)
  {
  }
  column(Logistics_Run_Header___Planned_Arrival_DateTime_Caption;
  Logistics_Run_Header___Planned_Arrival_DateTime_CaptionLbl)
  {
  }
  column(Logistics_Run_Header___Pickup_Location_Code_Caption;
  Logistics_Run_Header___Pickup_Location_Code_CaptionLbl)
  {
  }
  column(Logistics_Run_Header___Pickup_Dock_No__Caption;
  Logistics_Run_Header___Pickup_Dock_No__CaptionLbl)
  {
  }
  column(FORMAT_grecTEMPLogLine_Type_Caption;
  FORMAT_grecTEMPLogLine_Type_CaptionLbl)
  {
  }
  column(grecTEMPLogLine__Appointment_Date_Caption;
  grecTEMPLogLine__Appointment_Date_CaptionLbl)
  {
  }
  column(grecTEMPLogLine__Appointment_Time_Caption;
  grecTEMPLogLine__Appointment_Time_CaptionLbl)
  {
  }
  column(grecTEMPLogLine__Appointment_No__Caption;
  grecTEMPLogLine__Appointment_No__CaptionLbl)
  {
  }
  column(Actual_DateCaption;
  Actual_DateCaptionLbl)
  {
  }
  column(Actual_TimeCaption;
  Actual_TimeCaptionLbl)
  {
  }
  column(gcodSealDisplayCaption;
  gcodSealDisplayCaptionLbl)
  {
  }
  column(AddressCaption;
  AddressCaptionLbl)
  {
  }
  column(PageLoop_Number;
  Number)
  {
  }
  dataitem(LogisticsLine;
  "Integer")
  {
  DataItemTableView = SORTING(Number);

  column(FORMAT_grecTEMPLogLine_Type_;
  Format(grecTEMPLogLine.Type))
  {
  }
  column(grecTEMPLogLine__Appointment_Date_;
  grecTEMPLogLine."Appointment Date")
  {
  }
  column(grecTEMPLogLine__Appointment_Time_;
  grecTEMPLogLine."Appointment Time")
  {
  }
  column(grecTEMPLogLine__Appointment_No__;
  grecTEMPLogLine."Appointment No.")
  {
  }
  column(gcodSealDisplay;
  gcodSealDisplay)
  {
  }
  column(SourceAddress_1_;
  SourceAddress[1])
  {
  }
  column(SourceAddress_2_;
  SourceAddress[2])
  {
  }
  column(SourceAddress_3_;
  SourceAddress[3])
  {
  }
  column(SourceAddress_4_;
  SourceAddress[4])
  {
  }
  column(SourceAddress_5_;
  SourceAddress[5])
  {
  }
  column(SourceAddress_6_;
  SourceAddress[6])
  {
  }
  column(SourceAddress_7_;
  SourceAddress[7])
  {
  }
  column(SourceAddress_8_;
  SourceAddress[8])
  {
  }
  column(Order_No________grecTEMPSourceRefDoc__External_Document_No__;
  'Order No.:  ' + grecTEMPSourceRefDoc."External Document No.")
  {
  }
  column(EmptyStringCaption;
  EmptyStringCaptionLbl)
  {
  }
  column(EmptyStringCaption_Control1101769046;
  EmptyStringCaption_Control1101769046Lbl)
  {
  }
  column(LogisticsLine_Number;
  Number)
  {
  }
  column(grecTEMPLogLine_StopNo;
  grecTEMPLogLine."Stop No.")
  {
  }
  dataitem(SourceDocComments;
  "Integer")
  {
  DataItemTableView = SORTING(Number);

  column(grecTEMPCommentLine_Comment;
  grecTEMPCommentLine.Comment)
  {
  }
  column(SourceDocComments_Number;
  Number)
  {
  }
  trigger OnAfterGetRecord()begin
    gintOnCommNumber+=1;
    with grecTEMPCommentLine do if gintOnCommNumber = 1 then Find('-')
      else
        Next();
  end;
  trigger OnPreDataItem()begin
    gintCommCounter:=0;
    gintOnCommNumber:=0;
    if not gblnPrintSourceDocComm then CurrReport.Break()
    else
    begin
      jfGetSourceDocComments();
      gintCommCounter:=grecTEMPCommentLine.Count();
      SetRange(Number, 1, gintCommCounter);
    end;
  end;
  }
  dataitem(SourceRefDocComments;
  "Integer")
  {
  DataItemTableView = SORTING(Number);

  column(grecTEMPCommentLine_Comment_Control23019001;
  grecTEMPCommentLine.Comment)
  {
  }
  column(SourceRefDocComments_Number;
  Number)
  {
  }
  trigger OnAfterGetRecord()begin
    gintOnCommNumber+=1;
    with grecTEMPCommentLine do if gintOnCommNumber = 1 then Find('-')
      else
        Next();
  end;
  trigger OnPreDataItem()begin
    gintCommCounter:=0;
    gintOnCommNumber:=0;
    if not gblnPrintSourceRefDocComm then CurrReport.Break()
    else
    begin
      jfGetSourceRefDocComments();
      gintCommCounter:=grecTEMPCommentLine.Count();
      SetRange(Number, 1, gintCommCounter);
    end;
  end;
  }
  trigger OnAfterGetRecord()var lrecVendor: Record Vendor;
  lrecCustomer: Record Customer;
  lrecLocation: Record Location;
  lrecShipTo: Record "Ship-to Address";
  lrecOrderAddress: Record "Order Address";
  begin
    OnLineNumber:=OnLineNumber + 1;
    with grecTEMPLogLine do begin
      if OnLineNumber = 1 then Find('-')
      else
        Next();
      Clear(gcodSealDisplay);
      //<JF001104MG>
      grecTEMPCommentLine.DeleteAll();
      Clear(grecTEMPCommentLine);
      //</JF001104MG>
      case Type of Type::Pickup: if grecTEMPLogLine."Seal No." = '' then gcodSealDisplay:='________________________________'
        else
          gcodSealDisplay:=grecTEMPLogLine."Seal No.";
      Type::"Drop-Off": if grecTEMPLogLine."Seal No." = '' then gcodSealDisplay:='________________________________'
        else
          gcodSealDisplay:=grecTEMPLogLine."Seal No.";
      end;
      Clear(grecTEMPSourceRefDoc);
      grecTEMPSourceRefDoc.DeleteAll();
      //<JF07785AC>
      grecTEMPLogLine.jfGetSourceRefDoc(grecTEMPSourceRefDoc, gtxtPhoneNo);
      //</JF07785AC>
      Clear(SourceAddress);
      //<JF5352SHR>
      if grecTEMPMiscLogRunLine.Get(grecTEMPLogLine."Run No.", grecTEMPLogLine."Line No.")then FormatAddress.jfMiscLogRunAddress(SourceAddress, grecTEMPMiscLogRunLine)
      else
        //</JF5352SHR>
        case grecTEMPLogLine."Pick-up/Drop-off Type" of grecTEMPLogLine."Pick-up/Drop-off Type"::Customer: if grecTEMPLogLine."Pick-up/Drop-off Code" <> '' then begin
            if lrecShipTo.Get(grecTEMPLogLine."Pick-up/Drop-off No.", grecTEMPLogLine."Pick-up/Drop-off Code")then FormatAddress.jfShipTo(SourceAddress, lrecShipTo);
          end
          else if lrecCustomer.Get(grecTEMPLogLine."Pick-up/Drop-off No.")then FormatAddress.Customer(SourceAddress, lrecCustomer);
        grecTEMPLogLine."Pick-up/Drop-off Type"::Vendor: if grecTEMPLogLine."Pick-up/Drop-off Code" <> '' then begin
            if lrecOrderAddress.Get(grecTEMPLogLine."Pick-up/Drop-off No.", grecTEMPLogLine."Pick-up/Drop-off Code")then FormatAddress.jfOrderAddress(SourceAddress, lrecOrderAddress);
          end
          else if lrecVendor.Get(grecTEMPLogLine."Pick-up/Drop-off No.")then FormatAddress.Vendor(SourceAddress, lrecVendor);
        grecTEMPLogLine."Pick-up/Drop-off Type"::Location: if lrecLocation.Get(grecTEMPLogLine."Pick-up/Drop-off No.")then FormatAddress.jfLocation(SourceAddress, lrecLocation);
        end;
    //<JF5352SHR>
    //</JF5352SHR>
    end;
  end;
  trigger OnPreDataItem()begin
    //grecTEMPLogLine.SetCurrentKey(grecTEMPLogLine."Appointment Date",grecTEMPLogLine."Appointment Time");
    grecTEMPLogLine.SetCurrentKey("Stop No.");
    NumberOfLines:=grecTEMPLogLine.Count();
    SetRange(Number, 1, NumberOfLines);
    OnLineNumber:=0;
  end;
  }
  dataitem("Logistics Comment Line";
  "Logistics Comment Line")
  {
  DataItemTableView = SORTING("Document Type", "No.", "Line No.");

  column(Logistics_Comment_Line_Comment;
  Comment)
  {
  }
  column(CommentsCaption;
  CommentsCaptionLbl)
  {
  }
  column(Logistics_Comment_Line_Document_Type;
  "Document Type")
  {
  }
  column(Logistics_Comment_Line_No_;
  "No.")
  {
  }
  column(Logistics_Comment_Line_Line_No_;
  "Line No.")
  {
  }
  trigger OnPreDataItem()begin
    SetRange("Document Type", "Logistics Comment Line"."Document Type"::"Logistics Run");
    SetRange("No.", "Logistics Run Header"."No.");
    SetRange("Print on Driver Manifest", true);
  end;
  }
  }
  trigger OnAfterGetRecord()begin
    CurrReport.PageNo:=1;
    if CopyNo = NoLoops then begin
      if not CurrReport.Preview()then LogisticsPrinted.Run("Logistics Run Header");
      CurrReport.Break();
    //<JF32297BB>
    end;
    //</JF32297BB>
    CopyNo:=CopyNo + 1;
    if CopyNo = 1 then // Original
 Clear(CopyTxt)
    else
      CopyTxt:=Text000;
  end;
  trigger OnPreDataItem()begin
    NoLoops:=1 + Abs(NoCopies);
    if NoLoops <= 0 then NoLoops:=1;
    CopyNo:=0;
  end;
  }
  trigger OnAfterGetRecord()var lrecShipAgent: Record "Shipping Agent";
  begin
    Clear(CarrierAddress);
    Clear(lrecShipAgent);
    if lrecShipAgent.Get("Shipping Agent Code")then begin
      FormatAddress.jfShipAgent(CarrierAddress, lrecShipAgent);
      if CarrierAddress[1] = '' then CarrierAddress[1]:=lrecShipAgent.Name;
    end;
    grecTEMPLogLine.DeleteAll();
  end;
  trigger OnPreDataItem()begin
    CompanyInformation.Get();
    CompanyInformation.CalcFields(Picture);
    FormatAddress.Company(CompanyAddress, CompanyInformation)end;
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

        field(NoCopies;NoCopies)
        {
          ApplicationArea = JustFood;
          Caption = 'Number of Copies';
        }
        field(gblnPrintSourceDocComm;gblnPrintSourceDocComm)
        {
          ApplicationArea = JustFood;
          Caption = 'Print Source Doc. Comments';
        }
        field(gblnPrintSourceRefDocComm;gblnPrintSourceRefDocComm)
        {
          ApplicationArea = JustFood;
          Caption = 'Print Source Ref. Doc. Comments';
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
  var CompanyInformation: Record "Company Information";
  grecTEMPLogLine: Record "Logistics Run Line" temporary;
  grecTEMPSourceRefDoc: Record "Sales Header" temporary;
  grecTEMPCommentLine: Record "Comment Line" temporary;
  FormatAddress: Codeunit "Format Address";
  LogisticsPrinted: Codeunit "Logistics Run-Printed";
  CarrierAddress: array[8]of Text[90];
  CompanyAddress: array[8]of Text[90];
  SourceAddress: array[8]of Text[90];
  NoLoops: Integer;
  NoCopies: Integer;
  CopyNo: Integer;
  Text000: Label 'COPY';
  CopyTxt: Text[30];
  OnLineNumber: Integer;
  NumberOfLines: Integer;
  gcodSealDisplay: Code[50];
  gblnPrintSourceDocComm: Boolean;
  gblnPrintSourceRefDocComm: Boolean;
  gintCommCounter: Integer;
  gintOnCommNumber: Integer;
  gintLineNo: Integer;
  grecTEMPMiscLogRunLine: Record "Misc. Logistics Run Line" temporary;
  gtxtPhoneNo: Text[30];
  Page_CaptionLbl: Label 'Page:';
  DateCaptionLbl: Label 'Date';
  Run_No_CaptionLbl: Label 'Run No.';
  CarrierCaptionLbl: Label 'Carrier';
  DRIVER_MANIFESTCaptionLbl: Label 'DRIVER MANIFEST';
  Driver_NameCaptionLbl: Label 'Driver Name';
  Total_DistanceCaptionLbl: Label 'Total Distance';
  Logistics_Run_Header___Trailer_Reference_No__CaptionLbl: Label 'Trailer No.';
  Logistics_Run_Header___Planned_Arrival_DateTime_CaptionLbl: Label 'Planned Arrival Date/Time';
  Logistics_Run_Header___Pickup_Location_Code_CaptionLbl: Label 'Planned Pickup Location';
  Logistics_Run_Header___Pickup_Dock_No__CaptionLbl: Label 'Pickup Dock No.';
  FORMAT_grecTEMPLogLine_Type_CaptionLbl: Label 'Type';
  grecTEMPLogLine__Appointment_Date_CaptionLbl: Label 'Scheduled Date';
  grecTEMPLogLine__Appointment_Time_CaptionLbl: Label 'Scheduled Time';
  grecTEMPLogLine__Appointment_No__CaptionLbl: Label 'Appointment No.';
  Actual_DateCaptionLbl: Label 'Actual Date';
  Actual_TimeCaptionLbl: Label 'Actual Time';
  gcodSealDisplayCaptionLbl: Label 'Seal No.';
  AddressCaptionLbl: Label 'Address';
  EmptyStringCaptionLbl: Label '_______________';
  EmptyStringCaption_Control1101769046Lbl: Label '_______________';
  CommentsCaptionLbl: Label 'Comments';
  procedure jfGetSourceDocComments()var lrecWhseShip: Record "Warehouse Shipment Header";
  lrecWhseRcpt: Record "Warehouse Receipt Header";
  lrecPostWhseShip: Record "Posted Whse. Shipment Header";
  lrecPostWhseRcpt: Record "Posted Whse. Receipt Header";
  lrecWhseCommLine: Record "Warehouse Comment Line";
  begin
    grecTEMPCommentLine.DeleteAll;
    Clear(grecTEMPCommentLine);
    with grecTEMPLogLine do begin
      case grecTEMPLogLine."Source Document" of "Source Document"::"Warehouse Shipment": begin
        if lrecWhseShip.Get("Source No.")then begin
          lrecWhseCommLine.SetRange("Table Name", lrecWhseCommLine."Table Name"::"Whse. Shipment");
          lrecWhseCommLine.SetRange(Type);
          lrecWhseCommLine.SetRange("No.", "Source No.");
          lrecWhseCommLine.SetRange("Print On Driver Manifest", true);
          if lrecWhseCommLine.FindSet then begin
            repeat grecTEMPCommentLine.Init;
              grecTEMPCommentLine."Line No.":=lrecWhseCommLine."Line No.";
              grecTEMPCommentLine.Date:=lrecWhseCommLine.Date;
              grecTEMPCommentLine.Comment:=lrecWhseCommLine.Comment;
              grecTEMPCommentLine.Insert;
            until lrecWhseCommLine.Next = 0;
          end;
        end
        else
        begin
          //-- use last posted whse. shipment with same shipmt. no.
          lrecPostWhseShip.SetRange("Whse. Shipment No.", "Source No.");
          if lrecPostWhseShip.FindLast then begin
            lrecWhseCommLine.SetRange("Table Name", lrecWhseCommLine."Table Name"::"Posted Whse. Shipment");
            lrecWhseCommLine.SetRange(Type);
            lrecWhseCommLine.SetRange("No.", lrecPostWhseShip."No.");
            lrecWhseCommLine.SetRange("Print On Driver Manifest", true);
            if lrecWhseCommLine.FindSet then begin
              repeat grecTEMPCommentLine.Init;
                grecTEMPCommentLine."Line No.":=lrecWhseCommLine."Line No.";
                grecTEMPCommentLine.Date:=lrecWhseCommLine.Date;
                grecTEMPCommentLine.Comment:=lrecWhseCommLine.Comment;
                grecTEMPCommentLine.Insert;
              until lrecWhseCommLine.Next = 0;
            end;
          end;
        end;
      end;
      "Source Document"::"Warehouse Receipt": begin
        if lrecWhseRcpt.Get("Source No.")then begin
          lrecWhseCommLine.SetRange("Table Name", lrecWhseCommLine."Table Name"::"Whse. Shipment");
          lrecWhseCommLine.SetRange(Type);
          lrecWhseCommLine.SetRange("No.", "Source No.");
          lrecWhseCommLine.SetRange("Print On Driver Manifest", true);
          if lrecWhseCommLine.FindSet then begin
            repeat grecTEMPCommentLine.Init;
              grecTEMPCommentLine."Line No.":=lrecWhseCommLine."Line No.";
              grecTEMPCommentLine.Date:=lrecWhseCommLine.Date;
              grecTEMPCommentLine.Comment:=lrecWhseCommLine.Comment;
              grecTEMPCommentLine.Insert;
            until lrecWhseCommLine.Next = 0;
          end;
        end
        else
        begin
          //-- use last posted whse. receipt with same rcpt. no.
          lrecPostWhseRcpt.SetRange("Whse. Receipt No.", "Source No.");
          if lrecPostWhseRcpt.FindLast then begin
            lrecWhseCommLine.SetRange("Table Name", lrecWhseCommLine."Table Name"::"Posted Whse. Receipt");
            lrecWhseCommLine.SetRange(Type);
            lrecWhseCommLine.SetRange("No.", lrecPostWhseRcpt."No.");
            lrecWhseCommLine.SetRange("Print On Driver Manifest", true);
            if lrecWhseCommLine.FindSet then begin
              repeat grecTEMPCommentLine.Init;
                grecTEMPCommentLine."Line No.":=lrecWhseCommLine."Line No.";
                grecTEMPCommentLine.Date:=lrecWhseCommLine.Date;
                grecTEMPCommentLine.Comment:=lrecWhseCommLine.Comment;
                grecTEMPCommentLine.Insert;
              until lrecWhseCommLine.Next = 0;
            end;
          end;
        end;
      end;
      end;
    end;
  end;
  procedure jfGetSourceRefDocComments()var lrecSalesCommentLine: Record "Sales Comment Line";
  lrecPurchCommentLine: Record "Purch. Comment Line";
  lrecInvCommentLine: Record "Inventory Comment Line";
  ljfText000: Label 'Can only view ocmments for unposted Source Ref. Documents.';
  begin
    //<JF001104MG>
    grecTEMPCommentLine.DeleteAll;
    Clear(grecTEMPCommentLine);
    with grecTEMPLogLine do begin
      case "Source Doc. Ref. Type" of "Source Doc. Ref. Type"::"Sales Order": begin
        lrecSalesCommentLine.SetRange("Document Type", lrecSalesCommentLine."Document Type"::Order);
        lrecSalesCommentLine.SetRange("No.", "Source Doc. Ref. No.");
        lrecSalesCommentLine.SetRange("Document Line No.", 0);
        lrecSalesCommentLine.SetRange("Print On Driver Manifest", true);
        if lrecSalesCommentLine.FindSet then begin
          repeat grecTEMPCommentLine.Init;
            grecTEMPCommentLine."Line No.":=lrecSalesCommentLine."Line No.";
            grecTEMPCommentLine.Date:=lrecSalesCommentLine.Date;
            grecTEMPCommentLine.Comment:=lrecSalesCommentLine.Comment;
            grecTEMPCommentLine.Insert;
          until lrecSalesCommentLine.Next = 0;
        end;
      end;
      "Source Doc. Ref. Type"::"Transfer Order": begin
        lrecInvCommentLine.SetRange("Document Type", lrecInvCommentLine."Document Type"::"Transfer Order");
        lrecInvCommentLine.SetRange("No.", "Source Doc. Ref. No.");
        //<JF04930AC>
        lrecInvCommentLine.SetRange("Document Line No.", 0);
        //</JF04930AC>
        lrecInvCommentLine.SetRange("Print On Driver Manifest", true);
        if lrecInvCommentLine.FindSet then begin
          repeat grecTEMPCommentLine.Init;
            grecTEMPCommentLine."Line No.":=lrecInvCommentLine."Line No.";
            grecTEMPCommentLine.Date:=lrecInvCommentLine.Date;
            grecTEMPCommentLine.Comment:=lrecInvCommentLine.Comment;
            grecTEMPCommentLine.Insert;
          until lrecInvCommentLine.Next = 0;
        end;
      end;
      "Source Doc. Ref. Type"::"Purchase Order": begin
        lrecPurchCommentLine.SetRange("Document Type", lrecPurchCommentLine."Document Type"::Order);
        lrecPurchCommentLine.SetRange("No.", "Source Doc. Ref. No.");
        lrecPurchCommentLine.SetRange("Document Line No.", 0);
        lrecPurchCommentLine.SetRange("Print On Driver Manifest", true);
        if lrecPurchCommentLine.FindSet then begin
          repeat grecTEMPCommentLine.Init;
            grecTEMPCommentLine."Line No.":=lrecPurchCommentLine."Line No.";
            grecTEMPCommentLine.Date:=lrecPurchCommentLine.Date;
            grecTEMPCommentLine.Comment:=lrecPurchCommentLine.Comment;
            grecTEMPCommentLine.Insert;
          until lrecPurchCommentLine.Next = 0;
        end;
      end;
      end;
    end;
  //</JF001104MG>
  end;
}
