tableextension 50300 "Sales Price" extends "Price List Header"
{
    fields
    {
        modify("Assign-to No.")
        {
            Caption = 'Assign-to No.';
            TableRelation = IF ("Source Type" = CONST(Campaign)) Campaign
            ELSE
            IF ("Source Type" = CONST(Contact)) Contact
            ELSE
            IF ("Source Type" = CONST(Customer)) Customer
            ELSE
            IF ("Source Type" = CONST("Customer Disc. Group")) "Customer Discount Group"
            ELSE
            IF ("Source Type" = CONST("Customer Price Group")) "Customer Price Group"
            ELSE
            IF ("Source Type" = CONST(Job)) Job
            ELSE
            IF ("Source Type" = CONST("Job Task")) "Job Task"."Job Task No." where("Job No." = field("Parent Source No."), "Job Task Type" = CONST(Posting))
            ELSE
            IF ("Source Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Source Type" = CONST(Rayon)) Rayon
            ELSE
            IF ("Source Type" = CONST(Project)) CustomerProject;
        }

        field(50300; "Rayon"; Code[20])
        {
            Caption = '';
            DataClassification = ToBeClassified;
        }

        field(50301; "Project"; Code[20])
        {
            Caption = '';
            DataClassification = ToBeClassified;
        }


    }
}
