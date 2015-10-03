'use strict';

var Transport = function() {};

/**
 * Connects to the server to receive live updates.
 */
Transport.prototype.connect = function() {
    var o = this;

    this.createWebSocket();

    this.retrieveLiveToken(function(jqXHR, textStatus) {
        console.log(jsonStr(jqXHR));
        console.log(jsonStr(textStatus));

        o.ws.onopen = function(e) {
            // TODO: do something here
            o.ws.send("Test 123")
        };

        o.ws.onmessage = function(e) {
            // TODO: do something here
            console.log(jsonStr(e.data));
        };

        o.ws.onclose = function(e) {
            console.log(jsonStr(e));
            // reconnect if connection is closed
            o.connect();
        };

        o.ws.onerror = function(e) {
            console.log(jsonStr(e));
        };
    });
};

/**
 * Gets and sets a new WebSocket that connects to the server.
 *
 * @returns {WebSocket}
 */
Transport.prototype.createWebSocket = function() {
    // TODO: correct address
    return this.ws = new WebSocket('wss://echo.websocket.org');
};

/**
 * Makes an AJAX request to get a live token.
 *
 * @param oncomplete the function to be called on completion of the request
 */
Transport.prototype.retrieveLiveToken = function(oncomplete) {
    // TODO: maybe need onsuccess instead and do error handling
    $.ajax({
        method: 'HEAD',
        url: window.location.protocol + '//' + window.location.host + '/live/token',
        cache: false,
        complete: oncomplete
    });
};
