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
    const o = this;

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

Transport.prototype.disconnect = function() {
    if (this.ws) {
        this.ws.onclose = function() { };
        this.ws.close();
    }
};

Transport.prototype.reconnectAfterDelay = function() {
    const o = this;

    setTimeout(function() {
        o.disconnect();
        o.connect();
    }, 5000);
};

/**
 * Creates a new WebSocket that connects to the server.
 *
 * @returns {WebSocket}
 */
Transport.prototype.createWebSocket = function() {
    return new WebSocket('ws://ws.saso.dev:7692');
};

/**
 * Makes an AJAX request to get a live token.
 *
 * @param onSuccess {function} the function to be called on success of the
 * request
 */
Transport.prototype.retrieveLiveToken = function(onSuccess) {
    const o = this;

    $.ajax({
        method: 'HEAD',
        url: window.location.protocol + '//' + window.location.host
                + '/live/token',
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
