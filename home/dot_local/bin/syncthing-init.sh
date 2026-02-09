#!/bin/sh

# Initialize my Syncthing configuration using the syncthing cli.

set -eu -o noclobber

syncthing cli config defaults folder path set ~/Syncthing

syncthing_add_device() {
    local DEVICE_ID NAME
    DEVICE_ID=$1; shift
    syncthing cli config devices list | grep "${DEVICE_ID}" >/dev/null || syncthing cli config devices add --device-id=${DEVICE_ID}
    
    while [ $# -gt 0 ]; do
        case $1 in
            --name)
                syncthing cli config devices "${DEVICE_ID}" name set "$2"
                shift # past argument
                shift # past value
                ;;
            -*|--*)
                printf '%s%s' 'Unknown option: ' "$1"
                exit 1
                ;;
            *)
                if ! syncthing cli config folders "$1" devices list | grep "${DEVICE_ID}" >/dev/null; then
                    syncthing cli config folders "$1" devices add --device-id "${DEVICE_ID}"
                fi
                shift # past argument
                ;;
        esac
    done
}

# Real devices
syncthing_add_device 5KL655H-72T4SWR-UEB72GE-7NXQQIG-MUONJRI-4FPTS2B-NL3I4YF-ISJV6A2 --name "Peter's Personal Pixel 8"         gaazv-oxhem q4lfc-nktip             
syncthing_add_device 5YB72MX-7SL3DMV-EBWJP3Y-YQIQPOH-OVXMNUY-P43ZGV7-5ECNX3W-HDZOSQU --name "Peter's Work Windows Laptop"      gaazv-oxhem q4lfc-nktip zkq3v-ykoyy 
syncthing_add_device G2XZEO6-FZ3FSHS-C37FOUU-OZ6IS5X-B772RFK-2XHS3MY-M27T25D-B6IGDAF --name "Peter's Work iPhone"              gaazv-oxhem q4lfc-nktip             
syncthing_add_device IHH3RCB-FQ3VVXO-PXHRSB5-7VO6PFW-RTNGVNO-IXKRELT-OKLHBKX-VIF5NAF --name "Peter's Windows Framework Laptop" gaazv-oxhem q4lfc-nktip zkq3v-ykoyy 
syncthing_add_device KLAHQKK-GUUMEL4-IIKIHKM-TTCBB2M-ZHOXCRV-KBTEDLR-JQAOWJA-TFPCSAB --name "Peter's Personal Samsung"         gaazv-oxhem q4lfc-nktip             
# TODO: Personal iPad
# TODO: Personal Bazzite Framework Laptop

# Legacy devices? Check if they really exist.
syncthing_add_device GT5X5FR-UBVSPKA-W73KCMG-62Z5ZI2-54KF6TZ-6XEFSGM-5CPMTH3-G6QNBAC --name "Peter's Personal Laptop"
syncthing_add_device VEKOZY3-CX2EHMK-DXBUP4O-SZUXYJW-IAE32RX-YOMQEYC-7NZ6KDS-CU227QZ --name "Peter's Personal Phone"
