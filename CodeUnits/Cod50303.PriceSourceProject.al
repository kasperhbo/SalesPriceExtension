codeunit 50303 "Price Source - Project" implements "Price Source"
{

    var
        Project: Record CustomerProject;
        ParentErr: Label 'Parent Source No. myst be blank for Project Price Source Type.';

    procedure GetNo(var PriceSource: Record "Price Source")
    begin
        if Project.GetBySystemId(PriceSource."Source No.") then begin
            PriceSource."Source No." := Project."ProjectNO.";
            FillAdditionalFields(PriceSource);
        end
        else begin
            PriceSource.InitSource();
        end;
    end;

    procedure GetId(var PriceSource: Record "Price Source")
    var
        Ishandled: Boolean;
    begin
        OnBeforeGetId(PriceSource, Ishandled);
        if Ishandled then
            exit;
        if Project.Get(PriceSource."Source No.") then begin
            PriceSource."Source ID" := Project.SystemId;
            FillAdditionalFields(PriceSource);
        end else
            PriceSource.InitSource();
    end;


    procedure IsForAmountType(AmountType: Enum "Price Amount Type"): Boolean
    begin
        // Message('Is For Amount Type');
        exit(true);
    end;

    procedure IsSourceNoAllowed() Result: Boolean
    begin
        // Message('Is Source No Allowed');
        Result := true;
    end;


    procedure IsLookupOK(var PriceSource: Record "Price Source"): Boolean
    var
        xPriceSource: Record "Price Source";
    begin
        xPriceSource := PriceSource;
        if Project.Get(xPriceSource."Source No.") then;
        if (Page.RunModal(Page::CustomerProjectLookup, Project) = Action::LookupOK) then begin
            xPriceSource.Validate("Source No.", Project."ProjectNO.");
            PriceSource := xPriceSource;
            exit(true);
        end;
    end;

    procedure VerifyParent(var PriceSource: Record "Price Source"): Boolean
    begin
        // Message('Verify Parent');
        if PriceSource."Parent Source No." <> '' then
            Error(ParentErr);
    end;


    procedure GetGroupNo(PriceSource: Record "Price Source"): Code[20]
    begin
        // Message('Is Source No Allowed');
        exit(PriceSource."Source No.");
    end;

    local procedure FillAdditionalFields(var PriceSource: Record "Price Source")
    begin
        PriceSource.Description := Project.ProjectName;
        // PriceSource."Currency Code" := 
        PriceSource."Allow Line Disc." := true;
        PriceSource."Price Includes VAT" := false;
        // PriceSource."VAT Bus. Posting Gr. (Price)" := false;

        OnAfterFillAdditionalFields(PriceSource, Project);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFillAdditionalFields(var PriceSource: Record "Price Source"; Project: Record CustomerProject)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetId(Var PriceSource: Record "Price Source"; var IsHandled: Boolean)
    begin
    end;

}
