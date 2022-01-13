
using Toybox.BluetoothLowEnergy as Ble;

class ScanController extends Ble.BleDelegate {
    function initialize(mac) {
        BleDelegate.initialize();
    }
}
