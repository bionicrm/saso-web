//= require_tree .

'use strict';

var transport = new Transport();

transport.connect();

transport.onmessage = function(msg) {
    console.log(msg);

    $('#dashboard').prepend(msg);
};

window.onunload = function() {
    transport.disconnect();
};
