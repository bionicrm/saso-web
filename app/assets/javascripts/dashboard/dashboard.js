//= require_tree .

'use strict';

var transport = new Transport();

transport.connect();

transport.onmessage = function(msg) {
    $('#dashboard').prepend(msg);
};
