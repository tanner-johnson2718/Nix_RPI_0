{ stdenv, lib } :
let
    fs = lib.fileset;
    sourceFiles = ./a.nix;
in
stdenv.mkDerivation {
    name = "a";
    pname = "a";
    version = "1.0";
    src = fs.toSource {
        root = ./.;
        fileset = sourceFiles;
    };

    buildPhase = ''
        echo "a building ... " 
        touch a.out
    '';

    installPhase = ''
        echo "a installing ... " 
        mkdir -p $out/bin
        cp a.out $out/bin
    '';
}