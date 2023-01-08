# Packer NixOS Build

An example on how to build NixOS VM images by leveraging Packer.

## Usage

1. To build the image make sure you have QEMU Packer builder configured.

    * https://developer.hashicorp.com/packer/plugins/builders/qemu

2. Customize `configuration/configuration.nix` as you please.

3. Run `packer build nixos22.11.pkr.hcl` the build KVM image.

> You can set the root password through a variable, like this `packer build
> -var 'root_password=qwertz1234' nixos22.11.pkr.hcl`.

## License

[MIT](https://choosealicense.com/licenses/mit/)
