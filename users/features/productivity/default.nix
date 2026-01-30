{ inputs, lib, config, pkgs, username, ... }:

let
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive)
      scheme-basic dvisvgm dvipng # for preview and export as html
      wrapfig amsmath ulem hyperref capt-of;
    # (setq org-preview-latex-default-process 'dvisvgm)
  });
in {

  home.packages = with pkgs; [ openpomodoro-cli anki-bin qalculate-gtk tex ];

  home.persistence."/persist" = {
    directories = [ ".local/share/Anki2" ];
  };
}
