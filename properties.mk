# Charger
PRODUCT_PRODUCT_PROPERTIES += \
    ro.charger.disable_init_blank=true \
    ro.charger.enable_suspend=true

# Frp
PRODUCT_PROPERTY_OVERRIDES += \
    ro.frp.pst=/dev/block/bootdevice/by-name/frp

# Perf
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.extension_library=libqti-perfd-client.so

# Radio
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.extension_library=libqti-perfd-client.so \
    persist.vendor.radio.apm_sim_not_pwdn=1 \
    persist.vendor.radio.custom_ecc=1 \
    persist.vendor.radio.sib16_support=1 \
    persist.vendor.radio.rat_on=combine \
    persist.radio.schd.cache=3500 \
    sys.vendor.shutdown.waittime=500 \
    ro.build.shutdown_timeout=0

# Soc
PRODUCT_PROPERTY_OVERRIDES += \
    ro.soc.manufacturer=Qualcomm \
    ro.soc.model=SDM660
