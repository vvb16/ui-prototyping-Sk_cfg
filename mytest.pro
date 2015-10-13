TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    candriver.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    candriver.h


win32: LIBS += -L$$PWD/IXXAT-SDK/lib/ia32/ -lvcisdk

INCLUDEPATH += $$PWD/IXXAT-SDK/inc
DEPENDPATH += $$PWD/IXXAT-SDK/inc

win32:!win32-g++: PRE_TARGETDEPS += $$PWD/IXXAT-SDK/lib/ia32/vcisdk.lib
else:win32-g++: PRE_TARGETDEPS += $$PWD/IXXAT-SDK/lib/ia32/libvcisdk.a
