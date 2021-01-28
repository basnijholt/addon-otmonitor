var output = document.getElementById("debug");
var connect = document.getElementById("connect");
var override = document.getElementById("override").value;

function debug(str) {
    if (output) output.innerHTML += str + "<BR>";
}

var wsurl = "ws" + document.URL.match("s?://[-a-zA-Z0-9.:_/]+/") + "basic.ws"

if ("WebSocket" in window) {
   var websocket = new WebSocket(wsurl);
} else if ("MozWebSocket" in window) {
   var websocket = new MozWebSocket(wsurl);
}

websocket.onopen = function () {
  $("#connection").html("CONNECTED");
  $("#connection").css("background-color","#5cb85c");
};

websocket.onclose = function (evt) {
  $("#connection").html("DISCONNECTED");
  $("#connection").css("background-color","#d9534f");
};

websocket.onmessage = function(evt) {onMessage(evt)}

function onMessage(evt) {
    var message = JSON.parse(evt.data)

    for (var name in message) {
        var elem = document.getElementById(name)
        switch (elem.nodeName) {
          case "IMG":
            if (message[name] != 0) {
              elem.src = "../images/" + name + "-on.png"
            } else {
              elem.src = "../images/" + name + "-off.png"
            }
            break
          default:
            elem.innerHTML = message[name]
        }
    }
}


function invoke(cmd) {
    try {
        websocket.send(cmd);
        return false;
    } catch(err) {
        return true;
    }
}


function SendTemp(temp) {
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open("POST", "command", false);
    xmlHttp.send("TT=" + temp);
}


var AWAYTEMP=15.0;
var HOMETEMP=19.5;
var SLEEPTEMP=17.0;
var COMFORTTEMP=20.5;

$("#away-value").html(AWAYTEMP.toFixed(1));
$("#home-value").html(HOMETEMP.toFixed(1));
$("#sleep-value").html(SLEEPTEMP.toFixed(1));
$("#comfort-value").html(COMFORTTEMP.toFixed(1));

$('#up').click(function(){
  invoke("Up");
  $("#prog").html("OFF");
  $("#prog").css("background-color","#d9534f");
  $("#status").html("Manually override temperature");
  $("#manual").html("ON");
  $("#manual").css("background-color","#5cb85c");

  $('#away').removeClass("btn-lg-sel");
  $('#home').removeClass("btn-lg-sel");
  $('#sleep').removeClass("btn-lg-sel");
  $('#comfort').removeClass("btn-lg-sel");
});

$('#down').click(function(){
  invoke("Down");
  $("#prog").html("OFF");
  $("#prog").css("background-color","#d9534f");
  $("#status").html("Manually override temperature");
  $("#manual").html("ON");
  $("#manual").css("background-color","#5cb85c");

  $('#away').removeClass("btn-lg-sel");
  $('#home').removeClass("btn-lg-sel");
  $('#sleep').removeClass("btn-lg-sel");
  $('#comfort').removeClass("btn-lg-sel");
});

$('#prog').click(function(){
  invoke("Prog");
  $("#prog").html("ON");
  $("#prog").css("background-color","#5cb85c");
  $("#status").html("Manually override temperature");
  $("#manual").html("OFF");
  $("#manual").css("background-color","#d9534f");

  $('#away').removeClass("btn-lg-sel");
  $('#home').removeClass("btn-lg-sel");
  $('#sleep').removeClass("btn-lg-sel");
  $('#comfort').removeClass("btn-lg-sel");
});

$('#away').click(function(){
  $("#prog").html("OFF");
  $("#prog").css("background-color","#d9534f");
  $("#status").html("Temperature manually set to Away: "+AWAYTEMP.toFixed(1)+"&deg;");
  $("#manual").html("ON");
  $("#manual").css("background-color","#5cb85c");

  $('#away').addClass("btn-lg-sel");
  $('#home').removeClass("btn-lg-sel");
  $('#sleep').removeClass("btn-lg-sel");
  $('#comfort').removeClass("btn-lg-sel");
});

$('#home').click(function(){
  $("#prog").html("OFF");
  $("#prog").css("background-color","#d9534f");
  $("#status").html("Temperature manually set to Home: "+HOMETEMP.toFixed(1)+"&deg;");
  $("#manual").html("ON");
  $("#manual").css("background-color","#5cb85c");

  $('#home').addClass("btn-lg-sel");
  $('#away').removeClass("btn-lg-sel");
  $('#sleep').removeClass("btn-lg-sel");
  $('#comfort').removeClass("btn-lg-sel");
});

$('#sleep').click(function(){
  SendTemp(SLEEPTEMP.toFixed(1));
  $("#prog").html("OFF");
  $("#prog").css("background-color","#d9534f");
  $("#status").html("Temperature manually set to Sleep: "+SLEEPTEMP.toFixed(1)+"&deg;");
  $("#manual").html("ON");
  $("#manual").css("background-color","#5cb85c");

  $('#sleep').addClass("btn-lg-sel");
  $('#away').removeClass("btn-lg-sel");
  $('#home').removeClass("btn-lg-sel");
  $('#comfort').removeClass("btn-lg-sel");
});

$('#comfort').click(function(){
  $("#prog").html("OFF");
  $("#prog").css("background-color","#d9534f");
  $("#status").html("Temperature manually set to Comfort: "+COMFORTTEMP.toFixed(1)+"&deg;");
  $("#manual").html("ON");
  $("#manual").css("background-color","#5cb85c");

  $('#comfort').addClass("btn-lg-sel");
  $('#away').removeClass("btn-lg-sel");
  $('#home').removeClass("btn-lg-sel");
  $('#sleep').removeClass("btn-lg-sel");
});

