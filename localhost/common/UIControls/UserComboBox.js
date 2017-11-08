var comBoxValueSelect = function(e) {

    var com = e.combo;

    com.rowIndex = 0;
    com.selectedIndex = -1;
   
    if (e.forceAll) {
        com.store.clearFilter();
        com.onLoad();
        com.selectByValue(com.value);
        com.focus();
        return false;
    }

    else {
        var value = e.query.toLowerCase();
        var regExp = new RegExp("^" + value + ".*");
        com.store.filterBy(function(record, id) {
            var text = record.get("text").toLowerCase();
            var code = record.get("value").toLowerCase();
            return (regExp.test(text) || regExp.test(code));
            //return (text.indexOf(value) != -1 || code.indexOf(value) != -1);
        });
        com.onLoad();
        if (value.length == 2) { com.selectByValue(value); }
        com.focus();
        return false;
    }
}
