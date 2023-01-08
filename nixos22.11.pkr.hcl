variable "root_password" {
  type    = string
  default = "podaGainahr7"
  sensitive = true
}

source "qemu" "nixos" {
  accelerator      = "kvm"
  boot_command     = [
        "sudo su<enter><wait>",
        "parted /dev/vda -- mklabel msdos<enter><wait>",
        "parted /dev/vda -- mkpart primary 2048MiB 100%<enter><wait>",
        "parted /dev/vda -- mkpart primary linux-swap 512MiB 2048MiB<enter><wait>",
        "mkfs.ext4 -L nixos /dev/vda1<enter><wait>",
        "mkswap -L swap /dev/vda2<enter><wait>",
        "mount /dev/disk/by-label/nixos /mnt<enter><wait>",
        "mkdir -p /mnt/etc/nixos<enter><wait>",
        "nixos-generate-config --root /mnt<enter><wait>",
        "curl http://{{ .HTTPIP }}:{{ .HTTPPort }}/configuration.nix > /mnt/etc/nixos/configuration.nix<enter><wait>",
        "time nixos-install<enter><wait2m>",
        "${var.root_password}<enter>",
        "${var.root_password}<enter>",
        "systemctl start sshd<enter>",
        "passwd root<enter>",
        "${var.root_password}<enter>",
        "${var.root_password}<enter>",
  ]
  boot_wait        = "1m"
  disk_size        = "20480"
  format           = "qcow2"
  headless         = false
  http_directory   = "configuration"
  iso_checksum     = "sha256:28a082514466705bfa3f53f63ff812ee02480edc47bcfaa6c4f08adbb6bf2e6a"
  iso_url          = "https://channels.nixos.org/nixos-22.11/latest-nixos-minimal-x86_64-linux.iso"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
  ssh_password     = "${var.root_password}"
  ssh_timeout      = "8m"
  ssh_username     = "root"
  memory           = 8192
  cpus             = 4
}

build {
  sources = ["source.qemu.nixos"]

  post-processor "compress" {
        output = "nixos_22.11-x86_64.qcow2.gz"
  }
}
