
function getWebsocketUri(endpoint) {
    var socket_base = "";

    if (window.location.protocol == 'https:') {
       socket_base = "wss";
    } else {
       socket_base = "ws";
    }

    return `${socket_base}://${window.location.host}${window.location.pathname.substring(0, window.location.pathname.lastIndexOf('/'))}/${endpoint}`;
}

function getHttpUri(endpoint) {
    return `${window.location.pathname.substring(0, window.location.pathname.lastIndexOf('/'))}/${endpoint}`;
}
