#!/usr/bin/env bash
##############

rp_module_id="update-retropexpanded"
rp_module_desc="Easily update RetroPie-Expanded"
rp_module_help="Follow the instructions on the dialogs"
rp_module_section="exp"

function sources_update-retropexpanded() {
    wget https://raw.githubusercontent.com/RetroPie-Expanded/RetroPie-Expanded/master/update-retropieexpanded.sh
}

function install_update-retropexpanded() {

    cp ./update-retropexpanded.sh "$home/RetroPie/retropiemenu"
    chown -R $user:$user "$datadir/retropiemenu"
}

function remove_update-retropexpanded() {
    rm -rfv "$datadir/retropiemenu/update-retropieexpanded.sh"
}

function gui_update-retropexpanded() {
    bash "$md_inst/update-retropieexpanded.sh"
}
