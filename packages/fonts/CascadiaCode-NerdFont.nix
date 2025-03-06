{ pkgs, stdenv, lib }:

stdenv.mkDerivation rec {
  pname = "CascadiaCode";
  version = "3.3.0";

  # URL of the zip file containing the font release
  src = pkgs.fetchzip {
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/${pname}.zip";
    sha256 = "sha256-9CQnowQC+SBej5LLnREioIIqokKlRIzqpBFkCoF3dF0=";
    stripRoot = false;
  };

  installPhase = ''
    runHook preInstall

    install -Dm644 *.ttf -t $out/share/fonts/truetype

    runHook posInstall
  '';

  # Metadata for the package
  meta = with lib; {
    description = "Cascadia Code Nerd Font";
    platforms = platforms.linux;
    license = licenses.mit;
  };
}

