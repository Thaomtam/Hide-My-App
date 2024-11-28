#include <jni.h>
#include <string>
#include <android/log.h>
#include <fcntl.h>
#include <unistd.h>
#include <map>
#include <fstream>
#include <sstream>

#define LOG_TAG "ZygiskPropApp"
#define LOGI(...) __android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__)
#define CONFIG_PATH "/data/adb/zygisk-prop-app/config"

std::map<std::string, std::string> loadProps(const std::string &filePath) {
    std::map<std::string, std::string> props;
    std::ifstream file(filePath);
    if (!file.is_open()) return props;

    std::string line;
    while (std::getline(file, line)) {
        size_t pos = line.find('=');
        if (pos != std::string::npos) {
            std::string key = line.substr(0, pos);
            std::string value = line.substr(pos + 1);
            props[key] = value;
        }
    }
    file.close();
    return props;
}

void fakeProps(JNIEnv *env, const char *packageName) {
    // Load app-package map
    std::map<std::string, std::string> appMap = loadProps(std::string(CONFIG_PATH) + "/app_package_map.txt");

    // Find matching prop file
    std::string propFile = appMap[packageName];
    if (propFile.empty()) {
        propFile = "default.prop";
    }

    // Load props from file
    std::map<std::string, std::string> props = loadProps(std::string(CONFIG_PATH) + "/props/" + propFile);

    // Apply props
    for (const auto &entry : props) {
        LOGI("Setting prop: %s = %s", entry.first.c_str(), entry.second.c_str());
        setenv(entry.first.c_str(), entry.second.c_str(), 1);
    }
}

extern "C" void zygisk_module(JNIEnv *env, const char *packageName) {
    fakeProps(env, packageName);
}

extern "C" void zygisk_load(JNIEnv *env, int apiLevel, const char **whitelist, int whitelistSize) {
    LOGI("Zygisk Prop App loaded!");
}
