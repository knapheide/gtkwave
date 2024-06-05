{ bzip2, fetchurl, glib, gperf, gtk3, gtk-mac-integration, judy, lib, pkg-config
, clangStdenv, tcl, tk, wrapGAppsHook3, xz, meson, ninja, flex, gobject-introspection
}:

clangStdenv.mkDerivation rec {
  pname = "gtkwave";
  version = "3.3.119";

  # src = fetchurl {
  #   url = "mirror://sourceforge/gtkwave/${pname}-gtk3-${version}.tar.gz";
  #   sha256 = "sha256-6rPgnnZBEVwHhIv7MPfdDDu+K4y+RQF+leB327pqwDg=";
  # };
  src = ./.;

  nativeBuildInputs = [ meson ninja pkg-config wrapGAppsHook3 ];
  buildInputs =
    [ flex gobject-introspection bzip2 glib gperf gtk3 judy tcl tk xz ];

  configureFlags = [
    "--with-tcl=${tcl}/lib"
    "--with-tk=${tk}/lib"
    "--enable-judy"
    "--enable-gtk3"
  ];

  meta = {
    description = "VCD/Waveform viewer for Unix and Win32";
    homepage = "https://gtkwave.sourceforge.net";
    license = lib.licenses.gpl2Plus;
    maintainers = with lib.maintainers; [ thoughtpolice jiegec jleightcap ];
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
  };
}
