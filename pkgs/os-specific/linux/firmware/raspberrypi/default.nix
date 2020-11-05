{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "raspberrypi-firmware";
  version = "1.20200819";

  src = fetchFromGitHub {
    owner = "raspberrypi";
    repo = "firmware";
    rev = version;
    sha256 = "1wwy49ndddsvf0iid53hhj0cj5grka1nayvg8n14hn3z0lj2v7a6";
  };

  installPhase = ''
    mkdir -p $out/share/raspberrypi/boot
    cp -R boot/* $out/share/raspberrypi/boot
  '';

  dontFixup = true;

  meta = with stdenv.lib; {
    description = "Firmware for the Raspberry Pi board";
    homepage = "https://github.com/raspberrypi/firmware";
    license = licenses.unfreeRedistributableFirmware; # See https://github.com/raspberrypi/firmware/blob/master/boot/LICENCE.broadcom
    maintainers = with maintainers; [ dezgeg tavyc ];
  };
}
