
using Toybox.BluetoothLowEnergy as Ble;

class DataController extends Ble.BleDelegate {

    private var _device = null;
    private var _scanResult = null;

    function initialize(scanResult) {
        self._scanResult = scanResult;
        BleDelegate.initialize();
    }

    function start() as Void {
        self._device = Ble.pairDevice(self._scanResult);
    }

    function stop() as Void {

    }
}
