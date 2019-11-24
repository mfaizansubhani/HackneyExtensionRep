pageextension 50000 "CustomerCardExt" extends "Customer Card" //21
{
  layout
  {
    addafter("Shipping")
    {
      group("Family Brands")
      {
        field("Member No.";"Member No.")
        {
          ApplicationArea = All;
          Caption = 'Member No.';
        }
        field("Member Location";"Member Location")
        {
          ApplicationArea = All;
          Caption = 'Member Location';
        }
        field("Member DUNS No.";"Member DUNS No.")
        {
          ApplicationArea = All;
          Caption = 'Member DUNS No.';
        }
        field("Print on Document";"Print on Document")
        {
          ApplicationArea = All;
          Caption = 'Print on Document';
        }
      }
    }
  }
  actions
  {
  }
}
