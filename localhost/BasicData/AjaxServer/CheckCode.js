function CheckCode(event, obj) {

    event = event || window.event;
    var code = event.keyCode;

    if ((code >= 65 && code <= 90) || (code >= 97 && code <= 122) || (code >= 45 && code <= 57)) {

    }
    else {
        event.keyCode = 0;
        event.returnvalue = false;
    }
    //alert(event.keyCode);
    //alert(String.fromCharCode(event.keyCode));

}
