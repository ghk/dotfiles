var ejos = {
    toggleKeys : function(){
        var keys = options.get("hintkeys");
        if(keys.get() == "weioasdjkl"){
            keys.set("yuiohjklnm");
        } else {
            keys.set("weioasdjkl");
        }
    }
};
