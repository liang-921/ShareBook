QT += quick
CONFIG += console c++17

HEADERS += \
    base64.h \
    client.h \
    network.h \
    imageprovider.h \
    personaluicontrol.h \
    publishpagecontrol.h \
    pushpagecontrol.h \
    roundimage.h

SOURCES += \
        base64.cpp \
        main.cpp \
        client.cpp \
        network.cpp \
        imageprovider.cpp \
        personaluicontrol.cpp \
        publishpagecontrol.cpp \
        pushpagecontrol.cpp \
        roundimage.cpp

resources.files = main.qml Toast.qml
resources.prefix = /$${TARGET}
RESOURCES += resources \
    res.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android_sources

DISTFILES += \
    PushPage.qml \
#    Toast.qml \
    Toast.qml \
    android_sources/AndroidManifest.xml

