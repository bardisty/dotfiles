# Prescalers for mpv, as user shaders

[bjin/mpv-prescalers](https://github.com/bjin/mpv-prescalers) - contains
scripts that generate user shaders for prescaling in mpv(1).

## How to generate

1. `git clone https://github.com/bjin/mpv-prescalers.git ~/src/gh`
-  `cd ~/src/gh`
-  `./superxbr.py --target=all --sharpness=1.3 > ~/.config/mpv/shaders/superxbr--all--1.3-sharpness.hook`

## Usage

Add `user-shaders=""` sub-option to `vo` settings:

```text
vo=opengl-hg:...:user-shaders="~~/shaders/superxbr--all--1.3-sharpness.hook"
```

All shaders are one pass only (`2x` upscaling). For `4x` upscaling, trigger
the same shader twice:

```text
vo=opengl-hg:...:user-shaders="~~/shaders/superxbr--all--1.3-sharpness.hook,~~/shaders/superxbr--all--1.3-sharpness.hook"
```

See the `mpv-prescalers` repository for more info.
