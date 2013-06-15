(function(plugin) {
    "use strict";

    var chrome, fb, firebug, global, __slice = [].slice;

    global = window;
    fb = global.Firebug;
    chrome = fb.chrome;

    function hasClass(el, name){
        return el.className.split(" ").indexOf(name) != -1;
    }

    function log(text){
        defineModule.loadLog.push(text);
    }

    function getActivePanel(){
        var sidePanel = chrome.getSelectedSidePanel();
        if (sidePanel && sidePanel.document.hasFocus()){
            return sidePanel;
        }
        return fb.chrome.getSelectedPanel();
    }
    function setVisible(id, visible){
        if(visible){
            $(chrome.$(id)).show();
        } else {
            $(chrome.$(id)).hide();
        }
    }
    function getActiveElement(panel) {
        return panel.document.activeElement || panel.document || panel.panelNode;
    }
    function addTabNumbers(){
        var panelTabs = chrome.$("fbPanelBar1-panelTabs");
        if(panelTabs.numberAdded){
            return;
        }
        for(var i = 0, len = panelTabs.childNodes.length; i < len; i++){
            panelTabs.childNodes[i].labelNode.value = (i+1) + " "+
                panelTabs.childNodes[i].labelNode.value;
        }
        panelTabs.numberAdded = true;
    }

    function simulateKeyEvent(element, keycode){
        var evt = chrome.window.document.createEvent("KeyboardEvent");
        evt.initKeyEvent("keypress", true, true, null,
                0, 0, 0, 0,
                keycode, 0);
        element.dispatchEvent(evt);
    }

    function simulateClickEvent(target) {

        var evt = chrome.window.document.createEvent("MouseEvents");
        evt.initMouseEvent(
            "click", true, true, null,
            1, 0, 0, 0, 0, false, false, false, false, 0, null);
        target.dispatchEvent(evt);
    }


    var Panel = Class("Panel", {
        focusSelector : ".focusRow",
        sideTabs: {},

        insert: function(){},
        del: function(){},
        goToLine: function(){},
        search: function(){
            var text;
            text = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
            if (chrome.isOpen()) {
                fb.Search.focus(fb.currentContext);
                return fb.Search.search(text.join(' '), fb.currentContext);
            }
        },
        open: function(){},
        getYankText: function(){
            var panel = getActivePanel();
            var element = panel.document.activeElement;
            if(element){
                return $(element).text();
            }
            return null;
        },
    });

    function focusPanel(panel, focusSelector, simulateClick){
        log(focusSelector);
        panel.panelNode.focus();
        if(focusSelector){
            var $els = $(focusSelector, panel.panelNode);
            log($els.length);
            if($els.length){
                $els[0].focus();
                panel.document.activeElement = $els[0];
                DOM($els[0]).focus();
                if(simulateClick){
                    var simulate = function(){
                        simulateClickEvent($els[0]);
                    };
                    setTimeout(simulate, 0);
                }
            }
        } 
    }

    var ConsolePanel = Class("ConsolePanel", Panel, {
    });

    var HtmlPanel = Class("HtmlPanel", Panel, {
        sideTabs: {
            "gs": "css",
            "gc": "computed",
            "gl": "layout",
            "gd": "domSide",
        },
        insert: function(){
            var panel = getActivePanel();
            modes.push(modes.INSERT);
            panel.editNode(panel.selection);
        },
        open: function(){
            var element = getActiveElement(getActivePanel());
            simulateKeyEvent(element, 39);
        },
        getYankText: function(){
            var panel = getActivePanel();
            var cloned = panel.selection.cloneNode();
            var div = content.document.createElement("div");
            return $(div).append(cloned).html();
        },
    });
    var StylesheetPanel = Class("StylesheetPanel", Panel, {
        insert: function(){
            modes.push(modes.INSERT);
            var el = getActiveElement(getActivePanel());
            simulateKeyEvent(panel, 13);
        },
        getYankText: function(){
            var panel = getActivePanel();
            var element = panel.document.activeElement;
            if(element){
                var $element = $(element);
                if($element.hasClass("cssHead")){
                    return $element.parent().text();
                } else if ($element.hasClass("cssProp")){
                    return $element.text();
                }
            }
            return null;
        },
    });
    var ScriptPanel = Class("ScriptPanel", Panel, {
        focusSelector : ".sourceViewport",
        goToLine: function(count){
            var panel = getActivePanel();
            log("eaa");
            panel.scrollToLine(panel.getSourceBoxURL(panel.selectedSourceBox), count);
        },
        sideTabs : {
            "gs": "callstack",
            "gw": "watches",
            "gb": "breakpoints",
        },
    });
    var DomPanel = Class("DomPanel", Panel, {
        focusSelector : ".objectBox[role], .objectLink[role]",
        insert: function(){
            modes.push(modes.INSERT);
            var panel = getActivePanel();
            panel.editProperty(panel.document.activeElement.parentElement.parentElement);
                
        },
    });

    var NetPanel = Class("NetPanel", Panel, {
        focusSelector : ".netRow.hasHeaders",
        focusClick: true,
        open: function(){
            var element = getActiveElement(getActivePanel());
            simulateKeyEvent(element, 13);
        },
    });
    var LayoutPanel = Class("LayoutPanel", Panel, {
        focusSelector : ".focusGroup",
    });
    var CookiesPanel = NetPanel;


    var panels = plugin.panels = {
        main: {
            console: new ConsolePanel(),
            html: new HtmlPanel(),
            stylesheet: new StylesheetPanel(),
            script: new ScriptPanel(),
            dom: new DomPanel(),
            net: new NetPanel(),
            cookies: new CookiesPanel(),
        },
        side: {
            css: new StylesheetPanel(),
            domSide: new DomPanel(),
            layout: new LayoutPanel(),
            computed: new Panel(),
            callstack: new Panel(),
            watches: new Panel(),
            breakpoints: new Panel(),
        },
        get active() {
            var panel = getActivePanel();
            var sidePanel = fb.chrome.getSelectedSidePanel();
            if (sidePanel && sidePanel.document.hasFocus()){
                return this["side"][panel.name];
            }
            return this["main"][panel.name];
        },
    }



    firebug = plugin = {
        info: {
            version: '0.1.3',
            "mode": "open firebug mode",
            "mode-off": "close firebug mode",

            close: "minimize firebug window",
            shutdown: "shutdown firebug",

            source: "given a function object, show its source",
            inspect: "given a element selector, inspect it",
            "inspect-next": "inspect next object from the previous selector",
            "inspect-previous": "inspect next object from the previous selector",
            'tab': "focuses the specified firebug tab (console, html, stylesheet, script, dom, net, etc)",
            'tab-side': "focuses the specified firebug side tab (css, computed, layout, dom, domSide, watch)",
            'tab-right': "focuses the next firebug tab(right)",
            'tab-left': "focuses the next firebug tab(left)",
            'focus-main': "set focus to main panel",
            'focus-side': "set focus to side panel",

            'search': "search",
            'delete': "delete",
            'insert': "insert",
            'open': "open",
            'yank': "yank",

            'position': "set firebug position, top,left,right,bottom",
            'orient': "set firebug side panel orient, top,left,right,bottom",
            'toggle-view': "toggle most common position and orient",

            "go-to-line": "go to line",
            "keypress": "perform a keypress",
            "start-command": "start command line mode",
        },
        'mode': function() {
            modes.push(modes.FIREBUG);
            if (!chrome.isOpen()) {
                return fb.toggleBar(true, 'console');
            }
            setVisible("fbPanelBar1-tabBox", true);

            setVisible("fbPanelBar1-buttons", false);
            setVisible("fbWindowButtons", false);
            setVisible("panelBarTabList", false);

            $(chrome.$("fbToolbarInner")).css({"background-color": "#c3c4be"});

            addTabNumbers();
        },
        'mode-off': function() {
            setVisible("fbPanelBar1-tabBox", false);
            modes.reset();
        },
        close: function() {
            modes.pop();
            return fb.closeFirebug(true);
        },
        shutdown: function(){
        },

        source: function(expr){
            var value = content.document.defaultView.wrappedJSObject.eval(expr);
            if(value){
                this.tab("script");
                getActivePanel().showFunction(value);
                this["focus-main"]();
            }
        },
        inspect: function(selector, index) {
            if (!fb.currentContext) {
                fb.toggleBar(true);
            }
            log(index);
            if(!index)
                index = 0;
            var el = $(selector, content.document)[index];
            if(el){
                this.tab("html");
                content.fbInspectLastIndex = index;
                content.fbInspectLastSelector = selector;
                getActivePanel().selection = el;
                getActivePanel().updateSelection(el);
            }
        },
        "inspect-previous": function(){
            if(content.fbInspectLastSelector){
                this.inspect(content.fbInspectLastSelector, 
                        content.fbInspectLastIndex - 1);
            }
        },
        "inspect-next": function(){
            if(content.fbInspectLastSelector){
                this.inspect(content.fbInspectLastSelector, 
                        content.fbInspectLastIndex + 1);
            }
        },
        'tab': function(panelName) {
            if (panelName == null) {
                panelName = "console";
            }
            if (chrome.isOpen()) {
                if(chrome.getSelectedPanel().name == panelName){
                    return;
                }

                chrome.navigate(null, panelName);
                this["focus-main"]();
            }
        },
        'tab-side': function(panelName) {
            if (chrome.isOpen()) {
                chrome.selectSidePanel(panelName);
                this["focus-side"]();
            }
        },
        'tab-right': function() {
            if (chrome.isOpen()) {
                chrome.gotoSiblingTab(true);
                this["focus-main"]();
            }
        },
        'tab-left': function() {
            if (chrome.isOpen()) {
                chrome.gotoSiblingTab();
                this["focus-main"]();
            }
        },
        'focus-main': function(){
            var panel = chrome.getSelectedPanel();
            focusPanel(panel, panels.main[panel.name].focusSelector, panels.main[panel.name].focusClick);
        },
        'focus-side': function(){
            var panel = chrome.getSelectedSidePanel();
            focusPanel(panel, panels.side[panel.name].focusSelector, panels.side[panel.name].focusClick);
        },

        'search': function() {
            panels.active.search();
        },
        'delete': function() {
            panels.active.del();
        },
        'insert': function() {
            panels.active.insert();
        },
        'open': function() {
            panels.active.open();
        },
        'yank': function() {
            var yankText = panels.active.getYankText();
            if(yankText != null){
                dactyl.clipboardWrite(yankText, true);
            }
        },

        'position': function(value) {
            chrome.setPosition(value);
        },
        'orient': function(value) {
            chrome.toggleOrient(value);
        },

        'toggle-view': function(value){
            if(chrome.framePosition == "bottom" || !chrome.framePosition){
                this.position("left");
                this.orient("bottom");
            } else {
                this.position("bottom");
                this.orient("bottom");
            }
        },

        'go-to-line': function(line) {
            panels.active.goToLine(line);
        },
        'keypress': function(keycode){
            simulateKeyEvent(getActiveElement(getActivePanel()), keycode);
        },
        'start-command': function(text){
            CommandExMode().open(text);
        },

        _initialize: function() {
            fb = global.Firebug;
            chrome = fb.chrome;
            //return this.behave();
        }
    };


    modes.addMode("FIREBUG", {
        extended: true,
        description: "firebug",
        bases: [modes.COMMAND],
        input: false,
    });

    var tabs = [
        "console", "html", "stylesheet", "script", "dom", "net", "cookies"
        ];

    group.mappings.add([modes.FIREBUG], ["b"],
            "",
    function ({count}) { 
        if (count > tabs.length)
            return;
        firebug.tab(tabs[count-1]);
    }, {count: true});

    //group.mappings.add([modes.FIREBUG], ["G"],
            //"",
    //function ({count}) { 
        //firebug["go-to-line"](count);
    //}, {count: true});


    var addTabSideMapping = function (key){
        group.mappings.add([modes.FIREBUG], [key],
            "",
            function(){
                var panel = Firebug.chrome.getSelectedPanel();
                firebug["tab-side"](panels.main[panel.name].sideTabs[key]);
        });
    }

    var tabKeys = plugin.tabkeys = {};
    for (var key in panels.main){
        var panel = panels.main[key];
        if(panel && panel.sideTabs){
            for (var key in panel.sideTabs)
                tabKeys[key] = true;
        }
    }
    for (var key in tabKeys){
        addTabSideMapping(key);
    }

    var addMovementMapping = function(key, dir, keycode){
        group.mappings.add([modes.FIREBUG], [key],
                "Leave Autocomplete or Menu mode",
        function(){
            firebug.keypress(keycode);
        });
    };

    addMovementMapping("h", "left", 37);
    addMovementMapping("j", "down", 40);
    addMovementMapping("k", "up", 38);
    addMovementMapping("l", "right", 39);
    addMovementMapping("<C-d>", "page down", 34);
    addMovementMapping("<C-u>", "page up", 33);
    addMovementMapping("gg", "home", 36);
    addMovementMapping("G", "end", 35);

    group.commands.add(['fbmap'], "firebug map", function(args) {
        group.mappings.add([modes.FIREBUG], [args[0]],
                "",
        function () { 
            dactyl.execute(args[1]);
        });
        var command, index, _i, _len, _results;
    }, {});
    

    group.commands.add(['firebug', 'fbpc'], "firebug-pentadactyl (version " + firebug.info.version + ")", function(args) {
        var command, index, _i, _len, _results;
        if (!chrome) {
            firebug._initialize();
        }
        _results = [];
        for (index = _i = 0, _len = args.length; _i < _len; index = ++_i) {
            command = args[index];
            if (firebug[command]) {
                _results.push(firebug[command].apply(firebug, args.slice(index + 1)));
            }
        }
        return _results;
    }, {
        completer: function(context) {
            var name;
            return context.completions = (function() {
                var _results;
                _results = [];
                for (name in firebug) {
                    if (name !== 'info' && name.indexOf('_') != 0) {
                        if(firebug.info[name])
                            _results.push([name, firebug.info[name]]);
                    }
                }
                return _results;
            })();
        }
    });
    io.source("~/.pentadactyl/fbmap");


})(this);
