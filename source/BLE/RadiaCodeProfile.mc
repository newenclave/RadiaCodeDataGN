using Toybox.BluetoothLowEnergy as Ble;

class RadiaCodeProfile {

    public static const RADIA_CODE_SERVICE      = Ble.stringToUuid("e63215e5-7003-49d8-96b0-b024798fb901");
    public static const RADIA_CODE_WRITE_CHAR   = Ble.stringToUuid("e63215e6-7003-49d8-96b0-b024798fb901");
    public static const RADIA_CODE_NOTIFY_CHAR  = Ble.stringToUuid("e63215e7-7003-49d8-96b0-b024798fb901");

    private static const _profileDef = {
        :uuid => RADIA_CODE_SERVICE,
        :characteristics => [{
            :uuid => RADIA_CODE_WRITE_CHAR,
            :descriptors => [
                Ble.cccdUuid()
            ]
        }, {
            :uuid => RADIA_CODE_NOTIFY_CHAR,
            :descriptors => [
                Ble.cccdUuid()
            ]
        }]
    };

    public static function getService() {
        return self.RADIA_CODE_SERVICE;
    }

    public static function registerProfile() {
        return Ble.registerProfile(self._profileDef);
    }
}
