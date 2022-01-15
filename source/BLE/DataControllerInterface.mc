import Toybox.Lang;

typedef DataControllerInterface as interface {
    function start();
    function stop();
    function get(opt);
    function isReady() as Bool;
};

