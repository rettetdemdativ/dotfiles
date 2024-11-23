{ inputs, lib, config, pkgs, ... }:

let
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive)
      scheme-basic dvisvgm dvipng # for preview and export as html
      wrapfig amsmath ulem hyperref capt-of;
    # (setq org-preview-latex-default-process 'dvisvgm)
  });
in {

  home.packages = with pkgs; [ anki-bin qalculate-gtk tex ];
}
