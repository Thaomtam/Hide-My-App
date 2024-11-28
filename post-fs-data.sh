#!/system/bin/sh

# Tạo thư mục cấu hình nếu chưa tồn tại
CONFIG_DIR="/data/adb/zygisk-prop-app/config"
if [ ! -d "$CONFIG_DIR/props" ]; then
    mkdir -p "$CONFIG_DIR/props"
    # Tạo file map ứng dụng và prop
    echo -e "com.example.app1=app1.prop\ncom.example.app2=app2.prop" > "$CONFIG_DIR/app_package_map.txt"

    # Tạo file prop giả mặc định
    echo -e "MANUFACTURER=FakeManufacturer\nBRAND=FakeBrand\nMODEL=FakeModel\nDEVICE=FakeDevice\nBOARD=FakeBoard\nHARDWARE=FakeHardware\nBOOTLOADER=FakeBootloader\nFINGERPRINT=Fake/FakeBrand/FakeDevice:10/QKQ1.190716.003:user/release-keys" > "$CONFIG_DIR/props/default.prop"

    # Tạo thêm các file prop cho ứng dụng cụ thể
    echo -e "MANUFACTURER=App1Manufacturer\nBRAND=App1Brand\nMODEL=App1Model\nDEVICE=App1Device\nBOARD=App1Board\nHARDWARE=App1Hardware\nBOOTLOADER=App1Bootloader\nFINGERPRINT=App1/FakeBrand/App1Device:10/QKQ1.190716.003:user/release-keys" > "$CONFIG_DIR/props/app1.prop"
    echo -e "MANUFACTURER=App2Manufacturer\nBRAND=App2Brand\nMODEL=App2Model\nDEVICE=App2Device\nBOARD=App2Board\nHARDWARE=App2Hardware\nBOOTLOADER=App2Bootloader\nFINGERPRINT=App2/FakeBrand/App2Device:10/QKQ1.190716.003:user/release-keys" > "$CONFIG_DIR/props/app2.prop"
fi
