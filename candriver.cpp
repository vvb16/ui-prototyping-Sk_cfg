#include "candriver.h"
#include "vcinpl.h"
#include <memory>

CANDriver::CANDriver(QObject *parent) : QObject(parent)
{
}

typedef std::unique_ptr<HANDLE, decltype(&vciEnumDeviceClose)> vciEnum_ptr;
typedef std::unique_ptr<HANDLE, decltype(&vciDeviceClose)> vciDevice_ptr;

int CANDriver::initialize()
{
    CHAR errorBuffer[VCI_MAX_ERRSTRLEN];
    HRESULT vciResult;

    if ( (vciResult = vciInitialize()) != VCI_OK )
    {
        vciFormatError(vciResult, &errorBuffer[0], sizeof(errorBuffer));
        emit errorOccured(errorBuffer);
        return 1;
    }

    HANDLE hEnum;
    if ( (vciResult = vciEnumDeviceOpen(&hEnum)) != VCI_OK )
    {
        vciFormatError(vciResult, &errorBuffer[0], sizeof(errorBuffer));
        emit errorOccured(errorBuffer);
        return 1;
    }
    vciEnum_ptr phEnum(&hEnum, vciEnumDeviceClose);

    VCIDEVICEINFO deviceInfo;
    if ( (vciResult = vciEnumDeviceNext(hEnum, &deviceInfo)) != VCI_OK )
    {
        vciFormatError(vciResult, &errorBuffer[0], sizeof(errorBuffer));
        emit errorOccured(errorBuffer);
        return 1;
    }

    HANDLE hDevice;
    if ( (vciResult = vciDeviceOpen(deviceInfo.VciObjectId, &hDevice)) != VCI_OK )
    {
        vciFormatError(vciResult, &errorBuffer[0], sizeof(errorBuffer));
        emit errorOccured(errorBuffer);
        return 1;
    }
    vciDevice_ptr phDevice(&hDevice, vciDeviceClose);

    return 0;
}
