(function(plugin) {
    "use strict";

    var chrome, cmd, fb, firebug, global, __slice = [].slice;

    global = window;
    fb = global.Firebug;
    chrome = fb.chrome;
    cmd = fb.CommandLine;

    function hasClass(el, name){
        return el.className.split(" ").indexOf(name) != -1;
    }

    function log(text){
        defineModule.loadLog.push(text);
    }

    function getActivePanel(){
        var sidePanel = fb.chrome.getSelectedSidePanel();
        if (sidePanel && sidePanel.document.hasFocus()){
            return sidePanel;
        }
        return fb.chrome.getSelectedPanel();
    }
    function getActiveElement(panel) {
        return panel.document.activeElement || panel.document || panel.panelNode;
    }

    function simulateKeyEvent(element, keycode){
        var evt = global.Firebug.chrome.window.document.createEvent("KeyboardEvent");
        evt.initKeyEvent("keypress", true, true, null,
                0, 0, 0, 0,
                keycode, 0);
        element.dispatchEvent(evt);
    }

    function simulateClickEvent(target) {

        var evt = global.Firebug.chrome.window.document.createEvent("MouseEvents");
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
        get activeElement(){
            var el = this.activePanel.document.activeElement || this.activePanel.panelNode
            if(!hasClass(el, "cssProp") && !hasClass(el, "cssHead")){
                var els = this.activePanel.panelNode.getElementsByClassName("cssProp");
                if(els.length > 1){
                    el = els[0];
                }
            }
            return el
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
        get activeElement(){
            var el = this.activePanel.document.activeElement || this.activePanel.panelNode
            if(el.getAttribute("role") == "DOM Panel"){
                var els = panel.panelNode.getElementsByClassName("a11yFocus");
                if(els.length > 1){
                    el = els[0];
                }
            }
            return el
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
            open: "open firebug window",
            close: "minimize firebug window",
            toggle: "toggle firebug window",
            disable: "exit from firebug",
            console: "open console and set focus",
            multiline: "multiline console",
            "toggle-console": "toggle between one-line and multiline console",
            clear: "clear console output window",
            run: "run script that was entered in console editor",
            'tab': "focuses the specified firebug tab (console, html, stylesheet, script, dom, net, etc)",
            'tab-side': "focuses the specified firebug side tab (css, computed, layout, dom, domSide, watch)",
            'tab-right': "focuses the next firebug tab(right)",
            'tab-left': "focuses the next firebug tab(left)",
            '#': "focuses the prev firebug tab",
            'search': "search",
            inspect: "toggle the firebug element inspector",
            behave: "use Behave.js for console (like auto-pairs)"
        },
        close: function() {
            modes.pop();
            return fb.closeFirebug(true);
        },
        hide: function() {
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
        behave: function() {
            if (this._editor) {
                this._editor.destroy();
                this._editor = null;
                return;
            }
            if (!this._editor && cmd && dactyl.plugins && dactyl.plugins.Behave) {
                return this._editor = new dactyl.plugins.Behave({
                    textarea: cmd.getCommandEditor().editor.textBox
                });
            }
        },
        'tab': function(panelName) {
            if (panelName == null) {
                panelName = "console";
            }
            if (chrome.isOpen()) {
                chrome.navigate(null, panelName);
                focusPanel(chrome.getSelectedPanel(), panels.main[panelName].focusSelector, panels.main[panelName].focusClick);
            }
        },
        'tab-side': function(panelName) {
            if (chrome.isOpen()) {
                chrome.selectSidePanel(panelName);
                focusPanel(chrome.getSelectedSidePanel(), panels.side[panelName].focusSelector, panels.side[panelName].focusClick);
            }
        },
        'tab-right': function() {
            if (chrome.isOpen()) {
                chrome.gotoSiblingTab(true);
                var panelName = chrome.getSelectedPanel().name;
                focusPanel(chrome.getSelectedPanel(), panels.main[panelName].focusSelector, panels.main[panelName].focusClick);
            }
        },
        'tab-left': function() {
            if (chrome.isOpen()) {
                chrome.gotoSiblingTab();
                var panelName = chrome.getSelectedPanel().name;
                focusPanel(chrome.getSelectedPanel(), panels.main[panelName].focusSelector, panels.main[panelName].focusClick);
            }
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
        'position': function(value) {
            chrome.setPosition(value);
        },
        'orient': function(value) {
            chrome.toggleOrient(value);
        },
        'toggle_view': function(value){
            if(chrome.framePosition == "bottom"){
                this.position("left");
                this.orient("bottom");
            } else {
                this.position("bottom");
                this.orient("bottom");
            }
        },
        'yank': function() {
            var yankText = panels.active.getYankText();
            if(yankText != null){
                dactyl.clipboardWrite(yankText, true);
            }
        },
        'mode': function() {
            modes.push(modes.FIREBUG);
            if (!chrome.isOpen()) {
                return fb.toggleBar(true, 'console');
            }
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
            cmd = fb.CommandLine;
            return this.behave();
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
                    if (name !== 'info' || name.indexOf('_')) {
                        _results.push([name, firebug.info[name]]);
                    }
                }
                return _results;
            })();
        }
    });
    io.source("~/.pentadactyl/fbmap");


})(this);
