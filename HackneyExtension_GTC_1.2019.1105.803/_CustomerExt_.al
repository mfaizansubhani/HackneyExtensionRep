tableextension 50000 "CustomerExt" extends "Customer" //18
{
  fields
  {
    field(50000;"Member No.";Code[20])
    {
      Caption = 'Member No.';
      DataClassification = CustomerContent;
    }
    field(50010;"Member Location";Code[20])
    {
      Caption = 'Member Location';
      DataClassification = CustomerContent;
    }
    field(50020;"Member DUNS No.";Code[30])
    {
      Caption = 'Member DUNS No.';
      DataClassification = CustomerContent;
    }
    field(50030;"Print on Document";Option)
    {
      Caption = 'Print on Document';
      DataClassification = CustomerContent;
      OptionMembers = "Pro-Forma", "Bill of Lading", "Both";
    }
  }
  var
}
