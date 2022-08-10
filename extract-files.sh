#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
# Copyright (C) 2018 The MoKee Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

SRC=$1
SRC_QC=$2

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

if [ -z "${ONLY_TARGET}" ] && [ -z "${ONLY_DEVICE_COMMON}" ]; then
    # Initialize the helper for common device
    setup_vendor "${DEVICE_COMMON}" "${VENDOR}" "${ANDROID_ROOT}" true "${CLEAN_VENDOR}"

    extract "${MY_DIR}/proprietary-files.txt" "${SRC}" ${KANG} --section "${SECTION}"
fi

if [ -z "${ONLY_COMMON}" ] && [ -z "${ONLY_TARGET}" ] && [ -s "${MY_DIR}/../${DEVICE_SPECIFIED_COMMON}/proprietary-files.txt" ];then
    # Reinitialize the helper for device
    source "${MY_DIR}/../${DEVICE}/extract-files.sh"
    setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

    extract "${MY_DIR}/../${DEVICE}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"
fi

"${MY_DIR}/setup-makefiles.sh"

BLOB_ROOT="${ANDROID_ROOT}"/vendor/"${VENDOR}"/"{$DEVICE_COMMON}"/proprietary

# Audio
sed -i 's|/system/etc/|/vendor/etc/|g' ${BLOB_ROOT}/vendor/lib/libacdbloader.so
sed -i 's|/system/etc/|/vendor/etc/|g' ${BLOB_ROOT}/vendor/lib64/libacdbloader.so

# Camera
sed -i 's|/system/etc/|/vendor/etc/|g' ${BLOB_ROOT}/vendor/lib/libmmcamera2_sensor_modules.so
sed -i 's|/system/etc/|/vendor/etc/|g' ${BLOB_ROOT}/vendor/lib/libmms_hal_vstab.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' ${BLOB_ROOT}/vendor/bin/mm-qcamera-daemon
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' ${BLOB_ROOT}/vendor/lib/libmmcamera2_cpp_module.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' ${BLOB_ROOT}/vendor/lib/libmmcamera2_iface_modules.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' ${BLOB_ROOT}/vendor/lib/libmmcamera2_imglib_modules.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' ${BLOB_ROOT}/vendor/lib/libmmcamera2_mct.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' ${BLOB_ROOT}/vendor/lib/libmmcamera2_pproc_modules.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' ${BLOB_ROOT}/vendor/lib/libmmcamera2_q3a_core.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' ${BLOB_ROOT}/vendor/lib/libmmcamera2_sensor_modules.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' ${BLOB_ROOT}/vendor/lib/libmmcamera2_stats_algorithm.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' ${BLOB_ROOT}/vendor/lib/libmmcamera2_stats_modules.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' ${BLOB_ROOT}/vendor/lib/libmmcamera_bokeh.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' ${BLOB_ROOT}/vendor/lib/libmmcamera_dbg.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' ${BLOB_ROOT}/vendor/lib/libmmcamera_hvx_grid_sum.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' ${BLOB_ROOT}/vendor/lib/libmmcamera_imglib.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' ${BLOB_ROOT}/vendor/lib/libmmcamera_interface.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' ${BLOB_ROOT}/vendor/lib/libmmcamera_isp_mesh_rolloff44.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' ${BLOB_ROOT}/vendor/lib/libmmcamera_pdaf.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' ${BLOB_ROOT}/vendor/lib/libmmcamera_pdafcamif.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' ${BLOB_ROOT}/vendor/lib/libmmcamera_s5k3p8sp_fm24c64d_eeprom.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' ${BLOB_ROOT}/vendor/lib/libmmcamera_tintless_algo.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' ${BLOB_ROOT}/vendor/lib/libmmcamera_tintless_bg_pca_algo.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' ${BLOB_ROOT}/vendor/lib/libmmcamera_tuning.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' ${BLOB_ROOT}/vendor/lib/libmms_hal_vstab.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' ${BLOB_ROOT}/vendor/lib/libsmart_hdr.so

# Fingerprint - FPC
sed -i 's|\x00fpcfingerprint\x00|\x00fingerprint\x00\x00\x00\x00|' ${BLOB_ROOT}/vendor/lib64/hw/fingerprint.fpc.so
