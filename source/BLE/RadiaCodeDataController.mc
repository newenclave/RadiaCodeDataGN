
using Toybox.BluetoothLowEnergy as Ble;

// implements DataControllerInterface
class RadiaCodeDataController extends QueueDelegate {

    private var _device as Ble.Device? = null;
    private var _scanResult = null;
    private var _data as Dictionary = {};
    private var _ready as Bool = false;
    private var _service as Ble.Service or Null = false;

    function initialize(scanResult) {
        self._scanResult = scanResult;
        QueueDelegate.initialize();
    }

    function start() as Void {
        self._data[:doseRate] = 1.65f;
        self._device = Ble.pairDevice(self._scanResult);
        self.startQueue();
    }

    function stop() as Void {
        if(self._device != null) {
            Ble.unpairDevice(self._device);
        }
        self.stopQueue(true);
    }

    function get(opt) {
        return self._data[opt];
    }

    function isReady() as Bool {
        return self._ready;
    }

/// Calls/Callbacks implementation BEGIN
    function startNotificationsCall(params) as Void {
        try {
            var char = self._service.getCharacteristic(RadiaCodeProfile.getNotificationCharacteristics());
            if(char) {
                var cccd = char.getDescriptor(Ble.cccdUuid());
                cccd.requestWrite([0x01, 0x00]b);
            }
        } catch(e) {
            System.println("startNotification ex " + e.getErrorMessage());
        }
    }
    function startNotificationsCallback(params, callbakcParams) as Void {
        System.println("Ready = true");
        self._ready = true;
    }

    function getDataCall(params) as Void {
        var char = self._service.getCharacteristic(RadiaCodeProfile.ATOM_FAST_CHAR2);
        if(char) {
            char.requestRead();
        }
    }
    function getDataCallback(params, callbackData) as Void {
        System.println("getDataCallback " + callbackData.toString());
    }

/// Calls/Callbacks implementation END

    function startProcess() {
        self.getQueue().push(method(:startNotificationsCall), [], method(:startNotificationsCallback), []);
        self.getQueue().push(method(:getDataCall), [], method(:getDataCallback), []);
    }

    /// BleDelegate implementation
    function onConnectedStateChanged(device as Ble.Device, state as Ble.ConnectionState) as Void {
        if(self._device != device) {
            return;
        }
        if(!self._device.isConnected()) {
            System.println("Ready = false");
            self._ready = false;
            return;
        }
        self._service = self._device.getService(RadiaCodeProfile.getService());
        if(self._service) {
            self.startProcess();
        }
    }

    function onCharacteristicChanged(chars as Ble.Characteristic, value as Lang.ByteArray) as Void {
        System.println("Notification!");
    }
}


