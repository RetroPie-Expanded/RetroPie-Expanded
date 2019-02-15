#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-daphne-tinker"
rp_module_desc="Laserdisc emu - Daphne port for libretro"
rp_module_help="ROM Extension: .daphne\n\nCopy your Daphne roms to $romdir/daphne"
rp_module_section="exp"
rp_module_flags="!rpi"

function sources_lr-daphne-tinker() {
    gitPullOrClone "$md_build" https://github.com/RetroPie-Expanded/daphne.git
}

function build_lr-daphne-tinker() {
    make clean
    make platform=pi -j4
    md_ret_require="$md_build/daphne_libretro.so"
}

function install_lr-daphne-tinker() {
    md_ret_files=(
        'daphne_libretro.so'
    )
}

function configure_lr-daphne-tinker() {
    mkRomDir "daphne"
    ensureSystemretroconfig "daphne"

    addEmulator 1 "$md_id" "daphne" "$md_inst/daphne_libretro.so"
    addSystem "daphne"

}
