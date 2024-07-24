# Nix Tutorial

* Store
* Flakes
* Composition
* `nix repl` - Open a repl to the Nix Language
* `<nixos/pkgs>`

## Nix Profile (User Environment)

The nix profile is the mechanism by which nix-os users add applications binaries to their ENV path. A users ENV is added to the store. Each change to the ENV gets a new store entry and a new sym link to that entry in the path shown below. The ENV store entry has a bin dir that itself contains symlinks to the path of the binary in the store.

```
/home/user/.local/state/nix/profiles
    - profile -> profile3
    - profile 1 -> /nix/store/<hash_1>-user
    - profile 2 -> /nix/store/<hash_2>-user
    - profile 3 -> /nix/store/<hash_3>-user
        - /nix/store/<hash_3>-user/bin
            - app_A -> /nix/store/<hash_A>-A/bin/a.sh
            - app_B -> /nix/store/<hash_B>-B/bin/b.sh
```

### Commands

| Command | Desc |
| --- | --- |
| `nix-env -f <pkgs_list> -i <p>` | Search `pkgs_list`, which should return an attribute set of drv's, and install `p`. Add link in users Nix Profile to `p`. |
| `nix-env -q` | Query users installed packages. |
| `nix-env -f <pkgs_list> -qa` | List all possible packages to install from passed `pkgs_list`. |
| `nix-env -I <pkgs_list>` | Set default `pkgs_list` to the passed `pkgs_list`. `-f` can now be omitted. |
| `nix-env --delete-generations old` | Delete all the old user profiles except current. |
| `nix-env -e <p>` | Remove Package `p` from user environment. |  

### Questions

* Does this support a mechanism for maintaining things like my .bashrc and other user ENV configs?

## Garbage Collection

`nix-store --gc`

## Derivations

Derivation is an intermediate artifact that describes all the relevant components in building a package. 

* `nix-instantiate a.nix`
* Can install `nix-derivation` to provide binary `pretty-derivation` that takes a `.drv` as an input and outputs a pretty print of it.
* `nix-store -qR <path to pkg in store>` - Gives the "runtime closure" or the packages needed to run the application binary.
* `nix-store -qR <path to pkg drv in store>` - Gives the "build time closure" or the packages needed to build the application binary.

## Channel

URL that points to nix exprs?

# References

* [VM Tutorial](https://alberand.com/nixos-linux-kernel-vm.html)
* [Nix Dev](https://nix.dev/)
* [PhD Thesis](https://edolstra.github.io/pubs/phd-thesis.pdf)
* [Starting Rpi Zero 2 conf](https://github.com/plmercereau/nixos-pi-zero-2)
