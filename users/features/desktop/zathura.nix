{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.zathura = {
    enable = true;
    options = {
      "notification-error-bg" = "#f44747";
      "notification-error-fg" = "#d4d4d4";
      "notification-warning-bg" = "#dcdcaa";
      "notification-warning-fg" = "#1e1e1e";
      "notification-bg" = "#1e1e1e";
      "notification-fg" = "#569cd6";

      "completion-bg" = "#2d2d30";
      "completion-fg" = "#d4d4d4";
      "completion-group-bg" = "#2d2d30";
      "completion-group-fg" = "#d4d4d4";
      "completion-highlight-bg" = "#062c45";
      "completion-highlight-fg" = "#d4d4d4";

      "index-bg" = "#1e1e1e";
      "index-fg" = "#d4d4d4";
      "index-active-bg" = "#569cd6";
      "index-active-fg" = "#282a36";

      "inputbar-bg" = "#ffaf00";
      "inputbar-fg" = "#1e1e1e";
      "statusbar-bg" = "#0a7aca";
      "statusbar-fg" = "#ffffff";

      "highlight-color" = "#264f78";
      "highlight-active-color" = "#dcdcaa";

      "default-bg" = "#1e1e1e";
      "default-fg" = "#d4d4d4";

      "render-loading" = true;
      "render-loading-fg" = "#1e1e1e";
      "render-loading-bg" = "#d4d4d4";

      "recolor-lightcolor" = "#1e1e1e";
      "recolor-darkcolor" = "#d4d4d4";

      "adjust-open" = "width";
    };
  };
}
