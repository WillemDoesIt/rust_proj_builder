# rust_proj_builder
Just a simple bash script to help you setup rust projects with a declarative flake.

## How to use

Download the setup.sh file and put it in the directory where you want to create your project.
Then navigate (with `cd`) to the same directory in your terminal and execute the following:
```bash
chmod +x setup.sh
./setup.sh
```
Please report issues if you have any.

**⚠️ WARNING ⚠️**
> This assumes Nix or Nixos is installed, If not this should work to install: `sh <(curl -L https://nixos.org/nix/install) --daemon`
> You *cannot run the following on windows* in it's current state.
> It is theoretically possible via WSL2 or installing all dependencies manually and running `cargo run`
> But I do not provide any tutorial here on how to do that, and make no promises that it will work cross platform
