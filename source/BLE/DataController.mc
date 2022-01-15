
using Toybox.BluetoothLowEnergy as Ble;

// implements DataControllerInterface
class DataController extends Ble.BleDelegate {

    private var _device as Ble.Device? = null;
    private var _scanResult = null;
    private var _data as Dictionary = {};
    private var _ready as Bool = false;
    private var _service as Ble.Service or Null = false;

    function initialize(scanResult) {
        self._scanResult = scanResult;
        BleDelegate.initialize();
    }

    function start() as Void {
        self._data[:doseRate] = 1.65f;
        self._device = Ble.pairDevice(self._scanResult);
    }

    function stop() as Void {
        if(self._device != null) {
            Ble.unpairDevice(self._device);
        }
    }

    function get(opt) {
        return self._data[opt];
    }

    function isReady() as Bool {
        return self._ready;
    }

    function startNotifications() {
        System.println("startNotification Begin");
        try {
            var char = self._service.getCharacteristic(RadiaCodeProfile.getNotificationCharacteristics());
            if(char) {
                var cccd = char.getDescriptor(Ble.cccdUuid());
                cccd.requestWrite([0x01, 0x00]b);
            }
        } catch(e) {
            System.println("startNotification ex " + e.getErrorMessage());
        }
        System.println("startNotification End");
    }

    /// BleDelegate implementation
    function onConnectedStateChanged(device, state) as Void {
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
            self.startNotifications();
        }
    }

    function onCharacteristicChanged(chars as Ble.Characteristic, value as Lang.ByteArray) as Void {
        System.println("Notification!");
    }

    function onCharacteristicRead(chars as Ble.Characteristic, status as Ble.Status, value as Lang.ByteArray) as Void {
    }

    function onCharacteristicWrite(chars as Ble.Characteristic, status as Ble.Status) as Void {
    }

    function onDescriptorRead(descriptor as Ble.Descriptor, status as Ble.Status, value as Lang.ByteArray) as Void {
    }

    function onDescriptorWrite(descriptor as BluetoothLowEnergy.Descriptor, status as BluetoothLowEnergy.Status) as Void {
        System.println("Ready = true");
        self._ready = true;
    }
}


