#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="prboom-plus"
rp_module_desc="Doom/Doom II engine - Enhanced PRBoom Port"
rp_module_licence="https://github.com/coelckers/prboom-plus"
rp_module_section="exp"

function depends_prboom-plus() {
    getDepends libsdl2-dev libsdl2-net-dev libsdl2-image-dev libpcre3-dev libsdl2-mixer-dev libfluidsynth-dev libportmidi-dev libmad0-dev libdumb1-dev libvorbis-dev
}


function sources_prboom-plus() {
    gitPullOrClone "$md_build" https://github.com/coelckers/prboom-plus.git
}

function build_prboom-plus() {
    cd prboom2
    ./bootstrap
    ./configure
    make
    md_ret_require="$md_build/prboom2/src/prboom-plus"

}

function install_prboom-plus() {
    md_ret_files=(
        'prboom2/src/prboom-plus'
        'prboom2/data/prboom-plus.wad'
    )
}

function game_data_prboom-plus() {
    if [[ ! -f "$romdir/ports/doom/doom1.wad" ]]; then
        # download doom 1 shareware
        wget -nv -O "$romdir/ports/doom/doom1.wad" "$__archive_url/doom1.wad"
        chown $user:$user "$romdir/ports/doom/doom1.wad"
    fi
}

function _add_games_prboom-plus() {
    local cmd="$1"
    declare -A games=(
        ['doom1']="Doom"
        ['doom2']="Doom 2"
        ['tnt']="TNT - Evilution"
        ['plutonia']="The Plutonia Experiment"
    )
    local game
    local wad
    for game in "${!games[@]}"; do
        wad="$romdir/ports/doom/$game.wad"
        if [[ -f "$wad" ]]; then
            addPort "$md_id" "doom" "${games[$game]}" "$cmd" "$wad"
        fi
    done
}

function add_games_prboom-plus() {
    _add_games_prboom-plus "pushd $md_inst; $md_inst/prboom-plus -iwad %ROM%; popd"
}

function configure_prboom-plus() {
    setConfigRoot "ports"

    mkRomDir "ports/doom"
    moveConfigDir "$home/.prboom-plus" "$md_conf_root/prboom-plus"

    [[ "$md_mode" == "install" ]] && game_data_prboom-plus

    add_games_prboom-plus

    cp prboom-plus.wad "$romdir/ports/doom/"
    chown $user:$user "$romdir/ports/doom/prboom-plus.wad"
}
