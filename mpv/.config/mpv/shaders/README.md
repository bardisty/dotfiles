# Prescalers for mpv, as user shaders

[bjin/mpv-prescalers](https://github.com/bjin/mpv-prescalers) - contains
scripts that generate user shaders for prescaling in mpv(1).

## How to generate

1. `git clone https://github.com/bjin/mpv-prescalers.git`
-  `cd mpv-prescalers`
-  `./superxbr.py --target=rgb --sharpness=1.3 > ~/.config/mpv/shaders/super-xbr--rgb--1.3-sharpness.hook`

## Usage

Add `glsl-shaders` option to `mpv.conf`:

```text
glsl-shaders="~~/shaders/super-xbr--rgb--1.3-sharpness.hook"
```

All shaders are one pass only (`2x` upscaling). For `4x` upscaling, trigger
the same shader twice:

```text
glsl-shaders-append="~~/shaders/superxbr--rgb--1.3-sharpness.hook"
glsl-shaders-append="~~/shaders/superxbr--rgb--1.3-sharpness.hook"
```

See the [bjin/mpv-prescalers](https://github.com/bjin/mpv-prescalers)
repository for more info.
