codeunit 50301 "Price Source - Rayon" implements "Price Source"
{

    var
        Rayon: Record Rayon;
        ParentErr: Label 'Parent Source No. myst be blank for Rayon Price Source Type.';

    procedure GetNo(var PriceSource: Record "Price Source")
    begin
        if Rayon.GetBySystemId(PriceSource."Source No.") then begin
            PriceSource."Source No." := Rayon."RayonNO.";
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
        if Rayon.Get(PriceSource."Source No.") then begin
            PriceSource."Source ID" := Rayon.SystemId;
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
        if Rayon.Get(xPriceSource."Source No.") then;
        if (Page.RunModal(Page::RayonLookup, Rayon) = Action::LookupOK) then begin
            xPriceSource.Validate("Source No.", Rayon."RayonNO.");
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
        PriceSource.Description := Rayon."Rayon Name";
        // PriceSource."Currency Code" := 
        PriceSource."Allow Line Disc." := true;
        PriceSource."Price Includes VAT" := false;
        // PriceSource."VAT Bus. Posting Gr. (Price)" := false;

        OnAfterFillAdditionalFields(PriceSource, Rayon);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFillAdditionalFields(var PriceSource: Record "Price Source"; Rayon: Record Rayon)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetId(Var PriceSource: Record "Price Source"; var IsHandled: Boolean)
    begin
    end;

}
