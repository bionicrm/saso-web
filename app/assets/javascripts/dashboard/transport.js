'use strict';

/**
 * Creates a new Transport.
 *
 * @constructor
 */
var Transport = function() {};

/**
 * Connects to the server to receive live updates.
 */
Transport.prototype.connect = function() {
    var o = this;

    this.ws = this.createWebSocket();

    this.retrieveLiveToken(function(jqXHR, textStatus) {
        /**
         * @param e {Event}
         */
        o.ws.onopen = function(e) {
            // TODO: do something here
            setInterval(function() {
                o.ws.send(new Date().getTime().toString())
            }, 1);
        };

        /**
         * @param e {MessageEvent}
         */
        o.ws.onmessage = function(e) {
            // TODO: do something here
            console.log(e.data);
        };

        /**
         * @param e {Event}
         */
        o.ws.onclose = function(e) {
            // reconnect if connection is closed
            o.connect();
        };

        /**
         * @param e {Event}
         */
        o.ws.onerror = function(e) {
            alert(e);
        };
    });
};

/**
 * Creates a new WebSocket that connects to the server.
 *
 * @returns {WebSocket}
 */
Transport.prototype.createWebSocket = function() {
    // TODO: correct address
    return new WebSocket('ws://echo.websocket.org');
};

/**
 * Makes an AJAX request to get a live token.
 *
 * @param oncomplete {function} the function to be called on completion of the request
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
