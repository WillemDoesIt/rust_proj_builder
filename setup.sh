# Written by Willem Van Zwol last edited 2025.03.18

echo "Setting up nix flake..."
nix flake init

while [ ! -f "flake.nix" ]; do
  clear
  echo "This may take a moment..."
  sleep 1  # Wait for 1 second before checking again
done

clear
echo "Nix flake made."
echo -e "
{
  description = \"Declarations for reproducability\";

  inputs.nixpkgs.url = \"github:NixOS/nixpkgs/nixos-unstable\";
  inputs.flake-utils.url = \"github:numtide/flake-utils\";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        cargoToml = builtins.fromTOML (builtins.readFile ./Cargo.toml);
      in {
        packages.default = pkgs.rustPlatform.buildRustPackage {
          # automatically syncs name and version from cargo.toml
          pname = cargoToml.package.name;
          version = cargoToml.package.version;

          src = ./.;
          cargoLock.lockFile = ./Cargo.lock;
        };


        # dependencies from [nixpkgs](https://search.nixos.org/packages)
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            git eza
            rustc cargo bacon cargo-info irust
          ];
        };

        # code run upon \`nix develop\` being envoked.
        shellHook = ''
          export RUST_BACKTRACE=1
        '';
      }
    );
}" > flake.nix
clear
echo "Flake loaded."

sleep 0.1

clear
echo "Entering developer Environment..."
nix develop --command bash -c "
  clear
  echo \"Entered developer environment.\"

  sleep 0.1

  clear
  echo \"Initializing rust project...\"
  cargo init
  clear
  echo \"Initialized.\"

  sleep 0.1

  clear

  echo \"Directory:\"
  exa
  echo \"\"
  cargo run

  rm setup.sh
  echo -e \"
Deleted setup.sh\"
"
