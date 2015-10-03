//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function jsonStr(o) {
    return JSON.stringify(o);
}

new Transport().connect();
