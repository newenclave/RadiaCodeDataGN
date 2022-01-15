using Toybox.BluetoothLowEnergy as Ble;

class ScanController extends Ble.BleDelegate {

    private var _mac as String;

    function initialize(mac as String) {
        BleDelegate.initialize();
        self._mac = mac;
    }

    function onScanResults(scanResults as Ble.Iterator) as Void {
        for(var result = scanResults.next(); result != null; result = scanResults.next()) {
            if(self.contains(result.getServiceUuids(), RadiaCodeProfile.getService())) {
                getApp().connect(result);
            }
        }
    }

    private function contains(iter, obj as Ble.Uuid) as Bool {
        for(var uuid = iter.next(); uuid != null; uuid = iter.next()) {
            if(uuid.equals(obj)) {
                return true;
            }
        }
        return false;
    }
}
