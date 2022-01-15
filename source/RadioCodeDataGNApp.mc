import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

using Toybox.BluetoothLowEnergy as Ble;

class RadiaCodeDataGNApp extends Application.AppBase {

    private var _scanController = null;
    private var _device = null;
    private var _dataController = null;

    function initialize() {
        AppBase.initialize();
        RadiaCodeProfile.registerProfile();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        self._scanController = new ScanController("");
        Ble.setDelegate(self._scanController);
        Ble.setScanState(Ble.SCAN_STATE_SCANNING);
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        Ble.setScanState(Ble.SCAN_STATE_OFF);
        if(self._device != null) {
            self._dataController.stop();
        }
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new RadiaCodeDataGNView() ] as Array<Views or InputDelegates>;
    }

    function connect(scanResult as Toybox.BluetoothLowEnergy.ScanResult) as Void {
        self._dataController = new DataController(scanResult);
        Ble.setDelegate(self._dataController);
        Ble.setScanState(Ble.SCAN_STATE_OFF);
        self._dataController.start();
    }
}

function getApp() as RadioCodeDataGNApp {
    return Application.getApp() as RadiaCodeDataGNApp;
}