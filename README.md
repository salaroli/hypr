# hypr

Personal [Hyprland](https://hyprland.org/) configuration.

## Structure

```
hypr/
├── hyprland.conf              # entry point — variables and source includes
└── conf/
    ├── monitors.conf          # sources monitors.local.conf (gitignored)
    ├── monitors.local.conf    # ← you create this per machine (see example)
    ├── monitors.local.conf.example
    ├── env.conf
    ├── autostart.conf
    ├── look-and-feel.conf
    ├── input.conf
    ├── keybinds.conf
    └── windowrules.conf
```

## Setup

```bash
git clone https://github.com/salaroli/hypr ~/.config/hypr
cp ~/.config/hypr/conf/monitors.local.conf.example \
   ~/.config/hypr/conf/monitors.local.conf
# edit monitors.local.conf for your display(s)
```

## Multi-machine monitor config

`conf/monitors.local.conf` is gitignored intentionally — each machine has its
own display setup. The example file (`monitors.local.conf.example`) documents
the format and includes a starting point.

## Dependencies

### Arch Linux

```bash
# Compositor
pacman -S hyprland

# Status bar
pacman -S waybar

# Terminal
pacman -S alacritty

# File manager
pacman -S dolphin

# App launcher
pacman -S rofi-wayland

# Screenshots (grimblast is part of hyprland-contrib, available on AUR)
yay -S hyprland-contrib   # provides grimblast

# Wallpaper daemon (awww-daemon)
yay -S swww

# Audio control
pacman -S wireplumber      # provides wpctl

# Brightness control
pacman -S brightnessctl

# Media control
pacman -S playerctl

# Nvidia (if applicable)
pacman -S nvidia nvidia-utils
```

### Fedora

```bash
# Compositor
dnf install hyprland

# Status bar
dnf install waybar

# Terminal
dnf install alacritty

# File manager
dnf install dolphin

# App launcher
dnf install rofi-wayland

# Screenshots
dnf copr enable solopasha/hyprland
dnf install grimblast

# Wallpaper daemon
dnf copr enable solopasha/hyprland
dnf install swww

# Audio control
dnf install wireplumber

# Brightness control
dnf install brightnessctl

# Media control
dnf install playerctl
```

### Ubuntu / Debian

Hyprland is not in the official repos for Ubuntu/Debian. Use the community
PPA or build from source.

```bash
# Hyprland (PPA)
add-apt-repository ppa:hyprland/staging
apt update && apt install hyprland

# Other dependencies
apt install waybar alacritty dolphin rofi wireplumber brightnessctl playerctl

# grimblast and swww — build from source or use a third-party package
# See: https://github.com/hyprwm/hyprland-contrib
#      https://github.com/LGFae/swww
```

## Keybinds summary

| Shortcut | Action |
|---|---|
| `Super + T` | Terminal (alacritty) |
| `Super + Space` | App launcher (rofi) |
| `Super + E` | File manager (dolphin) |
| `Super + Q` | Close active window |
| `Super + V` | Toggle floating |
| `Super + P` | Toggle pseudotile |
| `Super + M` | Exit Hyprland |
| `Super + H/J/K/L` | Move focus |
| `Super + Shift + H/J/K/L` | Swap windows |
| `Super + Ctrl + H/J/K/L` | Resize windows |
| `Super + 1–0` | Switch workspace |
| `Super + Shift + 1–0` | Move window to workspace |
| `Super + Shift + S` | Screenshot — region (clipboard) |
| `Super + Print` | Screenshot — full screen (clipboard) |
| `Super + Shift + Print` | Screenshot — active window (clipboard) |
