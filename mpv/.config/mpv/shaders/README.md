# Prescalers for mpv, as user shaders

[bjin/mpv-prescalers](https://github.com/bjin/mpv-prescalers) - contains
scripts that generate user shaders for prescaling in mpv(1).

## How to generate

1. `git clone https://github.com/bjin/mpv-prescalers.git`
-  `cd mpv-prescalers`
-  `./superxbr.py --target=all --sharpness=1.3 > ~/.config/mpv/shaders/superxbr--all--1.3-sharpness.hook`

## Usage

Add `opengl-shaders` option to `mpv.conf`:

```text
opengl-shaders="~~/shaders/superxbr--all--1.3-sharpness.hook"
```

All shaders are one pass only (`2x` upscaling). For `4x` upscaling, trigger
the same shader twice:

```text
opengl-shaders="~~/shaders/superxbr--all--1.3-sharpness.hook,~~/shaders/superxbr--all--1.3-sharpness.hook"
```

See the [bjin/mpv-prescalers](https://github.com/bjin/mpv-prescalers)
repository for more info.
