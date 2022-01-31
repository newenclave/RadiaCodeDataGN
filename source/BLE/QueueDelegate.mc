using Toybox.BluetoothLowEnergy as Ble;
using Toybox.Application as App;

class QueueDelegate extends Ble.BleDelegate {

    private var _operationQueue as OperationsQueue;

    function initialize() {
        BleDelegate.initialize();
        self._operationQueue = new OperationsQueue();
    }

    function getQueue() {
        return self._operationQueue;
    }

    function startQueue() {
        self._operationQueue.start();
    }

    function stopQueue(reset as Bool) {
        self._operationQueue.stop(reset);
    }

    function onCharacteristicRead(characteristic as Ble.Characteristic, status as Ble.Status, value as Lang.ByteArray) as Void {
        System.println("onCharacteristicRead. Status " + status.toString());
        self._operationQueue.callbackTop([characteristic, status, value]);
        self._operationQueue.popAndCall();
    }

    function onCharacteristicWrite(characteristic as Ble.Characteristic, status as Ble.Status) as Void {
        System.println("onCharacteristicWrite. Status " + status.toString());
        self._operationQueue.callbackTop([characteristic, status]);
        self._operationQueue.popAndCall();
    }

    function onDescriptorRead(descriptor as Ble.Descriptor, status as Ble.Status, value as Lang.ByteArray) as Void {
        System.println("onDescriptorRead. Status " + status.toString());
        self._operationQueue.callbackTop([descriptor, status, value]);
        self._operationQueue.popAndCall();
    }

    function onDescriptorWrite(descriptor as Ble.Descriptor, status as BluetoothLowEnergy.Status) as Void {
        System.println("onDescriptorWrite. Status " + status.toString());
        self._operationQueue.callbackTop([descriptor, status]);
        self._operationQueue.popAndCall();
    }

// Not implemented here.
/*
    function onCharacteristicChanged(characteristic, value) {
    }

    function onConnectedStateChanged(device, state) {
    }

    function onProfileRegister(uuid, status) {
    }

    function onScanResults(scanResults) {
    }

    function onScanStateChange(scanState, status) {
    }
*/

}
