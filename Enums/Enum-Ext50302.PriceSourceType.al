enumextension 50302 "Price Source Type" extends "Price Source Type"
{
    value(50300; Rayon)
    {
        Caption = 'Rayon';
        Implementation = "Price Source" = "Price Source - Rayon",
        "Price Source Group" = "Price Source Group - All";
    }

    value(50301; Project)
    {
        Caption = 'Project';
        Implementation = "Price Source" = "Price Source - Project",
        "Price Source Group" = "Price Source Group - All";
    }
}
