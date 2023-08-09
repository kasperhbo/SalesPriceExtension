codeunit 50302 "Price Source Group - Project" implements "Price Source Group"
{
    var
        SalesSourceType: Enum "Sales Price Source Type";

    procedure IsSourceTypeSupported(SourceType: Enum "Price Source Type"): Boolean
    var
        Ordinals: list of [Integer];
    begin
        Ordinals := SalesSourceType.Ordinals();
        exit(Ordinals.Contains(SourceType.AsInteger()));
    end;

    procedure GetGroup() SourceGroup: Enum "Price Source Group"
    begin
        exit(SourceGroup::Project)
    end;

}
