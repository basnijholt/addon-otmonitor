oldjson = "";

$(document).ready(function() {

    function highlightValue(key,value,oldvalue) {
        if (oldvalue < value) {
            updown = "countUp";
            $('#'+key).html("<span class='"+updown+"'>"+(value)+"</span>");
            $('#'+key).effect( "highlight",{color:"#FF0000"}, 1000 );
        }
        else if (oldvalue == value) {
            updown = "";
            $('#'+key).html("<span class='"+updown+"'>"+(value)+"</span>");
        }
        else {
            updown = "countDown";
            $('#'+key).html("<span class='"+updown+"'>"+(value)+"</span>");
            $('#'+key).effect( "highlight",{color:"#008000"}, 1000 ); //2C3539
        }
    }

    function updateDash(){
        $.ajax({
            url: "http" + document.URL.match("s?://[-a-zA-Z0-9.:_/]+/") + "json",
            dataType: "json",
            cache: false,
            success: function(json) {
                for (var key in json) {
                    var val = json[key].value;
                    var oldvalue = oldjson[key];

                    highlightValue(key,val,oldvalue);
                }
                oldjson = JSON.parse(JSON.stringify(json));
                console.log("oldjson: "+oldjson);
            }
        });
    }

    updateDash();
    setInterval(updateDash, 5000);
});

