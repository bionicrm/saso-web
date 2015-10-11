'use strict';

/**
 * Creates a new Transport.
 *
 * @constructor
 */
var Transport = function() {};

/**
 * Connects to the server to receive live updates. Disconnects and reconnects if
 * currently connected.
 */
Transport.prototype.connect = function() {
    var o = this;

    this.retrieveLiveToken(
        /**
         * @param data
         * @param textStatus {String}
         * @param jqXHR {XMLHttpRequest}
         */
        function(data, textStatus, jqXHR) {
            o.ws = o.createWebSocket();

            /**
             * @param e {Event}
             */
            o.ws.onopen = function(e) {
                // TODO
            };

            /**
             * @param e {MessageEvent}
             */
            o.ws.onmessage = function(e) {
                o.handleMessage(e.data.toString());
            };

            /**
             * Reconnects when the connection closes.
             *
             * @param e {Event}
             */
            o.ws.onclose = function(e) {
                o.reconnectAfterDelay();
            };

            /**
             * @param e {Event}
             */
            o.ws.onerror = function(e) { /* empty */ };
        }
    );
};

Transport.prototype.reconnectAfterDelay = function() {
    var o = this;

    setTimeout(function() {
        if (o.ws) o.ws.close();

        o.connect();
    }, 5000);
};

/**
 * Creates a new WebSocket that connects to the server.
 *
 * @returns {WebSocket}
 */
Transport.prototype.createWebSocket = function() {
    const url = 'ws://ws.saso.dev:7692';

    return new WebSocket(url);
};

/**
 * Makes an AJAX request to get a live token.
 *
 * @param onSuccess {function} the function to be called on success of the
 * request
 */
Transport.prototype.retrieveLiveToken = function(onSuccess) {
    var o = this;

    const path = '/live/token';

    $.ajax({
        method: 'HEAD',
        url: window.location.protocol + '//' + window.location.host + path,
        cache: false,
        success: onSuccess,

        /**
         * @param jqXHR {XMLHttpRequest}
         * @param textStatus {String}
         * @param errorThrown {String}
         */
        error: function(jqXHR, textStatus, errorThrown) {
            if (jqXHR.status === Protocol.TOO_MANY_CONCURRENT_CONNECTIONS) {
                // TODO: remove and handle errors
                alert('Too many concurrent requests!');
            }

            o.reconnectAfterDelay();
        }
    });
};

/**
 * Handles a WebSocket message.
 *
 * @param msg {String} the message received from the WebSocket
 */
Transport.prototype.handleMessage = function(msg) {
    if (this.onmessage) {
        this.onmessage(msg);
    }
};
