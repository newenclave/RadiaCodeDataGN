import Toybox.Activity;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;

class RadiaCodeDataGNView extends WatchUi.SimpleDataField {

    // Set the label of the data field here.
    function initialize() {
        SimpleDataField.initialize();
        label = "";
    }

    function compute(info as Activity.Info) as Numeric or Duration or String or Null {
        var curret = getApp().getCurrentDevice();
        if(curret != null) {
            return getApp().getCurrentDevice().get(:doseRate);
        }
        return -0.1f;
    }
}

