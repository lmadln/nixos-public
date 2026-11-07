{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "Happ";
  version = "1.0";

  src = pkgs.fetchurl {
    url = "https://github.com/Happ-proxy/happ-desktop/releases/download/4.7.2/Happ.linux.x64.deb";
    sha256 = "sha256:85140f2ca07df0ba25d02d482a48f6523750931c47fc24ba3be6dc9702b929f4";
  };

  nativeBuildInputs = [
    pkgs.dpkg
    pkgs.autoPatchelfHook
    pkgs.qt6.wrapQtAppsHook
  ];

  buildInputs = with pkgs; [
    stdenv.cc.cc.lib
    wayland
    libGL
    libX11
    libxcb
    qt6.qtwayland
    qt6.qtbase
    e2fsprogs
    libxkbcommon
    xkeyboard-config
    libgpg-error
  ];

  unpackPhase = ''
    dpkg-deb -x $src .
  '';

  qtWrapperArgs = [
    "--set" "XKB_CONFIG_ROOT" "${pkgs.xorg.xkeyboardconfig}/share/X11/xkb"
  ];

  installPhase = ''
    mkdir -p $out/bin $out/opt

    if [ -d "usr" ]; then
      cp -r usr/* $out/
    fi

    if [ -d "opt" ]; then
      cp -r opt/* $out/opt/
    fi

    rm -f $out/opt/happ/lib/libxkbcommon* || true

    find $out/share/applications -name "*.desktop" -exec sed -i "s|/opt/|$out/opt/|g" {} +
    find $out/share/applications -name "*.desktop" -exec sed -i "s|/usr/bin/||g" {} +

    ln -sf $out/opt/happ/bin/Happ $out/bin/happ
  '';
}
