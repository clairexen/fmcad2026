#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"

if command -v magick >/dev/null 2>&1; then
    image_magick=(magick)
elif command -v convert >/dev/null 2>&1; then
    image_magick=(convert)
else
    printf '%s\n' 'Error: ImageMagick is required.' >&2
    exit 1
fi

sources=(
    "$script_dir/SAG-Type-I-BMCF-BMIC.svg"
    "$script_dir/SAG-Type-II-BMGF-BMSF.svg"
    "$script_dir/SAG-Type-III-BMEXT-BMDEP.svg"
)

for source in "${sources[@]}"; do
    if [[ ! -r "$source" ]]; then
        printf 'Error: cannot read %s\n' "$source" >&2
        exit 1
    fi
done

render_dir="$(mktemp -d "${TMPDIR:-/tmp}/all-sag-types.XXXXXXXX")"
cleanup() {
    rm -rf -- "$render_dir"
}
trap cleanup EXIT HUP INT TERM

renders=()
for index in "${!sources[@]}"; do
    render="$render_dir/panel-$index.png"
    "${image_magick[@]}" \
        -density 192 \
        -background white \
        "${sources[$index]}" \
        -alpha remove \
        -alpha off \
        -colorspace sRGB \
        "$render"
    renders+=("$render")
done

landscape="$render_dir/All-SAG-Types-Landscape.png"
portrait="$render_dir/All-SAG-Types-Portrait.png"

"${image_magick[@]}" -background white -gravity center "${renders[@]}" +append "$landscape"
"${image_magick[@]}" -background white -gravity center "${renders[@]}" -append "$portrait"

mv -f -- "$landscape" "$script_dir/All-SAG-Types-Landscape.png"
mv -f -- "$portrait" "$script_dir/All-SAG-Types-Portrait.png"

printf '%s\n' \
    "Created $script_dir/All-SAG-Types-Landscape.png" \
    "Created $script_dir/All-SAG-Types-Portrait.png"
