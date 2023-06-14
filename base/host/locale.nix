{ encoding ? "UTF-8"
, language ? "en_US"
, timeZone ? "America/Chicago"
}:
{ ... }:
let
  lang = "${language}.${encoding}";
in
{
  # Set your time zone.
  time = { inherit timeZone; };

  # Select internationalisation properties.
  i18n.defaultLocale = lang;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = lang;
    LC_IDENTIFICATION = lang;
    LC_MEASUREMENT = lang;
    LC_MONETARY = lang;
    LC_NAME = lang;
    LC_NUMERIC = lang;
    LC_PAPER = lang;
    LC_TELEPHONE = lang;
    LC_TIME = lang;
  };
}
