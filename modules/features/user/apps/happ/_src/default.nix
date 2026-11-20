{ pkgs ? import <nixpkgs> {} }:
let
  lib = pkgs.lib;
in
pkgs.stdenv.mkDerivation rec {
  pname = "Happ";
  version = "1.0";

  src = pkgs.fetchurl {
    url = "https://github.com/Happ-proxy/happ-desktop/releases/download/4.8.3/Happ.linux.x64.deb";
    sha256 = "sha256:7c6a4f65c81d1febbb00ac036e79fb9d51a1745937f6da6d4d5d85e9e62de9ed";
  };

  nativeBuildInputs = [
    pkgs.dpkg
    pkgs.autoPatchelfHook
    pkgs.makeWrapper
    pkgs.qt6.wrapQtAppsHook
  ];

  dontWrapQtApps = true;

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
    openssl
  ];

  unpackPhase = ''
    dpkg-deb -x $src .
  '';

  installPhase = ''
    mkdir -p $out/bin $out/opt

    if [ -d "usr" ]; then
      cp -r usr/* $out/
    fi

    if [ -d "opt" ]; then
      cp -r opt/* $out/opt/
    fi

    rm -f $out/opt/happ/lib/libxkbcommon* || true

    # Оборачиваем GUI и демон вручную.
    # Используем OpenSSL из Nixpkgs.
    for exe in Happ happd; do
      wrapProgram "$out/opt/happ/bin/$exe" \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ pkgs.openssl ]}" \
        --set SSL_CERT_FILE "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt" \
        --set XKB_CONFIG_ROOT "${pkgs.xorg.xkeyboardconfig}/share/X11/xkb"
    done

    ln -sf $out/opt/happ/bin/Happ $out/bin/happ

    find $out/share/applications -name "*.desktop" -exec sed -i \
      -e "s|/opt/|$out/opt/|g" \
      -e "s|/usr/bin/||g" \
      {} + || true
  '';
}
