{ pkgs ? import <nixpkgs> {} }:
let
  pname = "Skydimo";
  version = "1.0";

  src = pkgs.fetchurl {
    url = "https://github.com/lmadln/skydimo-source/releases/download/1.0/Skydimo_3.0.3-rc9.16_linux_x86_64-beta.AppImage";
    sha256 = "sha256:434cc0f17deec121bef168ecd4faaca7836561fee146d7ee1030ea93f811817b";
  };

  appimageContents = pkgs.appimageTools.extract {
    inherit pname version src;
  };
in
pkgs.appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/*.desktop -t $out/share/applications/

    sed -i "s|^Exec=.*|Exec=${pname}|" $out/share/applications/*.desktop

    if [ -d "${appimageContents}/usr/share/icons" ]; then
      mkdir -p $out/share
      cp -r ${appimageContents}/usr/share/icons $out/share/
    else
      install -m 444 -D ${appimageContents}/*.png $out/share/icons/hicolor/512x512/apps/${pname}.png || true
    fi
  '';

  extraPkgs = pkgs: [ 
    pkgs.libayatana-appindicator
    pkgs.libgpg-error
  ];

  profile = ''
    export LD_PRELOAD="${pkgs.glib.out}/lib/libglib-2.0.so.0:${pkgs.pcre2.out}/lib/libpcre2-8.so.0:${pkgs.wayland}/lib/libwayland-client.so.0"
    
    export GDK_BACKEND=x11
    export EGL_PLATFORM=x11
    
    export WEBKIT_DISABLE_DMABUF_RENDERER=1
    export WEBKIT_DISABLE_COMPOSITING_MODE=1
    export LIBGL_ALWAYS_SOFTWARE=1
  '';
}
