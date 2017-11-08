/*
    01 jQuery UI Core 1.8.8   15 行
    02 jQuery UI Widget 1.8.8   326 行
    03 jQuery UI Position 1.8.8   591 行
    04 jQuery UI Mouse 1.8.8   846 行
    05 jQuery UI Draggable 1.8.8   1000 行
    06 jQuery UI Button 1.8.8   1800 行
    07 jQuery UI Resizable 1.8.8   2176 行
    08 jQuery UI Dialog 1.8.8   2991 行
    09 jQuery Treeview    3851 行
    10 jQuery UI Autocomplete 1.8.8   4104 行
    11 jQuery include   4954 行
    12 jQuery pagination   4741 行
    13 Masked Input plugin for jQuery   4958 行
*/


/*!
* jQuery UI 1.8.8
*
* Copyright 2010, AUTHORS.txt (http://jqueryui.com/about)
* Dual licensed under the MIT or GPL Version 2 licenses.
* http://jquery.org/license
*
* http://docs.jquery.com/UI
*/
(function($, undefined) {

    // prevent duplicate loading
    // this is only a problem because we proxy existing functions
    // and we don't want to double proxy them
    $.ui = $.ui || {};
    if ($.ui.version) {
        return;
    }

    $.extend($.ui, {
        version: "1.8.8",

        keyCode: {
            ALT: 18,
            BACKSPACE: 8,
            CAPS_LOCK: 20,
            COMMA: 188,
            COMMAND: 91,
            COMMAND_LEFT: 91, // COMMAND
            COMMAND_RIGHT: 93,
            CONTROL: 17,
            DELETE: 46,
            DOWN: 40,
            END: 35,
            ENTER: 13,
            ESCAPE: 27,
            HOME: 36,
            INSERT: 45,
            LEFT: 37,
            MENU: 93, // COMMAND_RIGHT
            NUMPAD_ADD: 107,
            NUMPAD_DECIMAL: 110,
            NUMPAD_DIVIDE: 111,
            NUMPAD_ENTER: 108,
            NUMPAD_MULTIPLY: 106,
            NUMPAD_SUBTRACT: 109,
            PAGE_DOWN: 34,
            PAGE_UP: 33,
            PERIOD: 190,
            RIGHT: 39,
            SHIFT: 16,
            SPACE: 32,
            TAB: 9,
            UP: 38,
            WINDOWS: 91 // COMMAND
        }
    });

    // plugins
    $.fn.extend({
        _focus: $.fn.focus,
        focus: function(delay, fn) {
            return typeof delay === "number" ?
			this.each(function() {
			    var elem = this;
			    setTimeout(function() {
			        $(elem).focus();
			        if (fn) {
			            fn.call(elem);
			        }
			    }, delay);
			}) :
			this._focus.apply(this, arguments);
        },

        scrollParent: function() {
            var scrollParent;
            if (($.browser.msie && (/(static|relative)/).test(this.css('position'))) || (/absolute/).test(this.css('position'))) {
                scrollParent = this.parents().filter(function() {
                    return (/(relative|absolute|fixed)/).test($.curCSS(this, 'position', 1)) && (/(auto|scroll)/).test($.curCSS(this, 'overflow', 1) + $.curCSS(this, 'overflow-y', 1) + $.curCSS(this, 'overflow-x', 1));
                }).eq(0);
            } else {
                scrollParent = this.parents().filter(function() {
                    return (/(auto|scroll)/).test($.curCSS(this, 'overflow', 1) + $.curCSS(this, 'overflow-y', 1) + $.curCSS(this, 'overflow-x', 1));
                }).eq(0);
            }

            return (/fixed/).test(this.css('position')) || !scrollParent.length ? $(document) : scrollParent;
        },

        zIndex: function(zIndex) {
            if (zIndex !== undefined) {
                return this.css("zIndex", zIndex);
            }

            if (this.length) {
                var elem = $(this[0]), position, value;
                while (elem.length && elem[0] !== document) {
                    // Ignore z-index if position is set to a value where z-index is ignored by the browser
                    // This makes behavior of this function consistent across browsers
                    // WebKit always returns auto if the element is positioned
                    position = elem.css("position");
                    if (position === "absolute" || position === "relative" || position === "fixed") {
                        // IE returns 0 when zIndex is not specified
                        // other browsers return a string
                        // we ignore the case of nested elements with an explicit value of 0
                        // <div style="z-index: -10;"><div style="z-index: 0;"></div></div>
                        value = parseInt(elem.css("zIndex"), 10);
                        if (!isNaN(value) && value !== 0) {
                            return value;
                        }
                    }
                    elem = elem.parent();
                }
            }

            return 0;
        },

        disableSelection: function() {
            return this.bind(($.support.selectstart ? "selectstart" : "mousedown") +
			".ui-disableSelection", function(event) {
			    event.preventDefault();
			});
        },

        enableSelection: function() {
            return this.unbind(".ui-disableSelection");
        }
    });

    $.each(["Width", "Height"], function(i, name) {
        var side = name === "Width" ? ["Left", "Right"] : ["Top", "Bottom"],
		type = name.toLowerCase(),
		orig = {
		    innerWidth: $.fn.innerWidth,
		    innerHeight: $.fn.innerHeight,
		    outerWidth: $.fn.outerWidth,
		    outerHeight: $.fn.outerHeight
		};

        function reduce(elem, size, border, margin) {
            $.each(side, function() {
                size -= parseFloat($.curCSS(elem, "padding" + this, true)) || 0;
                if (border) {
                    size -= parseFloat($.curCSS(elem, "border" + this + "Width", true)) || 0;
                }
                if (margin) {
                    size -= parseFloat($.curCSS(elem, "margin" + this, true)) || 0;
                }
            });
            return size;
        }

        $.fn["inner" + name] = function(size) {
            if (size === undefined) {
                return orig["inner" + name].call(this);
            }

            return this.each(function() {
                $(this).css(type, reduce(this, size) + "px");
            });
        };

        $.fn["outer" + name] = function(size, margin) {
            if (typeof size !== "number") {
                return orig["outer" + name].call(this, size);
            }

            return this.each(function() {
                $(this).css(type, reduce(this, size, true, margin) + "px");
            });
        };
    });

    // selectors
    function visible(element) {
        return !$(element).parents().andSelf().filter(function() {
            return $.curCSS(this, "visibility") === "hidden" ||
			$.expr.filters.hidden(this);
        }).length;
    }

    $.extend($.expr[":"], {
        data: function(elem, i, match) {
            return !!$.data(elem, match[3]);
        },

        focusable: function(element) {
            var nodeName = element.nodeName.toLowerCase(),
			tabIndex = $.attr(element, "tabindex");
            if ("area" === nodeName) {
                var map = element.parentNode,
				mapName = map.name,
				img;
                if (!element.href || !mapName || map.nodeName.toLowerCase() !== "map") {
                    return false;
                }
                img = $("img[usemap=#" + mapName + "]")[0];
                return !!img && visible(img);
            }
            return (/input|select|textarea|button|object/.test(nodeName)
			? !element.disabled
			: "a" == nodeName
				? element.href || !isNaN(tabIndex)
				: !isNaN(tabIndex))
            // the element and all of its ancestors must be visible
			&& visible(element);
        },

        tabbable: function(element) {
            var tabIndex = $.attr(element, "tabindex");
            return (isNaN(tabIndex) || tabIndex >= 0) && $(element).is(":focusable");
        }
    });

    // support
    $(function() {
        var body = document.body,
		div = body.appendChild(div = document.createElement("div"));

        $.extend(div.style, {
            minHeight: "100px",
            height: "auto",
            padding: 0,
            borderWidth: 0
        });

        $.support.minHeight = div.offsetHeight === 100;
        $.support.selectstart = "onselectstart" in div;

        // set display to none to avoid a layout bug in IE
        // http://dev.jquery.com/ticket/4014
        body.removeChild(div).style.display = "none";
    });





    // deprecated
    $.extend($.ui, {
        // $.ui.plugin is deprecated.  Use the proxy pattern instead.
        plugin: {
            add: function(module, option, set) {
                var proto = $.ui[module].prototype;
                for (var i in set) {
                    proto.plugins[i] = proto.plugins[i] || [];
                    proto.plugins[i].push([option, set[i]]);
                }
            },
            call: function(instance, name, args) {
                var set = instance.plugins[name];
                if (!set || !instance.element[0].parentNode) {
                    return;
                }

                for (var i = 0; i < set.length; i++) {
                    if (instance.options[set[i][0]]) {
                        set[i][1].apply(instance.element, args);
                    }
                }
            }
        },

        // will be deprecated when we switch to jQuery 1.4 - use jQuery.contains()
        contains: function(a, b) {
            return document.compareDocumentPosition ?
			a.compareDocumentPosition(b) & 16 :
			a !== b && a.contains(b);
        },

        // only used by resizable
        hasScroll: function(el, a) {

            //If overflow is hidden, the element might have extra content, but the user wants to hide it
            if ($(el).css("overflow") === "hidden") {
                return false;
            }

            var scroll = (a && a === "left") ? "scrollLeft" : "scrollTop",
			has = false;

            if (el[scroll] > 0) {
                return true;
            }

            // TODO: determine which cases actually cause this to happen
            // if the element doesn't have the scroll set, see if it's possible to
            // set the scroll
            el[scroll] = 1;
            has = (el[scroll] > 0);
            el[scroll] = 0;
            return has;
        },

        // these are odd functions, fix the API or move into individual plugins
        isOverAxis: function(x, reference, size) {
            //Determines when x coordinate is over "b" element axis
            return (x > reference) && (x < (reference + size));
        },
        isOver: function(y, x, top, left, height, width) {
            //Determines when x, y coordinates is over "b" element
            return $.ui.isOverAxis(y, top, height) && $.ui.isOverAxis(x, left, width);
        }
    });

})(jQuery);



/*!
* jQuery UI Widget 1.8.8
*
* Copyright 2010, AUTHORS.txt (http://jqueryui.com/about)
* Dual licensed under the MIT or GPL Version 2 licenses.
* http://jquery.org/license
*
* http://docs.jquery.com/UI/Widget
*/
(function($, undefined) {

    // jQuery 1.4+
    if ($.cleanData) {
        var _cleanData = $.cleanData;
        $.cleanData = function(elems) {
            for (var i = 0, elem; (elem = elems[i]) != null; i++) {
                $(elem).triggerHandler("remove");
            }
            _cleanData(elems);
        };
    } else {
        var _remove = $.fn.remove;
        $.fn.remove = function(selector, keepData) {
            return this.each(function() {
                if (!keepData) {
                    if (!selector || $.filter(selector, [this]).length) {
                        $("*", this).add([this]).each(function() {
                            $(this).triggerHandler("remove");
                        });
                    }
                }
                return _remove.call($(this), selector, keepData);
            });
        };
    }

    $.widget = function(name, base, prototype) {
        var namespace = name.split(".")[0],
		fullName;
        name = name.split(".")[1];
        fullName = namespace + "-" + name;

        if (!prototype) {
            prototype = base;
            base = $.Widget;
        }

        // create selector for plugin
        $.expr[":"][fullName] = function(elem) {
            return !!$.data(elem, name);
        };

        $[namespace] = $[namespace] || {};
        $[namespace][name] = function(options, element) {
            // allow instantiation without initializing for simple inheritance
            if (arguments.length) {
                this._createWidget(options, element);
            }
        };

        var basePrototype = new base();
        // we need to make the options hash a property directly on the new instance
        // otherwise we'll modify the options hash on the prototype that we're
        // inheriting from
        //	$.each( basePrototype, function( key, val ) {
        //		if ( $.isPlainObject(val) ) {
        //			basePrototype[ key ] = $.extend( {}, val );
        //		}
        //	});
        basePrototype.options = $.extend(true, {}, basePrototype.options);
        $[namespace][name].prototype = $.extend(true, basePrototype, {
            namespace: namespace,
            widgetName: name,
            widgetEventPrefix: $[namespace][name].prototype.widgetEventPrefix || name,
            widgetBaseClass: fullName
        }, prototype);

        $.widget.bridge(name, $[namespace][name]);
    };

    $.widget.bridge = function(name, object) {
        $.fn[name] = function(options) {
            var isMethodCall = typeof options === "string",
			args = Array.prototype.slice.call(arguments, 1),
			returnValue = this;

            // allow multiple hashes to be passed on init
            options = !isMethodCall && args.length ?
			$.extend.apply(null, [true, options].concat(args)) :
			options;

            // prevent calls to internal methods
            if (isMethodCall && options.charAt(0) === "_") {
                return returnValue;
            }

            if (isMethodCall) {
                this.each(function() {
                    var instance = $.data(this, name),
					methodValue = instance && $.isFunction(instance[options]) ?
						instance[options].apply(instance, args) :
						instance;
                    // TODO: add this back in 1.9 and use $.error() (see #5972)
                    //				if ( !instance ) {
                    //					throw "cannot call methods on " + name + " prior to initialization; " +
                    //						"attempted to call method '" + options + "'";
                    //				}
                    //				if ( !$.isFunction( instance[options] ) ) {
                    //					throw "no such method '" + options + "' for " + name + " widget instance";
                    //				}
                    //				var methodValue = instance[ options ].apply( instance, args );
                    if (methodValue !== instance && methodValue !== undefined) {
                        returnValue = methodValue;
                        return false;
                    }
                });
            } else {
                this.each(function() {
                    var instance = $.data(this, name);
                    if (instance) {
                        instance.option(options || {})._init();
                    } else {
                        $.data(this, name, new object(options, this));
                    }
                });
            }

            return returnValue;
        };
    };

    $.Widget = function(options, element) {
        // allow instantiation without initializing for simple inheritance
        if (arguments.length) {
            this._createWidget(options, element);
        }
    };

    $.Widget.prototype = {
        widgetName: "widget",
        widgetEventPrefix: "",
        options: {
            disabled: false
        },
        _createWidget: function(options, element) {
            // $.widget.bridge stores the plugin instance, but we do it anyway
            // so that it's stored even before the _create function runs
            $.data(element, this.widgetName, this);
            this.element = $(element);
            this.options = $.extend(true, {},
			this.options,
			this._getCreateOptions(),
			options);

            var self = this;
            this.element.bind("remove." + this.widgetName, function() {
                self.destroy();
            });

            this._create();
            this._trigger("create");
            this._init();
        },
        _getCreateOptions: function() {
            return $.metadata && $.metadata.get(this.element[0])[this.widgetName];
        },
        _create: function() { },
        _init: function() { },

        destroy: function() {
            this.element
			.unbind("." + this.widgetName)
			.removeData(this.widgetName);
            this.widget()
			.unbind("." + this.widgetName)
			.removeAttr("aria-disabled")
			.removeClass(
				this.widgetBaseClass + "-disabled " +
				"ui-state-disabled");
        },

        widget: function() {
            return this.element;
        },

        option: function(key, value) {
            var options = key;

            if (arguments.length === 0) {
                // don't return a reference to the internal hash
                return $.extend({}, this.options);
            }

            if (typeof key === "string") {
                if (value === undefined) {
                    return this.options[key];
                }
                options = {};
                options[key] = value;
            }

            this._setOptions(options);

            return this;
        },
        _setOptions: function(options) {
            var self = this;
            $.each(options, function(key, value) {
                self._setOption(key, value);
            });

            return this;
        },
        _setOption: function(key, value) {
            this.options[key] = value;

            if (key === "disabled") {
                this.widget()
				[value ? "addClass" : "removeClass"](
					this.widgetBaseClass + "-disabled" + " " +
					"ui-state-disabled")
				.attr("aria-disabled", value);
            }

            return this;
        },

        enable: function() {
            return this._setOption("disabled", false);
        },
        disable: function() {
            return this._setOption("disabled", true);
        },

        _trigger: function(type, event, data) {
            var callback = this.options[type];

            event = $.Event(event);
            event.type = (type === this.widgetEventPrefix ?
			type :
			this.widgetEventPrefix + type).toLowerCase();
            data = data || {};

            // copy original event properties over to the new event
            // this would happen if we could call $.event.fix instead of $.Event
            // but we don't have a way to force an event to be fixed multiple times
            if (event.originalEvent) {
                for (var i = $.event.props.length, prop; i; ) {
                    prop = $.event.props[--i];
                    event[prop] = event.originalEvent[prop];
                }
            }

            this.element.trigger(event, data);

            return !($.isFunction(callback) &&
			callback.call(this.element[0], event, data) === false ||
			event.isDefaultPrevented());
        }
    };

})(jQuery);



/*
* jQuery UI Position 1.8.8
*
* Copyright 2010, AUTHORS.txt (http://jqueryui.com/about)
* Dual licensed under the MIT or GPL Version 2 licenses.
* http://jquery.org/license
*
* http://docs.jquery.com/UI/Position
*/
(function($, undefined) {

    $.ui = $.ui || {};

    var horizontalPositions = /left|center|right/,
	verticalPositions = /top|center|bottom/,
	center = "center",
	_position = $.fn.position,
	_offset = $.fn.offset;

    $.fn.position = function(options) {
        if (!options || !options.of) {
            return _position.apply(this, arguments);
        }

        // make a copy, we don't want to modify arguments
        options = $.extend({}, options);

        var target = $(options.of),
		targetElem = target[0],
		collision = (options.collision || "flip").split(" "),
		offset = options.offset ? options.offset.split(" ") : [0, 0],
		targetWidth,
		targetHeight,
		basePosition;

        if (targetElem.nodeType === 9) {
            targetWidth = target.width();
            targetHeight = target.height();
            basePosition = { top: 0, left: 0 };
            // TODO: use $.isWindow() in 1.9
        } else if (targetElem.setTimeout) {
            targetWidth = target.width();
            targetHeight = target.height();
            basePosition = { top: target.scrollTop(), left: target.scrollLeft() };
        } else if (targetElem.preventDefault) {
            // force left top to allow flipping
            options.at = "left top";
            targetWidth = targetHeight = 0;
            basePosition = { top: options.of.pageY, left: options.of.pageX };
        } else {
            targetWidth = target.outerWidth();
            targetHeight = target.outerHeight();
            basePosition = target.offset();
        }

        // force my and at to have valid horizontal and veritcal positions
        // if a value is missing or invalid, it will be converted to center 
        $.each(["my", "at"], function() {
            var pos = (options[this] || "").split(" ");
            if (pos.length === 1) {
                pos = horizontalPositions.test(pos[0]) ?
				pos.concat([center]) :
				verticalPositions.test(pos[0]) ?
					[center].concat(pos) :
					[center, center];
            }
            pos[0] = horizontalPositions.test(pos[0]) ? pos[0] : center;
            pos[1] = verticalPositions.test(pos[1]) ? pos[1] : center;
            options[this] = pos;
        });

        // normalize collision option
        if (collision.length === 1) {
            collision[1] = collision[0];
        }

        // normalize offset option
        offset[0] = parseInt(offset[0], 10) || 0;
        if (offset.length === 1) {
            offset[1] = offset[0];
        }
        offset[1] = parseInt(offset[1], 10) || 0;

        if (options.at[0] === "right") {
            basePosition.left += targetWidth;
        } else if (options.at[0] === center) {
            basePosition.left += targetWidth / 2;
        }

        if (options.at[1] === "bottom") {
            basePosition.top += targetHeight;
        } else if (options.at[1] === center) {
            basePosition.top += targetHeight / 2;
        }

        basePosition.left += offset[0];
        basePosition.top += offset[1];

        return this.each(function() {
            var elem = $(this),
			elemWidth = elem.outerWidth(),
			elemHeight = elem.outerHeight(),
			marginLeft = parseInt($.curCSS(this, "marginLeft", true)) || 0,
			marginTop = parseInt($.curCSS(this, "marginTop", true)) || 0,
			collisionWidth = elemWidth + marginLeft +
				(parseInt($.curCSS(this, "marginRight", true)) || 0),
			collisionHeight = elemHeight + marginTop +
				(parseInt($.curCSS(this, "marginBottom", true)) || 0),
			position = $.extend({}, basePosition),
			collisionPosition;

            if (options.my[0] === "right") {
                position.left -= elemWidth;
            } else if (options.my[0] === center) {
                position.left -= elemWidth / 2;
            }

            if (options.my[1] === "bottom") {
                position.top -= elemHeight;
            } else if (options.my[1] === center) {
                position.top -= elemHeight / 2;
            }

            // prevent fractions (see #5280)
            position.left = Math.round(position.left);
            position.top = Math.round(position.top);

            collisionPosition = {
                left: position.left - marginLeft,
                top: position.top - marginTop
            };

            $.each(["left", "top"], function(i, dir) {
                if ($.ui.position[collision[i]]) {
                    $.ui.position[collision[i]][dir](position, {
                        targetWidth: targetWidth,
                        targetHeight: targetHeight,
                        elemWidth: elemWidth,
                        elemHeight: elemHeight,
                        collisionPosition: collisionPosition,
                        collisionWidth: collisionWidth,
                        collisionHeight: collisionHeight,
                        offset: offset,
                        my: options.my,
                        at: options.at
                    });
                }
            });

            if ($.fn.bgiframe) {
                elem.bgiframe();
            }
            elem.offset($.extend(position, { using: options.using }));
        });
    };

    $.ui.position = {
        fit: {
            left: function(position, data) {
                var win = $(window),
				over = data.collisionPosition.left + data.collisionWidth - win.width() - win.scrollLeft();
                position.left = over > 0 ? position.left - over : Math.max(position.left - data.collisionPosition.left, position.left);
            },
            top: function(position, data) {
                var win = $(window),
				over = data.collisionPosition.top + data.collisionHeight - win.height() - win.scrollTop();
                position.top = over > 0 ? position.top - over : Math.max(position.top - data.collisionPosition.top, position.top);
            }
        },

        flip: {
            left: function(position, data) {
                if (data.at[0] === center) {
                    return;
                }
                var win = $(window),
				over = data.collisionPosition.left + data.collisionWidth - win.width() - win.scrollLeft(),
				myOffset = data.my[0] === "left" ?
					-data.elemWidth :
					data.my[0] === "right" ?
						data.elemWidth :
						0,
				atOffset = data.at[0] === "left" ?
					data.targetWidth :
					-data.targetWidth,
				offset = -2 * data.offset[0];
                position.left += data.collisionPosition.left < 0 ?
				myOffset + atOffset + offset :
				over > 0 ?
					myOffset + atOffset + offset :
					0;
            },
            top: function(position, data) {
                if (data.at[1] === center) {
                    return;
                }
                var win = $(window),
				over = data.collisionPosition.top + data.collisionHeight - win.height() - win.scrollTop(),
				myOffset = data.my[1] === "top" ?
					-data.elemHeight :
					data.my[1] === "bottom" ?
						data.elemHeight :
						0,
				atOffset = data.at[1] === "top" ?
					data.targetHeight :
					-data.targetHeight,
				offset = -2 * data.offset[1];
                position.top += data.collisionPosition.top < 0 ?
				myOffset + atOffset + offset :
				over > 0 ?
					myOffset + atOffset + offset :
					0;
            }
        }
    };

    // offset setter from jQuery 1.4
    if (!$.offset.setOffset) {
        $.offset.setOffset = function(elem, options) {
            // set position first, in-case top/left are set even on static elem
            if (/static/.test($.curCSS(elem, "position"))) {
                elem.style.position = "relative";
            }
            var curElem = $(elem),
			curOffset = curElem.offset(),
			curTop = parseInt($.curCSS(elem, "top", true), 10) || 0,
			curLeft = parseInt($.curCSS(elem, "left", true), 10) || 0,
			props = {
			    top: (options.top - curOffset.top) + curTop,
			    left: (options.left - curOffset.left) + curLeft
			};

            if ('using' in options) {
                options.using.call(elem, props);
            } else {
                curElem.css(props);
            }
        };

        $.fn.offset = function(options) {
            var elem = this[0];
            if (!elem || !elem.ownerDocument) { return null; }
            if (options) {
                return this.each(function() {
                    $.offset.setOffset(this, options);
                });
            }
            return _offset.call(this);
        };
    }

} (jQuery));



/*!
* jQuery UI Mouse 1.8.8
*
* Copyright 2010, AUTHORS.txt (http://jqueryui.com/about)
* Dual licensed under the MIT or GPL Version 2 licenses.
* http://jquery.org/license
*
* http://docs.jquery.com/UI/Mouse
*
* Depends:
*	jquery.ui.widget.js
*/
(function($, undefined) {

    $.widget("ui.mouse", {
        options: {
            cancel: ':input,option',
            distance: 1,
            delay: 0
        },
        _mouseInit: function() {
            var self = this;

            this.element
			.bind('mousedown.' + this.widgetName, function(event) {
			    return self._mouseDown(event);
			})
			.bind('click.' + this.widgetName, function(event) {
			    if (true === $.data(event.target, self.widgetName + '.preventClickEvent')) {
			        $.removeData(event.target, self.widgetName + '.preventClickEvent');
			        event.stopImmediatePropagation();
			        return false;
			    }
			});

            this.started = false;
        },

        // TODO: make sure destroying one instance of mouse doesn't mess with
        // other instances of mouse
        _mouseDestroy: function() {
            this.element.unbind('.' + this.widgetName);
        },

        _mouseDown: function(event) {
            // don't let more than one widget handle mouseStart
            // TODO: figure out why we have to use originalEvent
            event.originalEvent = event.originalEvent || {};
            if (event.originalEvent.mouseHandled) { return; }

            // we may have missed mouseup (out of window)
            (this._mouseStarted && this._mouseUp(event));

            this._mouseDownEvent = event;

            var self = this,
			btnIsLeft = (event.which == 1),
			elIsCancel = (typeof this.options.cancel == "string" ? $(event.target).parents().add(event.target).filter(this.options.cancel).length : false);
            if (!btnIsLeft || elIsCancel || !this._mouseCapture(event)) {
                return true;
            }

            this.mouseDelayMet = !this.options.delay;
            if (!this.mouseDelayMet) {
                this._mouseDelayTimer = setTimeout(function() {
                    self.mouseDelayMet = true;
                }, this.options.delay);
            }

            if (this._mouseDistanceMet(event) && this._mouseDelayMet(event)) {
                this._mouseStarted = (this._mouseStart(event) !== false);
                if (!this._mouseStarted) {
                    event.preventDefault();
                    return true;
                }
            }

            // these delegates are required to keep context
            this._mouseMoveDelegate = function(event) {
                return self._mouseMove(event);
            };
            this._mouseUpDelegate = function(event) {
                return self._mouseUp(event);
            };
            $(document)
			.bind('mousemove.' + this.widgetName, this._mouseMoveDelegate)
			.bind('mouseup.' + this.widgetName, this._mouseUpDelegate);

            event.preventDefault();
            event.originalEvent.mouseHandled = true;
            return true;
        },

        _mouseMove: function(event) {
            // IE mouseup check - mouseup happened when mouse was out of window
            if ($.browser.msie && !(document.documentMode >= 9) && !event.button) {
                return this._mouseUp(event);
            }

            if (this._mouseStarted) {
                this._mouseDrag(event);
                return event.preventDefault();
            }

            if (this._mouseDistanceMet(event) && this._mouseDelayMet(event)) {
                this._mouseStarted =
				(this._mouseStart(this._mouseDownEvent, event) !== false);
                (this._mouseStarted ? this._mouseDrag(event) : this._mouseUp(event));
            }

            return !this._mouseStarted;
        },

        _mouseUp: function(event) {
            $(document)
			.unbind('mousemove.' + this.widgetName, this._mouseMoveDelegate)
			.unbind('mouseup.' + this.widgetName, this._mouseUpDelegate);

            if (this._mouseStarted) {
                this._mouseStarted = false;

                if (event.target == this._mouseDownEvent.target) {
                    $.data(event.target, this.widgetName + '.preventClickEvent', true);
                }

                this._mouseStop(event);
            }

            return false;
        },

        _mouseDistanceMet: function(event) {
            return (Math.max(
				Math.abs(this._mouseDownEvent.pageX - event.pageX),
				Math.abs(this._mouseDownEvent.pageY - event.pageY)
			) >= this.options.distance
		);
        },

        _mouseDelayMet: function(event) {
            return this.mouseDelayMet;
        },

        // These are placeholder methods, to be overriden by extending plugin
        _mouseStart: function(event) { },
        _mouseDrag: function(event) { },
        _mouseStop: function(event) { },
        _mouseCapture: function(event) { return true; }
    });

})(jQuery);



/*
* jQuery UI Draggable 1.8.8
*
* Copyright 2010, AUTHORS.txt (http://jqueryui.com/about)
* Dual licensed under the MIT or GPL Version 2 licenses.
* http://jquery.org/license
*
* http://docs.jquery.com/UI/Draggables
*
* Depends:
*	jquery.ui.core.js
*	jquery.ui.mouse.js
*	jquery.ui.widget.js
*/
(function($, undefined) {

    $.widget("ui.draggable", $.ui.mouse, {
        widgetEventPrefix: "drag",
        options: {
            addClasses: true,
            appendTo: "parent",
            axis: false,
            connectToSortable: false,
            containment: false,
            cursor: "auto",
            cursorAt: false,
            grid: false,
            handle: false,
            helper: "original",
            iframeFix: false,
            opacity: false,
            refreshPositions: false,
            revert: false,
            revertDuration: 500,
            scope: "default",
            scroll: true,
            scrollSensitivity: 20,
            scrollSpeed: 20,
            snap: false,
            snapMode: "both",
            snapTolerance: 20,
            stack: false,
            zIndex: false
        },
        _create: function() {

            if (this.options.helper == 'original' && !(/^(?:r|a|f)/).test(this.element.css("position")))
                this.element[0].style.position = 'relative';

            (this.options.addClasses && this.element.addClass("ui-draggable"));
            (this.options.disabled && this.element.addClass("ui-draggable-disabled"));

            this._mouseInit();

        },

        destroy: function() {
            if (!this.element.data('draggable')) return;
            this.element
			.removeData("draggable")
			.unbind(".draggable")
			.removeClass("ui-draggable"
				+ " ui-draggable-dragging"
				+ " ui-draggable-disabled");
            this._mouseDestroy();

            return this;
        },

        _mouseCapture: function(event) {

            var o = this.options;

            // among others, prevent a drag on a resizable-handle
            if (this.helper || o.disabled || $(event.target).is('.ui-resizable-handle'))
                return false;

            //Quit if we're not on a valid handle
            this.handle = this._getHandle(event);
            if (!this.handle)
                return false;

            return true;

        },

        _mouseStart: function(event) {

            var o = this.options;

            //Create and append the visible helper
            this.helper = this._createHelper(event);

            //Cache the helper size
            this._cacheHelperProportions();

            //If ddmanager is used for droppables, set the global draggable
            if ($.ui.ddmanager)
                $.ui.ddmanager.current = this;

            /*
            * - Position generation -
            * This block generates everything position related - it's the core of draggables.
            */

            //Cache the margins of the original element
            this._cacheMargins();

            //Store the helper's css position
            this.cssPosition = this.helper.css("position");
            this.scrollParent = this.helper.scrollParent();

            //The element's absolute position on the page minus margins
            this.offset = this.positionAbs = this.element.offset();
            this.offset = {
                top: this.offset.top - this.margins.top,
                left: this.offset.left - this.margins.left
            };

            $.extend(this.offset, {
                click: { //Where the click happened, relative to the element
                    left: event.pageX - this.offset.left,
                    top: event.pageY - this.offset.top
                },
                parent: this._getParentOffset(),
                relative: this._getRelativeOffset() //This is a relative to absolute position minus the actual position calculation - only used for relative positioned helper
            });

            //Generate the original position
            this.originalPosition = this.position = this._generatePosition(event);
            this.originalPageX = event.pageX;
            this.originalPageY = event.pageY;

            //Adjust the mouse offset relative to the helper if 'cursorAt' is supplied
            (o.cursorAt && this._adjustOffsetFromHelper(o.cursorAt));

            //Set a containment if given in the options
            if (o.containment)
                this._setContainment();

            //Trigger event + callbacks
            if (this._trigger("start", event) === false) {
                this._clear();
                return false;
            }

            //Recache the helper size
            this._cacheHelperProportions();

            //Prepare the droppable offsets
            if ($.ui.ddmanager && !o.dropBehaviour)
                $.ui.ddmanager.prepareOffsets(this, event);

            this.helper.addClass("ui-draggable-dragging");
            this._mouseDrag(event, true); //Execute the drag once - this causes the helper not to be visible before getting its correct position
            return true;
        },

        _mouseDrag: function(event, noPropagation) {

            //Compute the helpers position
            this.position = this._generatePosition(event);
            this.positionAbs = this._convertPositionTo("absolute");

            //Call plugins and callbacks and use the resulting position if something is returned
            if (!noPropagation) {
                var ui = this._uiHash();
                if (this._trigger('drag', event, ui) === false) {
                    this._mouseUp({});
                    return false;
                }
                this.position = ui.position;
            }

            if (!this.options.axis || this.options.axis != "y") this.helper[0].style.left = this.position.left + 'px';
            if (!this.options.axis || this.options.axis != "x") this.helper[0].style.top = this.position.top + 'px';
            if ($.ui.ddmanager) $.ui.ddmanager.drag(this, event);

            return false;
        },

        _mouseStop: function(event) {

            //If we are using droppables, inform the manager about the drop
            var dropped = false;
            if ($.ui.ddmanager && !this.options.dropBehaviour)
                dropped = $.ui.ddmanager.drop(this, event);

            //if a drop comes from outside (a sortable)
            if (this.dropped) {
                dropped = this.dropped;
                this.dropped = false;
            }

            //if the original element is removed, don't bother to continue
            if (!this.element[0] || !this.element[0].parentNode)
                return false;

            if ((this.options.revert == "invalid" && !dropped) || (this.options.revert == "valid" && dropped) || this.options.revert === true || ($.isFunction(this.options.revert) && this.options.revert.call(this.element, dropped))) {
                var self = this;
                $(this.helper).animate(this.originalPosition, parseInt(this.options.revertDuration, 10), function() {
                    if (self._trigger("stop", event) !== false) {
                        self._clear();
                    }
                });
            } else {
                if (this._trigger("stop", event) !== false) {
                    this._clear();
                }
            }

            return false;
        },

        cancel: function() {

            if (this.helper.is(".ui-draggable-dragging")) {
                this._mouseUp({});
            } else {
                this._clear();
            }

            return this;

        },

        _getHandle: function(event) {

            var handle = !this.options.handle || !$(this.options.handle, this.element).length ? true : false;
            $(this.options.handle, this.element)
			.find("*")
			.andSelf()
			.each(function() {
			    if (this == event.target) handle = true;
			});

            return handle;

        },

        _createHelper: function(event) {

            var o = this.options;
            var helper = $.isFunction(o.helper) ? $(o.helper.apply(this.element[0], [event])) : (o.helper == 'clone' ? this.element.clone() : this.element);

            if (!helper.parents('body').length)
                helper.appendTo((o.appendTo == 'parent' ? this.element[0].parentNode : o.appendTo));

            if (helper[0] != this.element[0] && !(/(fixed|absolute)/).test(helper.css("position")))
                helper.css("position", "absolute");

            return helper;

        },

        _adjustOffsetFromHelper: function(obj) {
            if (typeof obj == 'string') {
                obj = obj.split(' ');
            }
            if ($.isArray(obj)) {
                obj = { left: +obj[0], top: +obj[1] || 0 };
            }
            if ('left' in obj) {
                this.offset.click.left = obj.left + this.margins.left;
            }
            if ('right' in obj) {
                this.offset.click.left = this.helperProportions.width - obj.right + this.margins.left;
            }
            if ('top' in obj) {
                this.offset.click.top = obj.top + this.margins.top;
            }
            if ('bottom' in obj) {
                this.offset.click.top = this.helperProportions.height - obj.bottom + this.margins.top;
            }
        },

        _getParentOffset: function() {

            //Get the offsetParent and cache its position
            this.offsetParent = this.helper.offsetParent();
            var po = this.offsetParent.offset();

            // This is a special case where we need to modify a offset calculated on start, since the following happened:
            // 1. The position of the helper is absolute, so it's position is calculated based on the next positioned parent
            // 2. The actual offset parent is a child of the scroll parent, and the scroll parent isn't the document, which means that
            //    the scroll is included in the initial calculation of the offset of the parent, and never recalculated upon drag
            if (this.cssPosition == 'absolute' && this.scrollParent[0] != document && $.ui.contains(this.scrollParent[0], this.offsetParent[0])) {
                po.left += this.scrollParent.scrollLeft();
                po.top += this.scrollParent.scrollTop();
            }

            if ((this.offsetParent[0] == document.body) //This needs to be actually done for all browsers, since pageX/pageY includes this information
		|| (this.offsetParent[0].tagName && this.offsetParent[0].tagName.toLowerCase() == 'html' && $.browser.msie)) //Ugly IE fix
                po = { top: 0, left: 0 };

            return {
                top: po.top + (parseInt(this.offsetParent.css("borderTopWidth"), 10) || 0),
                left: po.left + (parseInt(this.offsetParent.css("borderLeftWidth"), 10) || 0)
            };

        },

        _getRelativeOffset: function() {

            if (this.cssPosition == "relative") {
                var p = this.element.position();
                return {
                    top: p.top - (parseInt(this.helper.css("top"), 10) || 0) + this.scrollParent.scrollTop(),
                    left: p.left - (parseInt(this.helper.css("left"), 10) || 0) + this.scrollParent.scrollLeft()
                };
            } else {
                return { top: 0, left: 0 };
            }

        },

        _cacheMargins: function() {
            this.margins = {
                left: (parseInt(this.element.css("marginLeft"), 10) || 0),
                top: (parseInt(this.element.css("marginTop"), 10) || 0)
            };
        },

        _cacheHelperProportions: function() {
            this.helperProportions = {
                width: this.helper.outerWidth(),
                height: this.helper.outerHeight()
            };
        },

        _setContainment: function() {

            var o = this.options;
            if (o.containment == 'parent') o.containment = this.helper[0].parentNode;
            if (o.containment == 'document' || o.containment == 'window') this.containment = [
			(o.containment == 'document' ? 0 : $(window).scrollLeft()) - this.offset.relative.left - this.offset.parent.left,
			(o.containment == 'document' ? 0 : $(window).scrollTop()) - this.offset.relative.top - this.offset.parent.top,
			(o.containment == 'document' ? 0 : $(window).scrollLeft()) + $(o.containment == 'document' ? document : window).width() - this.helperProportions.width - this.margins.left,
			(o.containment == 'document' ? 0 : $(window).scrollTop()) + ($(o.containment == 'document' ? document : window).height() || document.body.parentNode.scrollHeight) - this.helperProportions.height - this.margins.top
		];

            if (!(/^(document|window|parent)$/).test(o.containment) && o.containment.constructor != Array) {
                var ce = $(o.containment)[0]; if (!ce) return;
                var co = $(o.containment).offset();
                var over = ($(ce).css("overflow") != 'hidden');

                this.containment = [
				co.left + (parseInt($(ce).css("borderLeftWidth"), 10) || 0) + (parseInt($(ce).css("paddingLeft"), 10) || 0) - this.margins.left,
				co.top + (parseInt($(ce).css("borderTopWidth"), 10) || 0) + (parseInt($(ce).css("paddingTop"), 10) || 0) - this.margins.top,
				co.left + (over ? Math.max(ce.scrollWidth, ce.offsetWidth) : ce.offsetWidth) - (parseInt($(ce).css("borderLeftWidth"), 10) || 0) - (parseInt($(ce).css("paddingRight"), 10) || 0) - this.helperProportions.width - this.margins.left,
				co.top + (over ? Math.max(ce.scrollHeight, ce.offsetHeight) : ce.offsetHeight) - (parseInt($(ce).css("borderTopWidth"), 10) || 0) - (parseInt($(ce).css("paddingBottom"), 10) || 0) - this.helperProportions.height - this.margins.top
			];
            } else if (o.containment.constructor == Array) {
                this.containment = o.containment;
            }

        },

        _convertPositionTo: function(d, pos) {

            if (!pos) pos = this.position;
            var mod = d == "absolute" ? 1 : -1;
            var o = this.options, scroll = this.cssPosition == 'absolute' && !(this.scrollParent[0] != document && $.ui.contains(this.scrollParent[0], this.offsetParent[0])) ? this.offsetParent : this.scrollParent, scrollIsRootNode = (/(html|body)/i).test(scroll[0].tagName);

            return {
                top: (
				pos.top																	// The absolute mouse position
				+ this.offset.relative.top * mod										// Only for relative positioned nodes: Relative offset from element to offset parent
				+ this.offset.parent.top * mod											// The offsetParent's offset without borders (offset + border)
				- ($.browser.safari && $.browser.version < 526 && this.cssPosition == 'fixed' ? 0 : (this.cssPosition == 'fixed' ? -this.scrollParent.scrollTop() : (scrollIsRootNode ? 0 : scroll.scrollTop())) * mod)
			),
                left: (
				pos.left																// The absolute mouse position
				+ this.offset.relative.left * mod										// Only for relative positioned nodes: Relative offset from element to offset parent
				+ this.offset.parent.left * mod											// The offsetParent's offset without borders (offset + border)
				- ($.browser.safari && $.browser.version < 526 && this.cssPosition == 'fixed' ? 0 : (this.cssPosition == 'fixed' ? -this.scrollParent.scrollLeft() : scrollIsRootNode ? 0 : scroll.scrollLeft()) * mod)
			)
            };

        },

        _generatePosition: function(event) {

            var o = this.options, scroll = this.cssPosition == 'absolute' && !(this.scrollParent[0] != document && $.ui.contains(this.scrollParent[0], this.offsetParent[0])) ? this.offsetParent : this.scrollParent, scrollIsRootNode = (/(html|body)/i).test(scroll[0].tagName);
            var pageX = event.pageX;
            var pageY = event.pageY;

            /*
            * - Position constraining -
            * Constrain the position to a mix of grid, containment.
            */

            if (this.originalPosition) { //If we are not dragging yet, we won't check for options

                if (this.containment) {
                    if (event.pageX - this.offset.click.left < this.containment[0]) pageX = this.containment[0] + this.offset.click.left;
                    if (event.pageY - this.offset.click.top < this.containment[1]) pageY = this.containment[1] + this.offset.click.top;
                    if (event.pageX - this.offset.click.left > this.containment[2]) pageX = this.containment[2] + this.offset.click.left;
                    if (event.pageY - this.offset.click.top > this.containment[3]) pageY = this.containment[3] + this.offset.click.top;
                }

                if (o.grid) {
                    var top = this.originalPageY + Math.round((pageY - this.originalPageY) / o.grid[1]) * o.grid[1];
                    pageY = this.containment ? (!(top - this.offset.click.top < this.containment[1] || top - this.offset.click.top > this.containment[3]) ? top : (!(top - this.offset.click.top < this.containment[1]) ? top - o.grid[1] : top + o.grid[1])) : top;

                    var left = this.originalPageX + Math.round((pageX - this.originalPageX) / o.grid[0]) * o.grid[0];
                    pageX = this.containment ? (!(left - this.offset.click.left < this.containment[0] || left - this.offset.click.left > this.containment[2]) ? left : (!(left - this.offset.click.left < this.containment[0]) ? left - o.grid[0] : left + o.grid[0])) : left;
                }

            }

            return {
                top: (
				pageY																// The absolute mouse position
				- this.offset.click.top													// Click offset (relative to the element)
				- this.offset.relative.top												// Only for relative positioned nodes: Relative offset from element to offset parent
				- this.offset.parent.top												// The offsetParent's offset without borders (offset + border)
				+ ($.browser.safari && $.browser.version < 526 && this.cssPosition == 'fixed' ? 0 : (this.cssPosition == 'fixed' ? -this.scrollParent.scrollTop() : (scrollIsRootNode ? 0 : scroll.scrollTop())))
			),
                left: (
				pageX																// The absolute mouse position
				- this.offset.click.left												// Click offset (relative to the element)
				- this.offset.relative.left												// Only for relative positioned nodes: Relative offset from element to offset parent
				- this.offset.parent.left												// The offsetParent's offset without borders (offset + border)
				+ ($.browser.safari && $.browser.version < 526 && this.cssPosition == 'fixed' ? 0 : (this.cssPosition == 'fixed' ? -this.scrollParent.scrollLeft() : scrollIsRootNode ? 0 : scroll.scrollLeft()))
			)
            };

        },

        _clear: function() {
            this.helper.removeClass("ui-draggable-dragging");
            if (this.helper[0] != this.element[0] && !this.cancelHelperRemoval) this.helper.remove();
            //if($.ui.ddmanager) $.ui.ddmanager.current = null;
            this.helper = null;
            this.cancelHelperRemoval = false;
        },

        // From now on bulk stuff - mainly helpers

        _trigger: function(type, event, ui) {
            ui = ui || this._uiHash();
            $.ui.plugin.call(this, type, [event, ui]);
            if (type == "drag") this.positionAbs = this._convertPositionTo("absolute"); //The absolute position has to be recalculated after plugins
            return $.Widget.prototype._trigger.call(this, type, event, ui);
        },

        plugins: {},

        _uiHash: function(event) {
            return {
                helper: this.helper,
                position: this.position,
                originalPosition: this.originalPosition,
                offset: this.positionAbs
            };
        }

    });

    $.extend($.ui.draggable, {
        version: "1.8.8"
    });

    $.ui.plugin.add("draggable", "connectToSortable", {
        start: function(event, ui) {

            var inst = $(this).data("draggable"), o = inst.options,
			uiSortable = $.extend({}, ui, { item: inst.element });
            inst.sortables = [];
            $(o.connectToSortable).each(function() {
                var sortable = $.data(this, 'sortable');
                if (sortable && !sortable.options.disabled) {
                    inst.sortables.push({
                        instance: sortable,
                        shouldRevert: sortable.options.revert
                    });
                    sortable._refreshItems(); //Do a one-time refresh at start to refresh the containerCache
                    sortable._trigger("activate", event, uiSortable);
                }
            });

        },
        stop: function(event, ui) {

            //If we are still over the sortable, we fake the stop event of the sortable, but also remove helper
            var inst = $(this).data("draggable"),
			uiSortable = $.extend({}, ui, { item: inst.element });

            $.each(inst.sortables, function() {
                if (this.instance.isOver) {

                    this.instance.isOver = 0;

                    inst.cancelHelperRemoval = true; //Don't remove the helper in the draggable instance
                    this.instance.cancelHelperRemoval = false; //Remove it in the sortable instance (so sortable plugins like revert still work)

                    //The sortable revert is supported, and we have to set a temporary dropped variable on the draggable to support revert: 'valid/invalid'
                    if (this.shouldRevert) this.instance.options.revert = true;

                    //Trigger the stop of the sortable
                    this.instance._mouseStop(event);

                    this.instance.options.helper = this.instance.options._helper;

                    //If the helper has been the original item, restore properties in the sortable
                    if (inst.options.helper == 'original')
                        this.instance.currentItem.css({ top: 'auto', left: 'auto' });

                } else {
                    this.instance.cancelHelperRemoval = false; //Remove the helper in the sortable instance
                    this.instance._trigger("deactivate", event, uiSortable);
                }

            });

        },
        drag: function(event, ui) {

            var inst = $(this).data("draggable"), self = this;

            var checkPos = function(o) {
                var dyClick = this.offset.click.top, dxClick = this.offset.click.left;
                var helperTop = this.positionAbs.top, helperLeft = this.positionAbs.left;
                var itemHeight = o.height, itemWidth = o.width;
                var itemTop = o.top, itemLeft = o.left;

                return $.ui.isOver(helperTop + dyClick, helperLeft + dxClick, itemTop, itemLeft, itemHeight, itemWidth);
            };

            $.each(inst.sortables, function(i) {

                //Copy over some variables to allow calling the sortable's native _intersectsWith
                this.instance.positionAbs = inst.positionAbs;
                this.instance.helperProportions = inst.helperProportions;
                this.instance.offset.click = inst.offset.click;

                if (this.instance._intersectsWith(this.instance.containerCache)) {

                    //If it intersects, we use a little isOver variable and set it once, so our move-in stuff gets fired only once
                    if (!this.instance.isOver) {

                        this.instance.isOver = 1;
                        //Now we fake the start of dragging for the sortable instance,
                        //by cloning the list group item, appending it to the sortable and using it as inst.currentItem
                        //We can then fire the start event of the sortable with our passed browser event, and our own helper (so it doesn't create a new one)
                        this.instance.currentItem = $(self).clone().appendTo(this.instance.element).data("sortable-item", true);
                        this.instance.options._helper = this.instance.options.helper; //Store helper option to later restore it
                        this.instance.options.helper = function() { return ui.helper[0]; };

                        event.target = this.instance.currentItem[0];
                        this.instance._mouseCapture(event, true);
                        this.instance._mouseStart(event, true, true);

                        //Because the browser event is way off the new appended portlet, we modify a couple of variables to reflect the changes
                        this.instance.offset.click.top = inst.offset.click.top;
                        this.instance.offset.click.left = inst.offset.click.left;
                        this.instance.offset.parent.left -= inst.offset.parent.left - this.instance.offset.parent.left;
                        this.instance.offset.parent.top -= inst.offset.parent.top - this.instance.offset.parent.top;

                        inst._trigger("toSortable", event);
                        inst.dropped = this.instance.element; //draggable revert needs that
                        //hack so receive/update callbacks work (mostly)
                        inst.currentItem = inst.element;
                        this.instance.fromOutside = inst;

                    }

                    //Provided we did all the previous steps, we can fire the drag event of the sortable on every draggable drag, when it intersects with the sortable
                    if (this.instance.currentItem) this.instance._mouseDrag(event);

                } else {

                    //If it doesn't intersect with the sortable, and it intersected before,
                    //we fake the drag stop of the sortable, but make sure it doesn't remove the helper by using cancelHelperRemoval
                    if (this.instance.isOver) {

                        this.instance.isOver = 0;
                        this.instance.cancelHelperRemoval = true;

                        //Prevent reverting on this forced stop
                        this.instance.options.revert = false;

                        // The out event needs to be triggered independently
                        this.instance._trigger('out', event, this.instance._uiHash(this.instance));

                        this.instance._mouseStop(event, true);
                        this.instance.options.helper = this.instance.options._helper;

                        //Now we remove our currentItem, the list group clone again, and the placeholder, and animate the helper back to it's original size
                        this.instance.currentItem.remove();
                        if (this.instance.placeholder) this.instance.placeholder.remove();

                        inst._trigger("fromSortable", event);
                        inst.dropped = false; //draggable revert needs that
                    }

                };

            });

        }
    });

    $.ui.plugin.add("draggable", "cursor", {
        start: function(event, ui) {
            var t = $('body'), o = $(this).data('draggable').options;
            if (t.css("cursor")) o._cursor = t.css("cursor");
            t.css("cursor", o.cursor);
        },
        stop: function(event, ui) {
            var o = $(this).data('draggable').options;
            if (o._cursor) $('body').css("cursor", o._cursor);
        }
    });

    $.ui.plugin.add("draggable", "iframeFix", {
        start: function(event, ui) {
            var o = $(this).data('draggable').options;
            $(o.iframeFix === true ? "iframe" : o.iframeFix).each(function() {
                $('<div class="ui-draggable-iframeFix" style="background: #fff;"></div>')
			.css({
			    width: this.offsetWidth + "px", height: this.offsetHeight + "px",
			    position: "absolute", opacity: "0.001", zIndex: 1000
			})
			.css($(this).offset())
			.appendTo("body");
            });
        },
        stop: function(event, ui) {
            $("div.ui-draggable-iframeFix").each(function() { this.parentNode.removeChild(this); }); //Remove frame helpers
        }
    });

    $.ui.plugin.add("draggable", "opacity", {
        start: function(event, ui) {
            var t = $(ui.helper), o = $(this).data('draggable').options;
            if (t.css("opacity")) o._opacity = t.css("opacity");
            t.css('opacity', o.opacity);
        },
        stop: function(event, ui) {
            var o = $(this).data('draggable').options;
            if (o._opacity) $(ui.helper).css('opacity', o._opacity);
        }
    });

    $.ui.plugin.add("draggable", "scroll", {
        start: function(event, ui) {
            var i = $(this).data("draggable");
            if (i.scrollParent[0] != document && i.scrollParent[0].tagName != 'HTML') i.overflowOffset = i.scrollParent.offset();
        },
        drag: function(event, ui) {

            var i = $(this).data("draggable"), o = i.options, scrolled = false;

            if (i.scrollParent[0] != document && i.scrollParent[0].tagName != 'HTML') {

                if (!o.axis || o.axis != 'x') {
                    if ((i.overflowOffset.top + i.scrollParent[0].offsetHeight) - event.pageY < o.scrollSensitivity)
                        i.scrollParent[0].scrollTop = scrolled = i.scrollParent[0].scrollTop + o.scrollSpeed;
                    else if (event.pageY - i.overflowOffset.top < o.scrollSensitivity)
                        i.scrollParent[0].scrollTop = scrolled = i.scrollParent[0].scrollTop - o.scrollSpeed;
                }

                if (!o.axis || o.axis != 'y') {
                    if ((i.overflowOffset.left + i.scrollParent[0].offsetWidth) - event.pageX < o.scrollSensitivity)
                        i.scrollParent[0].scrollLeft = scrolled = i.scrollParent[0].scrollLeft + o.scrollSpeed;
                    else if (event.pageX - i.overflowOffset.left < o.scrollSensitivity)
                        i.scrollParent[0].scrollLeft = scrolled = i.scrollParent[0].scrollLeft - o.scrollSpeed;
                }

            } else {

                if (!o.axis || o.axis != 'x') {
                    if (event.pageY - $(document).scrollTop() < o.scrollSensitivity)
                        scrolled = $(document).scrollTop($(document).scrollTop() - o.scrollSpeed);
                    else if ($(window).height() - (event.pageY - $(document).scrollTop()) < o.scrollSensitivity)
                        scrolled = $(document).scrollTop($(document).scrollTop() + o.scrollSpeed);
                }

                if (!o.axis || o.axis != 'y') {
                    if (event.pageX - $(document).scrollLeft() < o.scrollSensitivity)
                        scrolled = $(document).scrollLeft($(document).scrollLeft() - o.scrollSpeed);
                    else if ($(window).width() - (event.pageX - $(document).scrollLeft()) < o.scrollSensitivity)
                        scrolled = $(document).scrollLeft($(document).scrollLeft() + o.scrollSpeed);
                }

            }

            if (scrolled !== false && $.ui.ddmanager && !o.dropBehaviour)
                $.ui.ddmanager.prepareOffsets(i, event);

        }
    });

    $.ui.plugin.add("draggable", "snap", {
        start: function(event, ui) {

            var i = $(this).data("draggable"), o = i.options;
            i.snapElements = [];

            $(o.snap.constructor != String ? (o.snap.items || ':data(draggable)') : o.snap).each(function() {
                var $t = $(this); var $o = $t.offset();
                if (this != i.element[0]) i.snapElements.push({
                    item: this,
                    width: $t.outerWidth(), height: $t.outerHeight(),
                    top: $o.top, left: $o.left
                });
            });

        },
        drag: function(event, ui) {

            var inst = $(this).data("draggable"), o = inst.options;
            var d = o.snapTolerance;

            var x1 = ui.offset.left, x2 = x1 + inst.helperProportions.width,
			y1 = ui.offset.top, y2 = y1 + inst.helperProportions.height;

            for (var i = inst.snapElements.length - 1; i >= 0; i--) {

                var l = inst.snapElements[i].left, r = l + inst.snapElements[i].width,
				t = inst.snapElements[i].top, b = t + inst.snapElements[i].height;

                //Yes, I know, this is insane ;)
                if (!((l - d < x1 && x1 < r + d && t - d < y1 && y1 < b + d) || (l - d < x1 && x1 < r + d && t - d < y2 && y2 < b + d) || (l - d < x2 && x2 < r + d && t - d < y1 && y1 < b + d) || (l - d < x2 && x2 < r + d && t - d < y2 && y2 < b + d))) {
                    if (inst.snapElements[i].snapping) (inst.options.snap.release && inst.options.snap.release.call(inst.element, event, $.extend(inst._uiHash(), { snapItem: inst.snapElements[i].item })));
                    inst.snapElements[i].snapping = false;
                    continue;
                }

                if (o.snapMode != 'inner') {
                    var ts = Math.abs(t - y2) <= d;
                    var bs = Math.abs(b - y1) <= d;
                    var ls = Math.abs(l - x2) <= d;
                    var rs = Math.abs(r - x1) <= d;
                    if (ts) ui.position.top = inst._convertPositionTo("relative", { top: t - inst.helperProportions.height, left: 0 }).top - inst.margins.top;
                    if (bs) ui.position.top = inst._convertPositionTo("relative", { top: b, left: 0 }).top - inst.margins.top;
                    if (ls) ui.position.left = inst._convertPositionTo("relative", { top: 0, left: l - inst.helperProportions.width }).left - inst.margins.left;
                    if (rs) ui.position.left = inst._convertPositionTo("relative", { top: 0, left: r }).left - inst.margins.left;
                }

                var first = (ts || bs || ls || rs);

                if (o.snapMode != 'outer') {
                    var ts = Math.abs(t - y1) <= d;
                    var bs = Math.abs(b - y2) <= d;
                    var ls = Math.abs(l - x1) <= d;
                    var rs = Math.abs(r - x2) <= d;
                    if (ts) ui.position.top = inst._convertPositionTo("relative", { top: t, left: 0 }).top - inst.margins.top;
                    if (bs) ui.position.top = inst._convertPositionTo("relative", { top: b - inst.helperProportions.height, left: 0 }).top - inst.margins.top;
                    if (ls) ui.position.left = inst._convertPositionTo("relative", { top: 0, left: l }).left - inst.margins.left;
                    if (rs) ui.position.left = inst._convertPositionTo("relative", { top: 0, left: r - inst.helperProportions.width }).left - inst.margins.left;
                }

                if (!inst.snapElements[i].snapping && (ts || bs || ls || rs || first))
                    (inst.options.snap.snap && inst.options.snap.snap.call(inst.element, event, $.extend(inst._uiHash(), { snapItem: inst.snapElements[i].item })));
                inst.snapElements[i].snapping = (ts || bs || ls || rs || first);

            };

        }
    });

    $.ui.plugin.add("draggable", "stack", {
        start: function(event, ui) {

            var o = $(this).data("draggable").options;

            var group = $.makeArray($(o.stack)).sort(function(a, b) {
                return (parseInt($(a).css("zIndex"), 10) || 0) - (parseInt($(b).css("zIndex"), 10) || 0);
            });
            if (!group.length) { return; }

            var min = parseInt(group[0].style.zIndex) || 0;
            $(group).each(function(i) {
                this.style.zIndex = min + i;
            });

            this[0].style.zIndex = min + group.length;

        }
    });

    $.ui.plugin.add("draggable", "zIndex", {
        start: function(event, ui) {
            var t = $(ui.helper), o = $(this).data("draggable").options;
            if (t.css("zIndex")) o._zIndex = t.css("zIndex");
            t.css('zIndex', o.zIndex);
        },
        stop: function(event, ui) {
            var o = $(this).data("draggable").options;
            if (o._zIndex) $(ui.helper).css('zIndex', o._zIndex);
        }
    });

})(jQuery);



/*
* jQuery UI Button 1.8.8
*
* Copyright 2010, AUTHORS.txt (http://jqueryui.com/about)
* Dual licensed under the MIT or GPL Version 2 licenses.
* http://jquery.org/license
*
* http://docs.jquery.com/UI/Button
*
* Depends:
*	jquery.ui.core.js
*	jquery.ui.widget.js
*/
(function($, undefined) {

    var lastActive,
	baseClasses = "ui-button ui-widget ui-state-default ui-corner-all",
	stateClasses = "ui-state-hover ui-state-active ",
	typeClasses = "ui-button-icons-only ui-button-icon-only ui-button-text-icons ui-button-text-icon-primary ui-button-text-icon-secondary ui-button-text-only",
	formResetHandler = function(event) {
	    $(":ui-button", event.target.form).each(function() {
	        var inst = $(this).data("button");
	        setTimeout(function() {
	            inst.refresh();
	        }, 1);
	    });
	},
	radioGroup = function(radio) {
	    var name = radio.name,
			form = radio.form,
			radios = $([]);
	    if (name) {
	        if (form) {
	            radios = $(form).find("[name='" + name + "']");
	        } else {
	            radios = $("[name='" + name + "']", radio.ownerDocument)
					.filter(function() {
					    return !this.form;
					});
	        }
	    }
	    return radios;
	};

    $.widget("ui.button", {
        options: {
            disabled: null,
            text: true,
            label: null,
            icons: {
                primary: null,
                secondary: null
            }
        },
        _create: function() {
            this.element.closest("form")
			.unbind("reset.button")
			.bind("reset.button", formResetHandler);

            if (typeof this.options.disabled !== "boolean") {
                this.options.disabled = this.element.attr("disabled");
            }

            this._determineButtonType();
            this.hasTitle = !!this.buttonElement.attr("title");

            var self = this,
			options = this.options,
			toggleButton = this.type === "checkbox" || this.type === "radio",
			hoverClass = "ui-state-hover" + (!toggleButton ? " ui-state-active" : ""),
			focusClass = "ui-state-focus";

            if (options.label === null) {
                options.label = this.buttonElement.html();
            }

            if (this.element.is(":disabled")) {
                options.disabled = true;
            }

            this.buttonElement
			.addClass(baseClasses)
			.attr("role", "button")
			.bind("mouseenter.button", function() {
			    if (options.disabled) {
			        return;
			    }
			    $(this).addClass("ui-state-hover");
			    if (this === lastActive) {
			        $(this).addClass("ui-state-active");
			    }
			})
			.bind("mouseleave.button", function() {
			    if (options.disabled) {
			        return;
			    }
			    $(this).removeClass(hoverClass);
			})
			.bind("focus.button", function() {
			    // no need to check disabled, focus won't be triggered anyway
			    $(this).addClass(focusClass);
			})
			.bind("blur.button", function() {
			    $(this).removeClass(focusClass);
			});

            if (toggleButton) {
                this.element.bind("change.button", function() {
                    self.refresh();
                });
            }

            if (this.type === "checkbox") {
                this.buttonElement.bind("click.button", function() {
                    if (options.disabled) {
                        return false;
                    }
                    $(this).toggleClass("ui-state-active");
                    self.buttonElement.attr("aria-pressed", self.element[0].checked);
                });
            } else if (this.type === "radio") {
                this.buttonElement.bind("click.button", function() {
                    if (options.disabled) {
                        return false;
                    }
                    $(this).addClass("ui-state-active");
                    self.buttonElement.attr("aria-pressed", true);

                    var radio = self.element[0];
                    radioGroup(radio)
					.not(radio)
					.map(function() {
					    return $(this).button("widget")[0];
					})
					.removeClass("ui-state-active")
					.attr("aria-pressed", false);
                });
            } else {
                this.buttonElement
				.bind("mousedown.button", function() {
				    if (options.disabled) {
				        return false;
				    }
				    $(this).addClass("ui-state-active");
				    lastActive = this;
				    $(document).one("mouseup", function() {
				        lastActive = null;
				    });
				})
				.bind("mouseup.button", function() {
				    if (options.disabled) {
				        return false;
				    }
				    $(this).removeClass("ui-state-active");
				})
				.bind("keydown.button", function(event) {
				    if (options.disabled) {
				        return false;
				    }
				    if (event.keyCode == $.ui.keyCode.SPACE || event.keyCode == $.ui.keyCode.ENTER) {
				        $(this).addClass("ui-state-active");
				    }
				})
				.bind("keyup.button", function() {
				    $(this).removeClass("ui-state-active");
				});

                if (this.buttonElement.is("a")) {
                    this.buttonElement.keyup(function(event) {
                        if (event.keyCode === $.ui.keyCode.SPACE) {
                            // TODO pass through original event correctly (just as 2nd argument doesn't work)
                            $(this).click();
                        }
                    });
                }
            }

            // TODO: pull out $.Widget's handling for the disabled option into
            // $.Widget.prototype._setOptionDisabled so it's easy to proxy and can
            // be overridden by individual plugins
            this._setOption("disabled", options.disabled);
        },

        _determineButtonType: function() {

            if (this.element.is(":checkbox")) {
                this.type = "checkbox";
            } else {
                if (this.element.is(":radio")) {
                    this.type = "radio";
                } else {
                    if (this.element.is("input")) {
                        this.type = "input";
                    } else {
                        this.type = "button";
                    }
                }
            }

            if (this.type === "checkbox" || this.type === "radio") {
                // we don't search against the document in case the element
                // is disconnected from the DOM
                this.buttonElement = this.element.parents().last()
				.find("label[for=" + this.element.attr("id") + "]");
                this.element.addClass("ui-helper-hidden-accessible");

                var checked = this.element.is(":checked");
                if (checked) {
                    this.buttonElement.addClass("ui-state-active");
                }
                this.buttonElement.attr("aria-pressed", checked);
            } else {
                this.buttonElement = this.element;
            }
        },

        widget: function() {
            return this.buttonElement;
        },

        destroy: function() {
            this.element
			.removeClass("ui-helper-hidden-accessible");
            this.buttonElement
			.removeClass(baseClasses + " " + stateClasses + " " + typeClasses)
			.removeAttr("role")
			.removeAttr("aria-pressed")
			.html(this.buttonElement.find(".ui-button-text").html());

            if (!this.hasTitle) {
                this.buttonElement.removeAttr("title");
            }

            $.Widget.prototype.destroy.call(this);
        },

        _setOption: function(key, value) {
            $.Widget.prototype._setOption.apply(this, arguments);
            if (key === "disabled") {
                if (value) {
                    this.element.attr("disabled", true);
                } else {
                    this.element.removeAttr("disabled");
                }
            }
            this._resetButton();
        },

        refresh: function() {
            var isDisabled = this.element.is(":disabled");
            if (isDisabled !== this.options.disabled) {
                this._setOption("disabled", isDisabled);
            }
            if (this.type === "radio") {
                radioGroup(this.element[0]).each(function() {
                    if ($(this).is(":checked")) {
                        $(this).button("widget")
						.addClass("ui-state-active")
						.attr("aria-pressed", true);
                    } else {
                        $(this).button("widget")
						.removeClass("ui-state-active")
						.attr("aria-pressed", false);
                    }
                });
            } else if (this.type === "checkbox") {
                if (this.element.is(":checked")) {
                    this.buttonElement
					.addClass("ui-state-active")
					.attr("aria-pressed", true);
                } else {
                    this.buttonElement
					.removeClass("ui-state-active")
					.attr("aria-pressed", false);
                }
            }
        },

        _resetButton: function() {
            if (this.type === "input") {
                if (this.options.label) {
                    this.element.val(this.options.label);
                }
                return;
            }
            var buttonElement = this.buttonElement.removeClass(typeClasses),
			buttonText = $("<span></span>")
				.addClass("ui-button-text")
				.html(this.options.label)
				.appendTo(buttonElement.empty())
				.text(),
			icons = this.options.icons,
			multipleIcons = icons.primary && icons.secondary;
            if (icons.primary || icons.secondary) {
                buttonElement.addClass("ui-button-text-icon" +
				(multipleIcons ? "s" : (icons.primary ? "-primary" : "-secondary")));
                if (icons.primary) {
                    buttonElement.prepend("<span class='ui-button-icon-primary ui-icon " + icons.primary + "'></span>");
                }
                if (icons.secondary) {
                    buttonElement.append("<span class='ui-button-icon-secondary ui-icon " + icons.secondary + "'></span>");
                }
                if (!this.options.text) {
                    buttonElement
					.addClass(multipleIcons ? "ui-button-icons-only" : "ui-button-icon-only")
					.removeClass("ui-button-text-icons ui-button-text-icon-primary ui-button-text-icon-secondary");
                    if (!this.hasTitle) {
                        buttonElement.attr("title", buttonText);
                    }
                }
            } else {
                buttonElement.addClass("ui-button-text-only");
            }
        }
    });

    $.widget("ui.buttonset", {
        options: {
            items: ":button, :submit, :reset, :checkbox, :radio, a, :data(button)"
        },

        _create: function() {
            this.element.addClass("ui-buttonset");
        },

        _init: function() {
            this.refresh();
        },

        _setOption: function(key, value) {
            if (key === "disabled") {
                this.buttons.button("option", key, value);
            }

            $.Widget.prototype._setOption.apply(this, arguments);
        },

        refresh: function() {
            this.buttons = this.element.find(this.options.items)
			.filter(":ui-button")
				.button("refresh")
			.end()
			.not(":ui-button")
				.button()
			.end()
			.map(function() {
			    return $(this).button("widget")[0];
			})
				.removeClass("ui-corner-all ui-corner-left ui-corner-right")
				.filter(":first")
					.addClass("ui-corner-left")
				.end()
				.filter(":last")
					.addClass("ui-corner-right")
				.end()
			.end();
        },

        destroy: function() {
            this.element.removeClass("ui-buttonset");
            this.buttons
			.map(function() {
			    return $(this).button("widget")[0];
			})
				.removeClass("ui-corner-left ui-corner-right")
			.end()
			.button("destroy");

            $.Widget.prototype.destroy.call(this);
        }
    });

} (jQuery));



/*
* jQuery UI Resizable 1.8.8
*
* Copyright 2010, AUTHORS.txt (http://jqueryui.com/about)
* Dual licensed under the MIT or GPL Version 2 licenses.
* http://jquery.org/license
*
* http://docs.jquery.com/UI/Resizables
*
* Depends:
*	jquery.ui.core.js
*	jquery.ui.mouse.js
*	jquery.ui.widget.js
*/
(function($, undefined) {

    $.widget("ui.resizable", $.ui.mouse, {
        widgetEventPrefix: "resize",
        options: {
            alsoResize: false,
            animate: false,
            animateDuration: "slow",
            animateEasing: "swing",
            aspectRatio: false,
            autoHide: false,
            containment: false,
            ghost: false,
            grid: false,
            handles: "e,s,se",
            helper: false,
            maxHeight: null,
            maxWidth: null,
            minHeight: 10,
            minWidth: 10,
            zIndex: 1000
        },
        _create: function() {

            var self = this, o = this.options;
            this.element.addClass("ui-resizable");

            $.extend(this, {
                _aspectRatio: !!(o.aspectRatio),
                aspectRatio: o.aspectRatio,
                originalElement: this.element,
                _proportionallyResizeElements: [],
                _helper: o.helper || o.ghost || o.animate ? o.helper || 'ui-resizable-helper' : null
            });

            //Wrap the element if it cannot hold child nodes
            if (this.element[0].nodeName.match(/canvas|textarea|input|select|button|img/i)) {

                //Opera fix for relative positioning
                if (/relative/.test(this.element.css('position')) && $.browser.opera)
                    this.element.css({ position: 'relative', top: 'auto', left: 'auto' });

                //Create a wrapper element and set the wrapper to the new current internal element
                this.element.wrap(
				$('<div class="ui-wrapper" style="overflow: hidden;"></div>').css({
				    position: this.element.css('position'),
				    width: this.element.outerWidth(),
				    height: this.element.outerHeight(),
				    top: this.element.css('top'),
				    left: this.element.css('left')
				})
			);

                //Overwrite the original this.element
                this.element = this.element.parent().data(
				"resizable", this.element.data('resizable')
			);

                this.elementIsWrapper = true;

                //Move margins to the wrapper
                this.element.css({ marginLeft: this.originalElement.css("marginLeft"), marginTop: this.originalElement.css("marginTop"), marginRight: this.originalElement.css("marginRight"), marginBottom: this.originalElement.css("marginBottom") });
                this.originalElement.css({ marginLeft: 0, marginTop: 0, marginRight: 0, marginBottom: 0 });

                //Prevent Safari textarea resize
                this.originalResizeStyle = this.originalElement.css('resize');
                this.originalElement.css('resize', 'none');

                //Push the actual element to our proportionallyResize internal array
                this._proportionallyResizeElements.push(this.originalElement.css({ position: 'static', zoom: 1, display: 'block' }));

                // avoid IE jump (hard set the margin)
                this.originalElement.css({ margin: this.originalElement.css('margin') });

                // fix handlers offset
                this._proportionallyResize();

            }

            this.handles = o.handles || (!$('.ui-resizable-handle', this.element).length ? "e,s,se" : { n: '.ui-resizable-n', e: '.ui-resizable-e', s: '.ui-resizable-s', w: '.ui-resizable-w', se: '.ui-resizable-se', sw: '.ui-resizable-sw', ne: '.ui-resizable-ne', nw: '.ui-resizable-nw' });
            if (this.handles.constructor == String) {

                if (this.handles == 'all') this.handles = 'n,e,s,w,se,sw,ne,nw';
                var n = this.handles.split(","); this.handles = {};

                for (var i = 0; i < n.length; i++) {

                    var handle = $.trim(n[i]), hname = 'ui-resizable-' + handle;
                    var axis = $('<div class="ui-resizable-handle ' + hname + '"></div>');

                    // increase zIndex of sw, se, ne, nw axis
                    //TODO : this modifies original option
                    if (/sw|se|ne|nw/.test(handle)) axis.css({ zIndex: ++o.zIndex });

                    //TODO : What's going on here?
                    if ('se' == handle) {
                        axis.addClass('ui-icon ui-icon-gripsmall-diagonal-se');
                    };

                    //Insert into internal handles object and append to element
                    this.handles[handle] = '.ui-resizable-' + handle;
                    this.element.append(axis);
                }

            }

            this._renderAxis = function(target) {

                target = target || this.element;

                for (var i in this.handles) {

                    if (this.handles[i].constructor == String)
                        this.handles[i] = $(this.handles[i], this.element).show();

                    //Apply pad to wrapper element, needed to fix axis position (textarea, inputs, scrolls)
                    if (this.elementIsWrapper && this.originalElement[0].nodeName.match(/textarea|input|select|button/i)) {

                        var axis = $(this.handles[i], this.element), padWrapper = 0;

                        //Checking the correct pad and border
                        padWrapper = /sw|ne|nw|se|n|s/.test(i) ? axis.outerHeight() : axis.outerWidth();

                        //The padding type i have to apply...
                        var padPos = ['padding',
						/ne|nw|n/.test(i) ? 'Top' :
						/se|sw|s/.test(i) ? 'Bottom' :
						/^e$/.test(i) ? 'Right' : 'Left'].join("");

                        target.css(padPos, padWrapper);

                        this._proportionallyResize();

                    }

                    //TODO: What's that good for? There's not anything to be executed left
                    if (!$(this.handles[i]).length)
                        continue;

                }
            };

            //TODO: make renderAxis a prototype function
            this._renderAxis(this.element);

            this._handles = $('.ui-resizable-handle', this.element)
			.disableSelection();

            //Matching axis name
            this._handles.mouseover(function() {
                if (!self.resizing) {
                    if (this.className)
                        var axis = this.className.match(/ui-resizable-(se|sw|ne|nw|n|e|s|w)/i);
                    //Axis, default = se
                    self.axis = axis && axis[1] ? axis[1] : 'se';
                }
            });

            //If we want to auto hide the elements
            if (o.autoHide) {
                this._handles.hide();
                $(this.element)
				.addClass("ui-resizable-autohide")
				.hover(function() {
				    $(this).removeClass("ui-resizable-autohide");
				    self._handles.show();
				},
				function() {
				    if (!self.resizing) {
				        $(this).addClass("ui-resizable-autohide");
				        self._handles.hide();
				    }
				});
            }

            //Initialize the mouse interaction
            this._mouseInit();

        },

        destroy: function() {

            this._mouseDestroy();

            var _destroy = function(exp) {
                $(exp).removeClass("ui-resizable ui-resizable-disabled ui-resizable-resizing")
				.removeData("resizable").unbind(".resizable").find('.ui-resizable-handle').remove();
            };

            //TODO: Unwrap at same DOM position
            if (this.elementIsWrapper) {
                _destroy(this.element);
                var wrapper = this.element;
                wrapper.after(
				this.originalElement.css({
				    position: wrapper.css('position'),
				    width: wrapper.outerWidth(),
				    height: wrapper.outerHeight(),
				    top: wrapper.css('top'),
				    left: wrapper.css('left')
				})
			).remove();
            }

            this.originalElement.css('resize', this.originalResizeStyle);
            _destroy(this.originalElement);

            return this;
        },

        _mouseCapture: function(event) {
            var handle = false;
            for (var i in this.handles) {
                if ($(this.handles[i])[0] == event.target) {
                    handle = true;
                }
            }

            return !this.options.disabled && handle;
        },

        _mouseStart: function(event) {

            var o = this.options, iniPos = this.element.position(), el = this.element;

            this.resizing = true;
            this.documentScroll = { top: $(document).scrollTop(), left: $(document).scrollLeft() };

            // bugfix for http://dev.jquery.com/ticket/1749
            if (el.is('.ui-draggable') || (/absolute/).test(el.css('position'))) {
                el.css({ position: 'absolute', top: iniPos.top, left: iniPos.left });
            }

            //Opera fixing relative position
            if ($.browser.opera && (/relative/).test(el.css('position')))
                el.css({ position: 'relative', top: 'auto', left: 'auto' });

            this._renderProxy();

            var curleft = num(this.helper.css('left')), curtop = num(this.helper.css('top'));

            if (o.containment) {
                curleft += $(o.containment).scrollLeft() || 0;
                curtop += $(o.containment).scrollTop() || 0;
            }

            //Store needed variables
            this.offset = this.helper.offset();
            this.position = { left: curleft, top: curtop };
            this.size = this._helper ? { width: el.outerWidth(), height: el.outerHeight()} : { width: el.width(), height: el.height() };
            this.originalSize = this._helper ? { width: el.outerWidth(), height: el.outerHeight()} : { width: el.width(), height: el.height() };
            this.originalPosition = { left: curleft, top: curtop };
            this.sizeDiff = { width: el.outerWidth() - el.width(), height: el.outerHeight() - el.height() };
            this.originalMousePosition = { left: event.pageX, top: event.pageY };

            //Aspect Ratio
            this.aspectRatio = (typeof o.aspectRatio == 'number') ? o.aspectRatio : ((this.originalSize.width / this.originalSize.height) || 1);

            var cursor = $('.ui-resizable-' + this.axis).css('cursor');
            $('body').css('cursor', cursor == 'auto' ? this.axis + '-resize' : cursor);

            el.addClass("ui-resizable-resizing");
            this._propagate("start", event);
            return true;
        },

        _mouseDrag: function(event) {

            //Increase performance, avoid regex
            var el = this.helper, o = this.options, props = {},
			self = this, smp = this.originalMousePosition, a = this.axis;

            var dx = (event.pageX - smp.left) || 0, dy = (event.pageY - smp.top) || 0;
            var trigger = this._change[a];
            if (!trigger) return false;

            // Calculate the attrs that will be change
            var data = trigger.apply(this, [event, dx, dy]), ie6 = $.browser.msie && $.browser.version < 7, csdif = this.sizeDiff;

            if (this._aspectRatio || event.shiftKey)
                data = this._updateRatio(data, event);

            data = this._respectSize(data, event);

            // plugins callbacks need to be called first
            this._propagate("resize", event);

            el.css({
                top: this.position.top + "px", left: this.position.left + "px",
                width: this.size.width + "px", height: this.size.height + "px"
            });

            if (!this._helper && this._proportionallyResizeElements.length)
                this._proportionallyResize();

            this._updateCache(data);

            // calling the user callback at the end
            this._trigger('resize', event, this.ui());

            return false;
        },

        _mouseStop: function(event) {

            this.resizing = false;
            var o = this.options, self = this;

            if (this._helper) {
                var pr = this._proportionallyResizeElements, ista = pr.length && (/textarea/i).test(pr[0].nodeName),
						soffseth = ista && $.ui.hasScroll(pr[0], 'left') /* TODO - jump height */ ? 0 : self.sizeDiff.height,
							soffsetw = ista ? 0 : self.sizeDiff.width;

                var s = { width: (self.size.width - soffsetw), height: (self.size.height - soffseth) },
				left = (parseInt(self.element.css('left'), 10) + (self.position.left - self.originalPosition.left)) || null,
				top = (parseInt(self.element.css('top'), 10) + (self.position.top - self.originalPosition.top)) || null;

                if (!o.animate)
                    this.element.css($.extend(s, { top: top, left: left }));

                self.helper.height(self.size.height);
                self.helper.width(self.size.width);

                if (this._helper && !o.animate) this._proportionallyResize();
            }

            $('body').css('cursor', 'auto');

            this.element.removeClass("ui-resizable-resizing");

            this._propagate("stop", event);

            if (this._helper) this.helper.remove();
            return false;

        },

        _updateCache: function(data) {
            var o = this.options;
            this.offset = this.helper.offset();
            if (isNumber(data.left)) this.position.left = data.left;
            if (isNumber(data.top)) this.position.top = data.top;
            if (isNumber(data.height)) this.size.height = data.height;
            if (isNumber(data.width)) this.size.width = data.width;
        },

        _updateRatio: function(data, event) {

            var o = this.options, cpos = this.position, csize = this.size, a = this.axis;

            if (data.height) data.width = (csize.height * this.aspectRatio);
            else if (data.width) data.height = (csize.width / this.aspectRatio);

            if (a == 'sw') {
                data.left = cpos.left + (csize.width - data.width);
                data.top = null;
            }
            if (a == 'nw') {
                data.top = cpos.top + (csize.height - data.height);
                data.left = cpos.left + (csize.width - data.width);
            }

            return data;
        },

        _respectSize: function(data, event) {

            var el = this.helper, o = this.options, pRatio = this._aspectRatio || event.shiftKey, a = this.axis,
				ismaxw = isNumber(data.width) && o.maxWidth && (o.maxWidth < data.width), ismaxh = isNumber(data.height) && o.maxHeight && (o.maxHeight < data.height),
					isminw = isNumber(data.width) && o.minWidth && (o.minWidth > data.width), isminh = isNumber(data.height) && o.minHeight && (o.minHeight > data.height);

            if (isminw) data.width = o.minWidth;
            if (isminh) data.height = o.minHeight;
            if (ismaxw) data.width = o.maxWidth;
            if (ismaxh) data.height = o.maxHeight;

            var dw = this.originalPosition.left + this.originalSize.width, dh = this.position.top + this.size.height;
            var cw = /sw|nw|w/.test(a), ch = /nw|ne|n/.test(a);

            if (isminw && cw) data.left = dw - o.minWidth;
            if (ismaxw && cw) data.left = dw - o.maxWidth;
            if (isminh && ch) data.top = dh - o.minHeight;
            if (ismaxh && ch) data.top = dh - o.maxHeight;

            // fixing jump error on top/left - bug #2330
            var isNotwh = !data.width && !data.height;
            if (isNotwh && !data.left && data.top) data.top = null;
            else if (isNotwh && !data.top && data.left) data.left = null;

            return data;
        },

        _proportionallyResize: function() {

            var o = this.options;
            if (!this._proportionallyResizeElements.length) return;
            var element = this.helper || this.element;

            for (var i = 0; i < this._proportionallyResizeElements.length; i++) {

                var prel = this._proportionallyResizeElements[i];

                if (!this.borderDif) {
                    var b = [prel.css('borderTopWidth'), prel.css('borderRightWidth'), prel.css('borderBottomWidth'), prel.css('borderLeftWidth')],
					p = [prel.css('paddingTop'), prel.css('paddingRight'), prel.css('paddingBottom'), prel.css('paddingLeft')];

                    this.borderDif = $.map(b, function(v, i) {
                        var border = parseInt(v, 10) || 0, padding = parseInt(p[i], 10) || 0;
                        return border + padding;
                    });
                }

                if ($.browser.msie && !(!($(element).is(':hidden') || $(element).parents(':hidden').length)))
                    continue;

                prel.css({
                    height: (element.height() - this.borderDif[0] - this.borderDif[2]) || 0,
                    width: (element.width() - this.borderDif[1] - this.borderDif[3]) || 0
                });

            };

        },

        _renderProxy: function() {

            var el = this.element, o = this.options;
            this.elementOffset = el.offset();

            if (this._helper) {

                this.helper = this.helper || $('<div style="overflow:hidden;"></div>');

                // fix ie6 offset TODO: This seems broken
                var ie6 = $.browser.msie && $.browser.version < 7, ie6offset = (ie6 ? 1 : 0),
			pxyoffset = (ie6 ? 2 : -1);

                this.helper.addClass(this._helper).css({
                    width: this.element.outerWidth() + pxyoffset,
                    height: this.element.outerHeight() + pxyoffset,
                    position: 'absolute',
                    left: this.elementOffset.left - ie6offset + 'px',
                    top: this.elementOffset.top - ie6offset + 'px',
                    zIndex: ++o.zIndex //TODO: Don't modify option
                });

                this.helper
				.appendTo("body")
				.disableSelection();

            } else {
                this.helper = this.element;
            }

        },

        _change: {
            e: function(event, dx, dy) {
                return { width: this.originalSize.width + dx };
            },
            w: function(event, dx, dy) {
                var o = this.options, cs = this.originalSize, sp = this.originalPosition;
                return { left: sp.left + dx, width: cs.width - dx };
            },
            n: function(event, dx, dy) {
                var o = this.options, cs = this.originalSize, sp = this.originalPosition;
                return { top: sp.top + dy, height: cs.height - dy };
            },
            s: function(event, dx, dy) {
                return { height: this.originalSize.height + dy };
            },
            se: function(event, dx, dy) {
                return $.extend(this._change.s.apply(this, arguments), this._change.e.apply(this, [event, dx, dy]));
            },
            sw: function(event, dx, dy) {
                return $.extend(this._change.s.apply(this, arguments), this._change.w.apply(this, [event, dx, dy]));
            },
            ne: function(event, dx, dy) {
                return $.extend(this._change.n.apply(this, arguments), this._change.e.apply(this, [event, dx, dy]));
            },
            nw: function(event, dx, dy) {
                return $.extend(this._change.n.apply(this, arguments), this._change.w.apply(this, [event, dx, dy]));
            }
        },

        _propagate: function(n, event) {
            $.ui.plugin.call(this, n, [event, this.ui()]);
            (n != "resize" && this._trigger(n, event, this.ui()));
        },

        plugins: {},

        ui: function() {
            return {
                originalElement: this.originalElement,
                element: this.element,
                helper: this.helper,
                position: this.position,
                size: this.size,
                originalSize: this.originalSize,
                originalPosition: this.originalPosition
            };
        }

    });

    $.extend($.ui.resizable, {
        version: "1.8.8"
    });

    /*
    * Resizable Extensions
    */

    $.ui.plugin.add("resizable", "alsoResize", {

        start: function(event, ui) {
            var self = $(this).data("resizable"), o = self.options;

            var _store = function(exp) {
                $(exp).each(function() {
                    var el = $(this);
                    el.data("resizable-alsoresize", {
                        width: parseInt(el.width(), 10), height: parseInt(el.height(), 10),
                        left: parseInt(el.css('left'), 10), top: parseInt(el.css('top'), 10),
                        position: el.css('position') // to reset Opera on stop()
                    });
                });
            };

            if (typeof (o.alsoResize) == 'object' && !o.alsoResize.parentNode) {
                if (o.alsoResize.length) { o.alsoResize = o.alsoResize[0]; _store(o.alsoResize); }
                else { $.each(o.alsoResize, function(exp) { _store(exp); }); }
            } else {
                _store(o.alsoResize);
            }
        },

        resize: function(event, ui) {
            var self = $(this).data("resizable"), o = self.options, os = self.originalSize, op = self.originalPosition;

            var delta = {
                height: (self.size.height - os.height) || 0, width: (self.size.width - os.width) || 0,
                top: (self.position.top - op.top) || 0, left: (self.position.left - op.left) || 0
            },

		_alsoResize = function(exp, c) {
		    $(exp).each(function() {
		        var el = $(this), start = $(this).data("resizable-alsoresize"), style = {},
					css = c && c.length ? c : el.parents(ui.originalElement[0]).length ? ['width', 'height'] : ['width', 'height', 'top', 'left'];

		        $.each(css, function(i, prop) {
		            var sum = (start[prop] || 0) + (delta[prop] || 0);
		            if (sum && sum >= 0)
		                style[prop] = sum || null;
		        });

		        // Opera fixing relative position
		        if ($.browser.opera && /relative/.test(el.css('position'))) {
		            self._revertToRelativePosition = true;
		            el.css({ position: 'absolute', top: 'auto', left: 'auto' });
		        }

		        el.css(style);
		    });
		};

            if (typeof (o.alsoResize) == 'object' && !o.alsoResize.nodeType) {
                $.each(o.alsoResize, function(exp, c) { _alsoResize(exp, c); });
            } else {
                _alsoResize(o.alsoResize);
            }
        },

        stop: function(event, ui) {
            var self = $(this).data("resizable"), o = self.options;

            var _reset = function(exp) {
                $(exp).each(function() {
                    var el = $(this);
                    // reset position for Opera - no need to verify it was changed
                    el.css({ position: el.data("resizable-alsoresize").position });
                });
            };

            if (self._revertToRelativePosition) {
                self._revertToRelativePosition = false;
                if (typeof (o.alsoResize) == 'object' && !o.alsoResize.nodeType) {
                    $.each(o.alsoResize, function(exp) { _reset(exp); });
                } else {
                    _reset(o.alsoResize);
                }
            }

            $(this).removeData("resizable-alsoresize");
        }
    });

    $.ui.plugin.add("resizable", "animate", {

        stop: function(event, ui) {
            var self = $(this).data("resizable"), o = self.options;

            var pr = self._proportionallyResizeElements, ista = pr.length && (/textarea/i).test(pr[0].nodeName),
					soffseth = ista && $.ui.hasScroll(pr[0], 'left') /* TODO - jump height */ ? 0 : self.sizeDiff.height,
						soffsetw = ista ? 0 : self.sizeDiff.width;

            var style = { width: (self.size.width - soffsetw), height: (self.size.height - soffseth) },
					left = (parseInt(self.element.css('left'), 10) + (self.position.left - self.originalPosition.left)) || null,
						top = (parseInt(self.element.css('top'), 10) + (self.position.top - self.originalPosition.top)) || null;

            self.element.animate(
			$.extend(style, top && left ? { top: top, left: left} : {}), {
			    duration: o.animateDuration,
			    easing: o.animateEasing,
			    step: function() {

			        var data = {
			            width: parseInt(self.element.css('width'), 10),
			            height: parseInt(self.element.css('height'), 10),
			            top: parseInt(self.element.css('top'), 10),
			            left: parseInt(self.element.css('left'), 10)
			        };

			        if (pr && pr.length) $(pr[0]).css({ width: data.width, height: data.height });

			        // propagating resize, and updating values for each animation step
			        self._updateCache(data);
			        self._propagate("resize", event);

			    }
			}
		);
        }

    });

    $.ui.plugin.add("resizable", "containment", {

        start: function(event, ui) {
            var self = $(this).data("resizable"), o = self.options, el = self.element;
            var oc = o.containment, ce = (oc instanceof $) ? oc.get(0) : (/parent/.test(oc)) ? el.parent().get(0) : oc;
            if (!ce) return;

            self.containerElement = $(ce);

            if (/document/.test(oc) || oc == document) {
                self.containerOffset = { left: 0, top: 0 };
                self.containerPosition = { left: 0, top: 0 };

                self.parentData = {
                    element: $(document), left: 0, top: 0,
                    width: $(document).width(), height: $(document).height() || document.body.parentNode.scrollHeight
                };
            }

            // i'm a node, so compute top, left, right, bottom
            else {
                var element = $(ce), p = [];
                $(["Top", "Right", "Left", "Bottom"]).each(function(i, name) { p[i] = num(element.css("padding" + name)); });

                self.containerOffset = element.offset();
                self.containerPosition = element.position();
                self.containerSize = { height: (element.innerHeight() - p[3]), width: (element.innerWidth() - p[1]) };

                var co = self.containerOffset, ch = self.containerSize.height, cw = self.containerSize.width,
						width = ($.ui.hasScroll(ce, "left") ? ce.scrollWidth : cw), height = ($.ui.hasScroll(ce) ? ce.scrollHeight : ch);

                self.parentData = {
                    element: ce, left: co.left, top: co.top, width: width, height: height
                };
            }
        },

        resize: function(event, ui) {
            var self = $(this).data("resizable"), o = self.options,
				ps = self.containerSize, co = self.containerOffset, cs = self.size, cp = self.position,
				pRatio = self._aspectRatio || event.shiftKey, cop = { top: 0, left: 0 }, ce = self.containerElement;

            if (ce[0] != document && (/static/).test(ce.css('position'))) cop = co;

            if (cp.left < (self._helper ? co.left : 0)) {
                self.size.width = self.size.width + (self._helper ? (self.position.left - co.left) : (self.position.left - cop.left));
                if (pRatio) self.size.height = self.size.width / o.aspectRatio;
                self.position.left = o.helper ? co.left : 0;
            }

            if (cp.top < (self._helper ? co.top : 0)) {
                self.size.height = self.size.height + (self._helper ? (self.position.top - co.top) : self.position.top);
                if (pRatio) self.size.width = self.size.height * o.aspectRatio;
                self.position.top = self._helper ? co.top : 0;
            }

            self.offset.left = self.parentData.left + self.position.left;
            self.offset.top = self.parentData.top + self.position.top;

            var woset = Math.abs((self._helper ? self.offset.left - cop.left : (self.offset.left - cop.left)) + self.sizeDiff.width),
					hoset = Math.abs((self._helper ? self.offset.top - cop.top : (self.offset.top - co.top)) + self.sizeDiff.height);

            var isParent = self.containerElement.get(0) == self.element.parent().get(0),
		    isOffsetRelative = /relative|absolute/.test(self.containerElement.css('position'));

            if (isParent && isOffsetRelative) woset -= self.parentData.left;

            if (woset + self.size.width >= self.parentData.width) {
                self.size.width = self.parentData.width - woset;
                if (pRatio) self.size.height = self.size.width / self.aspectRatio;
            }

            if (hoset + self.size.height >= self.parentData.height) {
                self.size.height = self.parentData.height - hoset;
                if (pRatio) self.size.width = self.size.height * self.aspectRatio;
            }
        },

        stop: function(event, ui) {
            var self = $(this).data("resizable"), o = self.options, cp = self.position,
				co = self.containerOffset, cop = self.containerPosition, ce = self.containerElement;

            var helper = $(self.helper), ho = helper.offset(), w = helper.outerWidth() - self.sizeDiff.width, h = helper.outerHeight() - self.sizeDiff.height;

            if (self._helper && !o.animate && (/relative/).test(ce.css('position')))
                $(this).css({ left: ho.left - cop.left - co.left, width: w, height: h });

            if (self._helper && !o.animate && (/static/).test(ce.css('position')))
                $(this).css({ left: ho.left - cop.left - co.left, width: w, height: h });

        }
    });

    $.ui.plugin.add("resizable", "ghost", {

        start: function(event, ui) {

            var self = $(this).data("resizable"), o = self.options, cs = self.size;

            self.ghost = self.originalElement.clone();
            self.ghost
			.css({ opacity: .25, display: 'block', position: 'relative', height: cs.height, width: cs.width, margin: 0, left: 0, top: 0 })
			.addClass('ui-resizable-ghost')
			.addClass(typeof o.ghost == 'string' ? o.ghost : '');

            self.ghost.appendTo(self.helper);

        },

        resize: function(event, ui) {
            var self = $(this).data("resizable"), o = self.options;
            if (self.ghost) self.ghost.css({ position: 'relative', height: self.size.height, width: self.size.width });
        },

        stop: function(event, ui) {
            var self = $(this).data("resizable"), o = self.options;
            if (self.ghost && self.helper) self.helper.get(0).removeChild(self.ghost.get(0));
        }

    });

    $.ui.plugin.add("resizable", "grid", {

        resize: function(event, ui) {
            var self = $(this).data("resizable"), o = self.options, cs = self.size, os = self.originalSize, op = self.originalPosition, a = self.axis, ratio = o._aspectRatio || event.shiftKey;
            o.grid = typeof o.grid == "number" ? [o.grid, o.grid] : o.grid;
            var ox = Math.round((cs.width - os.width) / (o.grid[0] || 1)) * (o.grid[0] || 1), oy = Math.round((cs.height - os.height) / (o.grid[1] || 1)) * (o.grid[1] || 1);

            if (/^(se|s|e)$/.test(a)) {
                self.size.width = os.width + ox;
                self.size.height = os.height + oy;
            }
            else if (/^(ne)$/.test(a)) {
                self.size.width = os.width + ox;
                self.size.height = os.height + oy;
                self.position.top = op.top - oy;
            }
            else if (/^(sw)$/.test(a)) {
                self.size.width = os.width + ox;
                self.size.height = os.height + oy;
                self.position.left = op.left - ox;
            }
            else {
                self.size.width = os.width + ox;
                self.size.height = os.height + oy;
                self.position.top = op.top - oy;
                self.position.left = op.left - ox;
            }
        }

    });

    var num = function(v) {
        return parseInt(v, 10) || 0;
    };

    var isNumber = function(value) {
        return !isNaN(parseInt(value, 10));
    };

})(jQuery);



/*
* jQuery UI Dialog 1.8.8
*
* Copyright 2010, AUTHORS.txt (http://jqueryui.com/about)
* Dual licensed under the MIT or GPL Version 2 licenses.
* http://jquery.org/license
*
* http://docs.jquery.com/UI/Dialog
*
* Depends:
*	jquery.ui.core.js
*	jquery.ui.widget.js
*  jquery.ui.button.js
*	jquery.ui.draggable.js
*	jquery.ui.mouse.js
*	jquery.ui.position.js
*	jquery.ui.resizable.js
*/
(function($, undefined) {

    var uiDialogClasses =
		'ui-dialog ' +
		'ui-widget ' +
		'ui-widget-content ' +
		'ui-corner-all ',
	sizeRelatedOptions = {
	    buttons: true,
	    height: true,
	    maxHeight: true,
	    maxWidth: true,
	    minHeight: true,
	    minWidth: true,
	    width: true
	},
	resizableRelatedOptions = {
	    maxHeight: true,
	    maxWidth: true,
	    minHeight: true,
	    minWidth: true
	};

    $.widget("ui.dialog", {
        options: {
            autoOpen: true,
            buttons: {},
            closeOnEscape: true,
            closeText: 'close',
            dialogClass: '',
            draggable: true,
            hide: null,
            height: 'auto',
            maxHeight: false,
            maxWidth: false,
            minHeight: 150,
            minWidth: 150,
            modal: false,
            position: {
                my: 'center',
                at: 'center',
                collision: 'fit',
                // ensure that the titlebar is never outside the document
                using: function(pos) {
                    var topOffset = $(this).css(pos).offset().top;
                    if (topOffset < 0) {
                        $(this).css('top', pos.top - topOffset);
                    }
                }
            },
            resizable: true,
            show: null,
            stack: true,
            title: '',
            width: 300,
            zIndex: 1000
        },

        _create: function() {
            this.originalTitle = this.element.attr('title');
            // #5742 - .attr() might return a DOMElement
            if (typeof this.originalTitle !== "string") {
                this.originalTitle = "";
            }

            this.options.title = this.options.title || this.originalTitle;
            var self = this,
			options = self.options,

			title = options.title || '&#160;',
			titleId = $.ui.dialog.getTitleId(self.element),

			uiDialog = (self.uiDialog = $('<div></div>'))
				.appendTo(document.body)
				.hide()
				.addClass(uiDialogClasses + options.dialogClass)
				.css({
				    zIndex: options.zIndex
				})
            // setting tabIndex makes the div focusable
            // setting outline to 0 prevents a border on focus in Mozilla
				.attr('tabIndex', -1).css('outline', 0).keydown(function(event) {
				    if (options.closeOnEscape && event.keyCode &&
						event.keyCode === $.ui.keyCode.ESCAPE) {

				        self.close(event);
				        event.preventDefault();
				    }
				})
				.attr({
				    role: 'dialog',
				    'aria-labelledby': titleId
				})
				.mousedown(function(event) {
				    self.moveToTop(false, event);
				}),

			uiDialogContent = self.element
				.show()
				.removeAttr('title')
				.addClass(
					'ui-dialog-content ' +
					'ui-widget-content')
				.appendTo(uiDialog),

			uiDialogTitlebar = (self.uiDialogTitlebar = $('<div></div>'))
				.addClass(
					'ui-dialog-titlebar ' +
					'ui-widget-header ' +
					'ui-corner-all ' +
					'ui-helper-clearfix'
				)
				.prependTo(uiDialog),

			uiDialogTitlebarClose = $('<a href="#"></a>')
				.addClass(
					'ui-dialog-titlebar-close ' +
					'ui-corner-all'
				)
				.attr('role', 'button')
				.hover(
					function() {
					    uiDialogTitlebarClose.addClass('ui-state-hover');
					},
					function() {
					    uiDialogTitlebarClose.removeClass('ui-state-hover');
					}
				)
				.focus(function() {
				    uiDialogTitlebarClose.addClass('ui-state-focus');
				})
				.blur(function() {
				    uiDialogTitlebarClose.removeClass('ui-state-focus');
				})
				.click(function(event) {
				    self.close(event);
				    return false;
				})
				.appendTo(uiDialogTitlebar),

			uiDialogTitlebarCloseText = (self.uiDialogTitlebarCloseText = $('<span></span>'))
				.addClass(
					'ui-icon ' +
					'ui-icon-closethick'
				)
				.text(options.closeText)
				.appendTo(uiDialogTitlebarClose),

			uiDialogTitle = $('<span></span>')
				.addClass('ui-dialog-title')
				.attr('id', titleId)
				.html(title)
				.prependTo(uiDialogTitlebar);

            //handling of deprecated beforeclose (vs beforeClose) option
            //Ticket #4669 http://dev.jqueryui.com/ticket/4669
            //TODO: remove in 1.9pre
            if ($.isFunction(options.beforeclose) && !$.isFunction(options.beforeClose)) {
                options.beforeClose = options.beforeclose;
            }

            uiDialogTitlebar.find("*").add(uiDialogTitlebar).disableSelection();

            if (options.draggable && $.fn.draggable) {
                self._makeDraggable();
            }
            if (options.resizable && $.fn.resizable) {
                self._makeResizable();
            }

            self._createButtons(options.buttons);
            self._isOpen = false;

            if ($.fn.bgiframe) {
                uiDialog.bgiframe();
            }
        },

        _init: function() {
            if (this.options.autoOpen) {
                this.open();
            }
        },

        destroy: function() {
            var self = this;

            if (self.overlay) {
                self.overlay.destroy();
            }
            self.uiDialog.hide();
            self.element
			.unbind('.dialog')
			.removeData('dialog')
			.removeClass('ui-dialog-content ui-widget-content')
			.hide().appendTo('body');
            self.uiDialog.remove();

            if (self.originalTitle) {
                self.element.attr('title', self.originalTitle);
            }

            return self;
        },

        widget: function() {
            return this.uiDialog;
        },

        close: function(event) {
            var self = this,
			maxZ, thisZ;

            if (false === self._trigger('beforeClose', event)) {
                return;
            }

            if (self.overlay) {
                self.overlay.destroy();
            }
            self.uiDialog.unbind('keypress.ui-dialog');

            self._isOpen = false;

            if (self.options.hide) {
                self.uiDialog.hide(self.options.hide, function() {
                    self._trigger('close', event);
                });
            } else {
                self.uiDialog.hide();
                self._trigger('close', event);
            }

            $.ui.dialog.overlay.resize();

            // adjust the maxZ to allow other modal dialogs to continue to work (see #4309)
            if (self.options.modal) {
                maxZ = 0;
                $('.ui-dialog').each(function() {
                    if (this !== self.uiDialog[0]) {
                        thisZ = $(this).css('z-index');
                        if (!isNaN(thisZ)) {
                            maxZ = Math.max(maxZ, thisZ);
                        }
                    }
                });
                $.ui.dialog.maxZ = maxZ;
            }

            return self;
        },

        isOpen: function() {
            return this._isOpen;
        },

        // the force parameter allows us to move modal dialogs to their correct
        // position on open
        moveToTop: function(force, event) {
            var self = this,
			options = self.options,
			saveScroll;

            if ((options.modal && !force) ||
			(!options.stack && !options.modal)) {
                return self._trigger('focus', event);
            }

            if (options.zIndex > $.ui.dialog.maxZ) {
                $.ui.dialog.maxZ = options.zIndex;
            }
            if (self.overlay) {
                $.ui.dialog.maxZ += 1;
                self.overlay.$el.css('z-index', $.ui.dialog.overlay.maxZ = $.ui.dialog.maxZ);
            }

            //Save and then restore scroll since Opera 9.5+ resets when parent z-Index is changed.
            //  http://ui.jquery.com/bugs/ticket/3193
            saveScroll = { scrollTop: self.element.attr('scrollTop'), scrollLeft: self.element.attr('scrollLeft') };
            $.ui.dialog.maxZ += 1;
            self.uiDialog.css('z-index', $.ui.dialog.maxZ);
            self.element.attr(saveScroll);
            self._trigger('focus', event);

            return self;
        },

        open: function() {
            if (this._isOpen) { return; }

            var self = this,
			options = self.options,
			uiDialog = self.uiDialog;

            self.overlay = options.modal ? new $.ui.dialog.overlay(self) : null;
            self._size();
            self._position(options.position);
            uiDialog.show(options.show);
            self.moveToTop(true);

            // prevent tabbing out of modal dialogs
            if (options.modal) {
                uiDialog.bind('keypress.ui-dialog', function(event) {
                    if (event.keyCode !== $.ui.keyCode.TAB) {
                        return;
                    }

                    var tabbables = $(':tabbable', this),
					first = tabbables.filter(':first'),
					last = tabbables.filter(':last');

                    if (event.target === last[0] && !event.shiftKey) {
                        first.focus(1);
                        return false;
                    } else if (event.target === first[0] && event.shiftKey) {
                        last.focus(1);
                        return false;
                    }
                });
            }

            // set focus to the first tabbable element in the content area or the first button
            // if there are no tabbable elements, set focus on the dialog itself
            $(self.element.find(':tabbable').get().concat(
			uiDialog.find('.ui-dialog-buttonpane :tabbable').get().concat(
				uiDialog.get()))).eq(0).focus();

            self._isOpen = true;
            self._trigger('open');

            return self;
        },

        _createButtons: function(buttons) {
            var self = this,
			hasButtons = false,
			uiDialogButtonPane = $('<div></div>')
				.addClass(
					'ui-dialog-buttonpane ' +
					'ui-widget-content ' +
					'ui-helper-clearfix'
				),
			uiButtonSet = $("<div></div>")
				.addClass("ui-dialog-buttonset")
				.appendTo(uiDialogButtonPane);

            // if we already have a button pane, remove it
            self.uiDialog.find('.ui-dialog-buttonpane').remove();

            if (typeof buttons === 'object' && buttons !== null) {
                $.each(buttons, function() {
                    return !(hasButtons = true);
                });
            }
            if (hasButtons) {
                $.each(buttons, function(name, props) {
                    props = $.isFunction(props) ?
					{ click: props, text: name} :
					props;
                    var button = $('<button type="button"></button>')
					.attr(props, true)
					.unbind('click')
					.click(function() {
					    props.click.apply(self.element[0], arguments);
					})
					.appendTo(uiButtonSet);
                    if ($.fn.button) {
                        button.button();
                    }
                });
                uiDialogButtonPane.appendTo(self.uiDialog);
            }
        },

        _makeDraggable: function() {
            var self = this,
			options = self.options,
			doc = $(document),
			heightBeforeDrag;

            function filteredUi(ui) {
                return {
                    position: ui.position,
                    offset: ui.offset
                };
            }

            self.uiDialog.draggable({
                cancel: '.ui-dialog-content, .ui-dialog-titlebar-close',
                handle: '.ui-dialog-titlebar',
                containment: 'document',
                start: function(event, ui) {
                    heightBeforeDrag = options.height === "auto" ? "auto" : $(this).height();
                    $(this).height($(this).height()).addClass("ui-dialog-dragging");
                    self._trigger('dragStart', event, filteredUi(ui));
                },
                drag: function(event, ui) {
                    self._trigger('drag', event, filteredUi(ui));
                },
                stop: function(event, ui) {
                    options.position = [ui.position.left - doc.scrollLeft(),
					ui.position.top - doc.scrollTop()];
                    $(this).removeClass("ui-dialog-dragging").height(heightBeforeDrag);
                    self._trigger('dragStop', event, filteredUi(ui));
                    $.ui.dialog.overlay.resize();
                }
            });
        },

        _makeResizable: function(handles) {
            handles = (handles === undefined ? this.options.resizable : handles);
            var self = this,
			options = self.options,
            // .ui-resizable has position: relative defined in the stylesheet
            // but dialogs have to use absolute or fixed positioning
			position = self.uiDialog.css('position'),
			resizeHandles = (typeof handles === 'string' ?
				handles :
				'n,e,s,w,se,sw,ne,nw'
			);

            function filteredUi(ui) {
                return {
                    originalPosition: ui.originalPosition,
                    originalSize: ui.originalSize,
                    position: ui.position,
                    size: ui.size
                };
            }

            self.uiDialog.resizable({
                cancel: '.ui-dialog-content',
                containment: 'document',
                alsoResize: self.element,
                maxWidth: options.maxWidth,
                maxHeight: options.maxHeight,
                minWidth: options.minWidth,
                minHeight: self._minHeight(),
                handles: resizeHandles,
                start: function(event, ui) {
                    $(this).addClass("ui-dialog-resizing");
                    self._trigger('resizeStart', event, filteredUi(ui));
                },
                resize: function(event, ui) {
                    self._trigger('resize', event, filteredUi(ui));
                },
                stop: function(event, ui) {
                    $(this).removeClass("ui-dialog-resizing");
                    options.height = $(this).height();
                    options.width = $(this).width();
                    self._trigger('resizeStop', event, filteredUi(ui));
                    $.ui.dialog.overlay.resize();
                }
            })
		.css('position', position)
		.find('.ui-resizable-se').addClass('ui-icon ui-icon-grip-diagonal-se');
        },

        _minHeight: function() {
            var options = this.options;

            if (options.height === 'auto') {
                return options.minHeight;
            } else {
                return Math.min(options.minHeight, options.height);
            }
        },

        _position: function(position) {
            var myAt = [],
			offset = [0, 0],
			isVisible;

            if (position) {
                // deep extending converts arrays to objects in jQuery <= 1.3.2 :-(
                //		if (typeof position == 'string' || $.isArray(position)) {
                //			myAt = $.isArray(position) ? position : position.split(' ');

                if (typeof position === 'string' || (typeof position === 'object' && '0' in position)) {
                    myAt = position.split ? position.split(' ') : [position[0], position[1]];
                    if (myAt.length === 1) {
                        myAt[1] = myAt[0];
                    }

                    $.each(['left', 'top'], function(i, offsetPosition) {
                        if (+myAt[i] === myAt[i]) {
                            offset[i] = myAt[i];
                            myAt[i] = offsetPosition;
                        }
                    });

                    position = {
                        my: myAt.join(" "),
                        at: myAt.join(" "),
                        offset: offset.join(" ")
                    };
                }

                position = $.extend({}, $.ui.dialog.prototype.options.position, position);
            } else {
                position = $.ui.dialog.prototype.options.position;
            }

            // need to show the dialog to get the actual offset in the position plugin
            isVisible = this.uiDialog.is(':visible');
            if (!isVisible) {
                this.uiDialog.show();
            }
            this.uiDialog
            // workaround for jQuery bug #5781 http://dev.jquery.com/ticket/5781
			.css({ top: 0, left: 0 })
			.position($.extend({ of: window }, position));
            if (!isVisible) {
                this.uiDialog.hide();
            }
        },

        _setOptions: function(options) {
            var self = this,
			resizableOptions = {},
			resize = false;

            $.each(options, function(key, value) {
                self._setOption(key, value);

                if (key in sizeRelatedOptions) {
                    resize = true;
                }
                if (key in resizableRelatedOptions) {
                    resizableOptions[key] = value;
                }
            });

            if (resize) {
                this._size();
            }
            if (this.uiDialog.is(":data(resizable)")) {
                this.uiDialog.resizable("option", resizableOptions);
            }
        },

        _setOption: function(key, value) {
            var self = this,
			uiDialog = self.uiDialog;

            switch (key) {
                //handling of deprecated beforeclose (vs beforeClose) option  
                //Ticket #4669 http://dev.jqueryui.com/ticket/4669  
                //TODO: remove in 1.9pre  
                case "beforeclose":
                    key = "beforeClose";
                    break;
                case "buttons":
                    self._createButtons(value);
                    break;
                case "closeText":
                    // ensure that we always pass a string
                    self.uiDialogTitlebarCloseText.text("" + value);
                    break;
                case "dialogClass":
                    uiDialog
					.removeClass(self.options.dialogClass)
					.addClass(uiDialogClasses + value);
                    break;
                case "disabled":
                    if (value) {
                        uiDialog.addClass('ui-dialog-disabled');
                    } else {
                        uiDialog.removeClass('ui-dialog-disabled');
                    }
                    break;
                case "draggable":
                    var isDraggable = uiDialog.is(":data(draggable)");
                    if (isDraggable && !value) {
                        uiDialog.draggable("destroy");
                    }

                    if (!isDraggable && value) {
                        self._makeDraggable();
                    }
                    break;
                case "position":
                    self._position(value);
                    break;
                case "resizable":
                    // currently resizable, becoming non-resizable
                    var isResizable = uiDialog.is(":data(resizable)");
                    if (isResizable && !value) {
                        uiDialog.resizable('destroy');
                    }

                    // currently resizable, changing handles
                    if (isResizable && typeof value === 'string') {
                        uiDialog.resizable('option', 'handles', value);
                    }

                    // currently non-resizable, becoming resizable
                    if (!isResizable && value !== false) {
                        self._makeResizable(value);
                    }
                    break;
                case "title":
                    // convert whatever was passed in o a string, for html() to not throw up
                    $(".ui-dialog-title", self.uiDialogTitlebar).html("" + (value || '&#160;'));
                    break;
            }

            $.Widget.prototype._setOption.apply(self, arguments);
        },

        _size: function() {
            /* If the user has resized the dialog, the .ui-dialog and .ui-dialog-content
            * divs will both have width and height set, so we need to reset them
            */
            var options = this.options,
			nonContentHeight,
			minContentHeight,
			isVisible = this.uiDialog.is(":visible");

            // reset content sizing
            this.element.show().css({
                width: 'auto',
                minHeight: 0,
                height: 0
            });

            if (options.minWidth > options.width) {
                options.width = options.minWidth;
            }

            // reset wrapper sizing
            // determine the height of all the non-content elements
            nonContentHeight = this.uiDialog.css({
                height: 'auto',
                width: options.width
            })
			.height();
            minContentHeight = Math.max(0, options.minHeight - nonContentHeight);

            if (options.height === "auto") {
                // only needed for IE6 support
                if ($.support.minHeight) {
                    this.element.css({
                        minHeight: minContentHeight,
                        height: "auto"
                    });
                } else {
                    this.uiDialog.show();
                    var autoHeight = this.element.css("height", "auto").height();
                    if (!isVisible) {
                        this.uiDialog.hide();
                    }
                    this.element.height(Math.max(autoHeight, minContentHeight));
                }
            } else {
                this.element.height(Math.max(options.height - nonContentHeight, 0));
            }

            if (this.uiDialog.is(':data(resizable)')) {
                this.uiDialog.resizable('option', 'minHeight', this._minHeight());
            }
        }
    });

    $.extend($.ui.dialog, {
        version: "1.8.8",

        uuid: 0,
        maxZ: 0,

        getTitleId: function($el) {
            var id = $el.attr('id');
            if (!id) {
                this.uuid += 1;
                id = this.uuid;
            }
            return 'ui-dialog-title-' + id;
        },

        overlay: function(dialog) {
            this.$el = $.ui.dialog.overlay.create(dialog);
        }
    });

    $.extend($.ui.dialog.overlay, {
        instances: [],
        // reuse old instances due to IE memory leak with alpha transparency (see #5185)
        oldInstances: [],
        maxZ: 0,
        events: $.map('focus,mousedown,mouseup,keydown,keypress,click'.split(','),
		function(event) { return event + '.dialog-overlay'; }).join(' '),
        create: function(dialog) {
            if (this.instances.length === 0) {
                // prevent use of anchors and inputs
                // we use a setTimeout in case the overlay is created from an
                // event that we're going to be cancelling (see #2804)
                setTimeout(function() {
                    // handle $(el).dialog().dialog('close') (see #4065)
                    if ($.ui.dialog.overlay.instances.length) {
                        $(document).bind($.ui.dialog.overlay.events, function(event) {
                            // stop events if the z-index of the target is < the z-index of the overlay
                            // we cannot return true when we don't want to cancel the event (#3523)
                            if ($(event.target).zIndex() < $.ui.dialog.overlay.maxZ) {
                                return false;
                            }
                        });
                    }
                }, 1);

                // allow closing by pressing the escape key
                $(document).bind('keydown.dialog-overlay', function(event) {
                    if (dialog.options.closeOnEscape && event.keyCode &&
					event.keyCode === $.ui.keyCode.ESCAPE) {

                        dialog.close(event);
                        event.preventDefault();
                    }
                });

                // handle window resize
                $(window).bind('resize.dialog-overlay', $.ui.dialog.overlay.resize);
            }

            var $el = (this.oldInstances.pop() || $('<div></div>').addClass('ui-widget-overlay'))
			.appendTo(document.body)
			.css({
			    width: this.width(),
			    height: this.height()
			});

            if ($.fn.bgiframe) {
                $el.bgiframe();
            }

            this.instances.push($el);
            return $el;
        },

        destroy: function($el) {
            var indexOf = $.inArray($el, this.instances);
            if (indexOf != -1) {
                this.oldInstances.push(this.instances.splice(indexOf, 1)[0]);
            }

            if (this.instances.length === 0) {
                $([document, window]).unbind('.dialog-overlay');
            }

            $el.remove();

            // adjust the maxZ to allow other modal dialogs to continue to work (see #4309)
            var maxZ = 0;
            $.each(this.instances, function() {
                maxZ = Math.max(maxZ, this.css('z-index'));
            });
            this.maxZ = maxZ;
        },

        height: function() {
            var scrollHeight,
			offsetHeight;
            // handle IE 6
            if ($.browser.msie && $.browser.version < 7) {
                scrollHeight = Math.max(
				document.documentElement.scrollHeight,
				document.body.scrollHeight
			);
                offsetHeight = Math.max(
				document.documentElement.offsetHeight,
				document.body.offsetHeight
			);

                if (scrollHeight < offsetHeight) {
                    return $(window).height() + 'px';
                } else {
                    return scrollHeight + 'px';
                }
                // handle "good" browsers
            } else {
                return $(document).height() + 'px';
            }
        },

        width: function() {
            var scrollWidth,
			offsetWidth;
            // handle IE 6
            if ($.browser.msie && $.browser.version < 7) {
                scrollWidth = Math.max(
				document.documentElement.scrollWidth,
				document.body.scrollWidth
			);
                offsetWidth = Math.max(
				document.documentElement.offsetWidth,
				document.body.offsetWidth
			);

                if (scrollWidth < offsetWidth) {
                    return $(window).width() + 'px';
                } else {
                    return scrollWidth + 'px';
                }
                // handle "good" browsers
            } else {
                return $(document).width() + 'px';
            }
        },

        resize: function() {
            /* If the dialog is draggable and the user drags it past the
            * right edge of the window, the document becomes wider so we
            * need to stretch the overlay. If the user then drags the
            * dialog back to the left, the document will become narrower,
            * so we need to shrink the overlay to the appropriate size.
            * This is handled by shrinking the overlay before setting it
            * to the full document size.
            */
            var $overlays = $([]);
            $.each($.ui.dialog.overlay.instances, function() {
                $overlays = $overlays.add(this);
            });

            $overlays.css({
                width: 0,
                height: 0
            }).css({
                width: $.ui.dialog.overlay.width(),
                height: $.ui.dialog.overlay.height()
            });
        }
    });

    $.extend($.ui.dialog.overlay.prototype, {
        destroy: function() {
            $.ui.dialog.overlay.destroy(this.$el);
        }
    });

} (jQuery));



/*
* Treeview 1.4 - jQuery plugin to hide and show branches of a tree
* 
* http://bassistance.de/jquery-plugins/jquery-plugin-treeview/
* http://docs.jquery.com/Plugins/Treeview
*
* Copyright (c) 2007 Jörn Zaefferer
*
* Dual licensed under the MIT and GPL licenses:
*   http://www.opensource.org/licenses/mit-license.php
*   http://www.gnu.org/licenses/gpl.html
*
* Revision: $Id: jquery.treeview.js 4684 2008-02-07 19:08:06Z joern.zaefferer $
*
*/
(function($, undefined) {

    $.extend($.fn, {
        swapClass: function(c1, c2) {
            var c1Elements = this.filter('.' + c1);
            this.filter('.' + c2).removeClass(c2).addClass(c1);
            c1Elements.removeClass(c1).addClass(c2);
            return this;
        },
        replaceClass: function(c1, c2) {
            return this.filter('.' + c1).removeClass(c1).addClass(c2).end();
        },
        hoverClass: function(className) {
            className = className || "hover";
            return this.hover(function() {
                $(this).addClass(className);
            }, function() {
                $(this).removeClass(className);
            });
        },
        heightToggle: function(animated, callback) {
            animated ?
				this.animate({ height: "toggle" }, animated, callback) :
				this.each(function() {
				    jQuery(this)[jQuery(this).is(":hidden") ? "show" : "hide"]();
				    if (callback)
				        callback.apply(this, arguments);
				});
        },
        heightHide: function(animated, callback) {
            if (animated) {
                this.animate({ height: "hide" }, animated, callback);
            } else {
                this.hide();
                if (callback)
                    this.each(callback);
            }
        },
        prepareBranches: function(settings) {
            if (!settings.prerendered) {
                // mark last tree items
                this.filter(":last-child:not(ul)").addClass(CLASSES.last);
                // collapse whole tree, or only those marked as closed, anyway except those marked as open
                this.filter((settings.collapsed ? "" : "." + CLASSES.closed) + ":not(." + CLASSES.open + ")").find(">ul").hide();
            }
            // return all items with sublists
            return this.filter(":has(>ul)");
        },
        applyClasses: function(settings, toggler) {
            this.filter(":has(>ul):not(:has(>a))").find(">span").click(function(event) {
                toggler.apply($(this).next());
            }).add($("a", this)).hoverClass();

            if (!settings.prerendered) {
                // handle closed ones first
                this.filter(":has(>ul:hidden)")
						.addClass(CLASSES.expandable)
						.replaceClass(CLASSES.last, CLASSES.lastExpandable);

                // handle open ones
                this.not(":has(>ul:hidden)")
						.addClass(CLASSES.collapsable)
						.replaceClass(CLASSES.last, CLASSES.lastCollapsable);

                // create hitarea
                this.prepend("<div class=\"" + CLASSES.hitarea + "\"/>").find("div." + CLASSES.hitarea).each(function() {
                    var classes = "";
                    $.each($(this).parent().attr("class").split(" "), function() {
                        classes += this + "-hitarea ";
                    });
                    $(this).addClass(classes);
                });
            }

            // apply event to hitarea
            this.find("div." + CLASSES.hitarea).click(toggler);
        },
        treeview: function(settings) {

            settings = $.extend({
                cookieId: "treeview"
            }, settings);

            if (settings.add) {
                return this.trigger("add", [settings.add]);
            }

            if (settings.toggle) {
                var callback = settings.toggle;
                settings.toggle = function() {
                    return callback.apply($(this).parent()[0], arguments);
                };
            }

            // factory for treecontroller
            function treeController(tree, control) {
                // factory for click handlers
                function handler(filter) {
                    return function() {
                        // reuse toggle event handler, applying the elements to toggle
                        // start searching for all hitareas
                        toggler.apply($("div." + CLASSES.hitarea, tree).filter(function() {
                            // for plain toggle, no filter is provided, otherwise we need to check the parent element
                            return filter ? $(this).parent("." + filter).length : true;
                        }));
                        return false;
                    };
                }
                // click on first element to collapse tree
                $("a:eq(0)", control).click(handler(CLASSES.collapsable));
                // click on second to expand tree
                $("a:eq(1)", control).click(handler(CLASSES.expandable));
                // click on third to toggle tree
                $("a:eq(2)", control).click(handler());
            }

            // handle toggle event
            function toggler() {
                $(this)
					.parent()
                // swap classes for hitarea
					.find(">.hitarea")
						.swapClass(CLASSES.collapsableHitarea, CLASSES.expandableHitarea)
						.swapClass(CLASSES.lastCollapsableHitarea, CLASSES.lastExpandableHitarea)
					.end()
                // swap classes for parent li
					.swapClass(CLASSES.collapsable, CLASSES.expandable)
					.swapClass(CLASSES.lastCollapsable, CLASSES.lastExpandable)
                // find child lists
					.find(">ul")
                // toggle them
					.heightToggle(settings.animated, settings.toggle);
                if (settings.unique) {
                    $(this).parent()
						.siblings()
                    // swap classes for hitarea
						.find(">.hitarea")
							.replaceClass(CLASSES.collapsableHitarea, CLASSES.expandableHitarea)
							.replaceClass(CLASSES.lastCollapsableHitarea, CLASSES.lastExpandableHitarea)
						.end()
						.replaceClass(CLASSES.collapsable, CLASSES.expandable)
						.replaceClass(CLASSES.lastCollapsable, CLASSES.lastExpandable)
						.find(">ul")
						.heightHide(settings.animated, settings.toggle);
                }
            }

            function serialize() {
                function binary(arg) {
                    return arg ? 1 : 0;
                }
                var data = [];
                branches.each(function(i, e) {
                    data[i] = $(e).is(":has(>ul:visible)") ? 1 : 0;
                });
                $.cookie(settings.cookieId, data.join(""));
            }

            function deserialize() {
                var stored = $.cookie(settings.cookieId);
                if (stored) {
                    var data = stored.split("");
                    branches.each(function(i, e) {
                        $(e).find(">ul")[parseInt(data[i]) ? "show" : "hide"]();
                    });
                }
            }

            // add treeview class to activate styles
            this.addClass("treeview");

            // prepare branches and find all tree items with child lists
            var branches = this.find("li").prepareBranches(settings);

            switch (settings.persist) {
                case "cookie":
                    var toggleCallback = settings.toggle;
                    settings.toggle = function() {
                        serialize();
                        if (toggleCallback) {
                            toggleCallback.apply(this, arguments);
                        }
                    };
                    deserialize();
                    break;
                case "location":
                    var current = this.find("a").filter(function() { return this.href.toLowerCase() == location.href.toLowerCase(); });
                    if (current.length) {
                        current.addClass("selected").parents("ul, li").add(current.next()).show();
                    }
                    break;
            }

            branches.applyClasses(settings, toggler);

            // if control option is set, create the treecontroller and show it
            if (settings.control) {
                treeController(this, settings.control);
                $(settings.control).show();
            }

            return this.bind("add", function(event, branches) {
                $(branches).prev()
					.removeClass(CLASSES.last)
					.removeClass(CLASSES.lastCollapsable)
					.removeClass(CLASSES.lastExpandable)
				.find(">.hitarea")
					.removeClass(CLASSES.lastCollapsableHitarea)
					.removeClass(CLASSES.lastExpandableHitarea);
                $(branches).find("li").andSelf().prepareBranches(settings).applyClasses(settings, toggler);
            });
        }
    });

    // classes used by the plugin
    // need to be styled via external stylesheet, see first example
    var CLASSES = $.fn.treeview.classes = {
        open: "open",
        closed: "closed",
        expandable: "expandable",
        expandableHitarea: "expandable-hitarea",
        lastExpandableHitarea: "lastExpandable-hitarea",
        collapsable: "collapsable",
        collapsableHitarea: "collapsable-hitarea",
        lastCollapsableHitarea: "lastCollapsable-hitarea",
        lastCollapsable: "lastCollapsable",
        lastExpandable: "lastExpandable",
        last: "last",
        hitarea: "hitarea"
    };

    // provide backwards compability
    $.fn.Treeview = $.fn.treeview;

})(jQuery);


/*
* jQuery UI Autocomplete 1.8.8
*
* Copyright 2010, AUTHORS.txt (http://jqueryui.com/about)
* Dual licensed under the MIT or GPL Version 2 licenses.
* http://jquery.org/license
*
* http://docs.jquery.com/UI/Autocomplete
*
* Depends:
*	jquery.ui.core.js
*	jquery.ui.widget.js
*	jquery.ui.position.js
*/
/*
* jQuery Autocomplete plugin 1.1
*
* Copyright (c) 2009 Jörn Zaefferer
*
* Dual licensed under the MIT and GPL licenses:
*   http://www.opensource.org/licenses/mit-license.php
*   http://www.gnu.org/licenses/gpl.html
*
* Revision: $Id: jquery.autocomplete.js 15 2009-08-22 10:30:27Z joern.zaefferer $
*/

; (function($) {

    $.fn.extend({
        autocomplete: function(urlOrData, options) {
            var isUrl = typeof urlOrData == "string";
            options = $.extend({}, $.Autocompleter.defaults, {
                url: isUrl ? urlOrData : null,
                data: isUrl ? null : urlOrData,
                delay: isUrl ? $.Autocompleter.defaults.delay : 10,
                max: options && !options.scroll ? 10 : 150
            }, options);

            // if highlight is set to false, replace it with a do-nothing function
            options.highlight = options.highlight || function(value) { return value; };

            // if the formatMatch option is not specified, then use formatItem for backwards compatibility
            options.formatMatch = options.formatMatch || options.formatItem;

            return this.each(function() {
                new $.Autocompleter(this, options);
            });
        },
        result: function(handler) {
            return this.bind("result", handler);
        },
        search: function(handler) {
            return this.trigger("search", [handler]);
        },
        flushCache: function() {
            return this.trigger("flushCache");
        },
        setOptions: function(options) {
            return this.trigger("setOptions", [options]);
        },
        unautocomplete: function() {
            return this.trigger("unautocomplete");
        }
    });

    $.Autocompleter = function(input, options) {

        var KEY = {
            UP: 38,
            DOWN: 40,
            DEL: 46,
            TAB: 9,
            RETURN: 13,
            ESC: 27,
            COMMA: 188,
            PAGEUP: 33,
            PAGEDOWN: 34,
            BACKSPACE: 8
        };

        // Create $ object for input element
        var $input = $(input).attr("autocomplete", "off").addClass(options.inputClass);

        var timeout;
        var previousValue = "";
        var cache = $.Autocompleter.Cache(options);
        var hasFocus = 0;
        var lastKeyPressCode;
        var config = {
            mouseDownOnSelect: false
        };
        var select = $.Autocompleter.Select(options, input, selectCurrent, config);

        var blockSubmit;

        // prevent form submit in opera when selecting with return key
        $.browser.opera && $(input.form).bind("submit.autocomplete", function() {
            if (blockSubmit) {
                blockSubmit = false;
                return false;
            }
        });

        // only opera doesn't trigger keydown multiple times while pressed, others don't work with keypress at all
        $input.bind(($.browser.opera ? "keypress" : "keydown") + ".autocomplete", function(event) {
            // a keypress means the input has focus
            // avoids issue where input had focus before the autocomplete was applied
            hasFocus = 1;
            // track last key pressed
            lastKeyPressCode = event.keyCode;
            switch (event.keyCode) {

                case KEY.UP:
                    event.preventDefault();
                    if (select.visible()) {
                        select.prev();
                    } else {
                        onChange(0, true);
                    }
                    break;

                case KEY.DOWN:
                    event.preventDefault();
                    if (select.visible()) {
                        select.next();
                    } else {
                        onChange(0, true);
                    }
                    break;

                case KEY.PAGEUP:
                    event.preventDefault();
                    if (select.visible()) {
                        select.pageUp();
                    } else {
                        onChange(0, true);
                    }
                    break;

                case KEY.PAGEDOWN:
                    event.preventDefault();
                    if (select.visible()) {
                        select.pageDown();
                    } else {
                        onChange(0, true);
                    }
                    break;

                // matches also semicolon    
                case options.multiple && $.trim(options.multipleSeparator) == "," && KEY.COMMA:
                case KEY.TAB:
                case KEY.RETURN:
                    if (selectCurrent()) {
                        // stop default to prevent a form submit, Opera needs special handling
                        event.preventDefault();
                        blockSubmit = true;
                        return false;
                    }
                    break;

                case KEY.ESC:
                    select.hide();
                    break;

                default:
                    clearTimeout(timeout);
                    timeout = setTimeout(onChange, options.delay);
                    break;
            }
        }).focus(function() {
            // track whether the field has focus, we shouldn't process any
            // results if the field no longer has focus
            hasFocus++;
        }).blur(function() {
            hasFocus = 0;
            if (!config.mouseDownOnSelect) {
                hideResults();
            }
        }).click(function() {
            // show select when clicking in a focused field
            if (hasFocus++ > 1 && !select.visible()) {
                onChange(0, true);
            }
        }).bind("search", function() {
            // TODO why not just specifying both arguments?
            var fn = (arguments.length > 1) ? arguments[1] : null;
            function findValueCallback(q, data) {
                var result;
                if (data && data.length) {
                    for (var i = 0; i < data.length; i++) {
                        if (data[i].result.toLowerCase() == q.toLowerCase()) {
                            result = data[i];
                            break;
                        }
                    }
                }
                if (typeof fn == "function") fn(result);
                else $input.trigger("result", result && [result.data, result.value]);
            }
            $.each(trimWords($input.val()), function(i, value) {
                request(value, findValueCallback, findValueCallback);
            });
        }).bind("flushCache", function() {
            cache.flush();
        }).bind("setOptions", function() {
            $.extend(options, arguments[1]);
            // if we've updated the data, repopulate
            if ("data" in arguments[1])
                cache.populate();
        }).bind("unautocomplete", function() {
            select.unbind();
            $input.unbind();
            $(input.form).unbind(".autocomplete");
        });


        function selectCurrent() {
            var selected = select.selected();
            if (!selected)
                return false;

            var v = selected.result;
            previousValue = v;

            if (options.multiple) {
                var words = trimWords($input.val());
                if (words.length > 1) {
                    var seperator = options.multipleSeparator.length;
                    var cursorAt = $(input).selection().start;
                    var wordAt, progress = 0;
                    $.each(words, function(i, word) {
                        progress += word.length;
                        if (cursorAt <= progress) {
                            wordAt = i;
                            return false;
                        }
                        progress += seperator;
                    });
                    words[wordAt] = v;
                    // TODO this should set the cursor to the right position, but it gets overriden somewhere
                    //$.Autocompleter.Selection(input, progress + seperator, progress + seperator);
                    
                    //v = words.join(options.multipleSeparator);   // Richard ( 2011-06-02 )
                }
                //v += options.multipleSeparator;   // Richard ( 2011-06-02 )
            }

            $input.val(v);
            hideResultsNow();
            $input.trigger("result", [selected.data, selected.value]);
            return true;
        }

        function onChange(crap, skipPrevCheck) {
            if (lastKeyPressCode == KEY.DEL) {
                select.hide();
                return;
            }

            var currentValue = $input.val();

            if (!skipPrevCheck && currentValue == previousValue)
                return;

            previousValue = currentValue;

            currentValue = lastWord(currentValue);
            if (currentValue.length >= options.minChars) {
                $input.addClass(options.loadingClass);
                if (!options.matchCase)
                    currentValue = currentValue.toLowerCase();
                request(currentValue, receiveData, hideResultsNow);
            } else {
                stopLoading();
                select.hide();
            }
        };

        function trimWords(value) {
            if (!value)
                return [""];
            if (!options.multiple)
                return [$.trim(value)];
            return $.map(value.split(options.multipleSeparator), function(word) {
                return $.trim(value).length ? $.trim(word) : null;
            });
        }

        function lastWord(value) {
            if (!options.multiple)
                return value;
            var words = trimWords(value);
            if (words.length == 1)
                return words[0];
            var cursorAt = $(input).selection().start;
            if (cursorAt == value.length) {
                words = trimWords(value)
            } else {
                words = trimWords(value.replace(value.substring(cursorAt), ""));
            }
            return words[words.length - 1];
        }

        // fills in the input box w/the first match (assumed to be the best match)
        // q: the term entered
        // sValue: the first matching result
        function autoFill(q, sValue) {
            // autofill in the complete box w/the first match as long as the user hasn't entered in more data
            // if the last user key pressed was backspace, don't autofill
            if (options.autoFill && (lastWord($input.val()).toLowerCase() == q.toLowerCase()) && lastKeyPressCode != KEY.BACKSPACE) {
                // fill in the value (keep the case the user has typed)
                $input.val($input.val() + sValue.substring(lastWord(previousValue).length));
                // select the portion of the value not typed by the user (so the next character will erase)
                $(input).selection(previousValue.length, previousValue.length + sValue.length);
            }
        };

        function hideResults() {
            clearTimeout(timeout);
            timeout = setTimeout(hideResultsNow, 200);
        };

        function hideResultsNow() {
            var wasVisible = select.visible();
            select.hide();
            clearTimeout(timeout);
            stopLoading();
            if (options.mustMatch) {
                // call search and run callback
                $input.search(
				function(result) {
				    // if no value found, clear the input box
				    if (!result) {
				        if (options.multiple) {
				            var words = trimWords($input.val()).slice(0, -1);
				            $input.val(words.join(options.multipleSeparator) + (words.length ? options.multipleSeparator : ""));
				        }
				        else {
				            $input.val("");
				            $input.trigger("result", null);
				        }
				    }
				}
			);
            }
        };

        function receiveData(q, data) {
            if (data && data.length && hasFocus) {
                stopLoading();
                select.display(data, q);
                autoFill(q, data[0].value);
                select.show();
            } else {
                hideResultsNow();
            }
        };

        function request(term, success, failure) {
            if (!options.matchCase)
                term = term.toLowerCase();
            var data = cache.load(term);
            // recieve the cached data
            if (data && data.length) {
                success(term, data);
                // if an AJAX url has been supplied, try loading the data now
            } else if ((typeof options.url == "string") && (options.url.length > 0)) {

                var extraParams = {
                    timestamp: +new Date()
                };
                $.each(options.extraParams, function(key, param) {
                    extraParams[key] = typeof param == "function" ? param() : param;
                });

                $.ajax({
                    // try to leverage ajaxQueue plugin to abort previous requests
                    mode: "abort",
                    // limit abortion to this input
                    port: "autocomplete" + input.name,
                    dataType: options.dataType,
                    url: options.url,
                    data: $.extend({
                        q: lastWord(term),
                        limit: options.max
                    }, extraParams),
                    success: function(data) {
                        var parsed = options.parse && options.parse(data) || parse(data);
                        cache.add(term, parsed);
                        success(term, parsed);
                    }
                });
            } else {
                // if we have a failure, we need to empty the list -- this prevents the the [TAB] key from selecting the last successful match
                select.emptyList();
                failure(term);
            }
        };

        function parse(data) {
            var parsed = [];
            var rows = data.split("\n");
            for (var i = 0; i < rows.length; i++) {
                var row = $.trim(rows[i]);
                if (row) {
                    row = row.split("|");
                    parsed[parsed.length] = {
                        data: row,
                        value: row[0],
                        result: options.formatResult && options.formatResult(row, row[0]) || row[0]
                    };
                }
            }
            return parsed;
        };

        function stopLoading() {
            $input.removeClass(options.loadingClass);
        };

    };

    $.Autocompleter.defaults = {
        inputClass: "ac_input",
        resultsClass: "ac_results",
        loadingClass: "ac_loading",
        minChars: 1,
        delay: 400,
        matchCase: false,
        matchSubset: true,
        matchContains: false,
        cacheLength: 10,
        max: 100,
        mustMatch: false,
        extraParams: {},
        selectFirst: true,
        formatItem: function(row) { return row[0]; },
        formatMatch: null,
        autoFill: false,
        width: 0,
        multiple: false,
        multipleSeparator: ", ",
        highlight: function(value, term) {
            return value.replace(new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + term.replace(/([\^\$\(\)\[\]\{\}\*\.\+\?\|\\])/gi, "\\$1") + ")(?![^<>]*>)(?![^&;]+;)", "gi"), "<strong>$1</strong>");
        },
        scroll: true,
        scrollHeight: 180
    };

    $.Autocompleter.Cache = function(options) {

        var data = {};
        var length = 0;

        function matchSubset(s, sub) {
            if (!options.matchCase)
                s = s.toLowerCase();
            var i = s.indexOf(sub);
            if (options.matchContains == "word") {
                i = s.toLowerCase().search("\\b" + sub.toLowerCase());
            }
            if (i == -1) return false;
            return i == 0 || options.matchContains;
        };

        function add(q, value) {
            if (length > options.cacheLength) {
                flush();
            }
            if (!data[q]) {
                length++;
            }
            data[q] = value;
        }

        function populate() {
            if (!options.data) return false;
            // track the matches
            var stMatchSets = {},
			nullData = 0;

            // no url was specified, we need to adjust the cache length to make sure it fits the local data store
            if (!options.url) options.cacheLength = 1;

            // track all options for minChars = 0
            stMatchSets[""] = [];

            // loop through the array and create a lookup structure
            for (var i = 0, ol = options.data.length; i < ol; i++) {
                var rawValue = options.data[i];
                // if rawValue is a string, make an array otherwise just reference the array
                rawValue = (typeof rawValue == "string") ? [rawValue] : rawValue;

                var value = options.formatMatch(rawValue, i + 1, options.data.length);
                if (value === false)
                    continue;

                var firstChar = value.charAt(0).toLowerCase();
                // if no lookup array for this character exists, look it up now
                if (!stMatchSets[firstChar])
                    stMatchSets[firstChar] = [];

                // if the match is a string
                var row = {
                    value: value,
                    data: rawValue,
                    result: options.formatResult && options.formatResult(rawValue) || value
                };

                // push the current match into the set list
                stMatchSets[firstChar].push(row);

                // keep track of minChars zero items
                if (nullData++ < options.max) {
                    stMatchSets[""].push(row);
                }
            };

            // add the data items to the cache
            $.each(stMatchSets, function(i, value) {
                // increase the cache size
                options.cacheLength++;
                // add to the cache
                add(i, value);
            });
        }

        // populate any existing data
        setTimeout(populate, 25);

        function flush() {
            data = {};
            length = 0;
        }

        return {
            flush: flush,
            add: add,
            populate: populate,
            load: function(q) {
                if (!options.cacheLength || !length)
                    return null;
                /* 
                * if dealing w/local data and matchContains than we must make sure
                * to loop through all the data collections looking for matches
                */
                if (!options.url && options.matchContains) {
                    // track all matches
                    var csub = [];
                    // loop through all the data grids for matches
                    for (var k in data) {
                        // don't search through the stMatchSets[""] (minChars: 0) cache
                        // this prevents duplicates
                        if (k.length > 0) {
                            var c = data[k];
                            $.each(c, function(i, x) {
                                // if we've got a match, add it to the array
                                if (matchSubset(x.value, q)) {
                                    csub.push(x);
                                }
                            });
                        }
                    }
                    return csub;
                } else
                // if the exact item exists, use it
                    if (data[q]) {
                    return data[q];
                } else
                    if (options.matchSubset) {
                    for (var i = q.length - 1; i >= options.minChars; i--) {
                        var c = data[q.substr(0, i)];
                        if (c) {
                            var csub = [];
                            $.each(c, function(i, x) {
                                if (matchSubset(x.value, q)) {
                                    csub[csub.length] = x;
                                }
                            });
                            return csub;
                        }
                    }
                }
                return null;
            }
        };
    };

    $.Autocompleter.Select = function(options, input, select, config) {
        var CLASSES = {
            ACTIVE: "ac_over"
        };

        var listItems,
		active = -1,
		data,
		term = "",
		needsInit = true,
		element,
		list;

        // Create results
        function init() {
            if (!needsInit)
                return;
            element = $("<div/>")
		.hide()
		.addClass(options.resultsClass)
		.css("position", "absolute")
		.appendTo(document.body);

            list = $("<ul/>").appendTo(element).mouseover(function(event) {
                if (target(event).nodeName && target(event).nodeName.toUpperCase() == 'LI') {
                    active = $("li", list).removeClass(CLASSES.ACTIVE).index(target(event));
                    $(target(event)).addClass(CLASSES.ACTIVE);
                }
            }).click(function(event) {
                $(target(event)).addClass(CLASSES.ACTIVE);
                select();
                // TODO provide option to avoid setting focus again after selection? useful for cleanup-on-focus
                input.focus();
                return false;
            }).mousedown(function() {
                config.mouseDownOnSelect = true;
            }).mouseup(function() {
                config.mouseDownOnSelect = false;
            });

            if (options.width > 0)
                element.css("width", options.width);

            needsInit = false;
        }

        function target(event) {
            var element = event.target;
            while (element && element.tagName != "LI")
                element = element.parentNode;
            // more fun with IE, sometimes event.target is empty, just ignore it then
            if (!element)
                return [];
            return element;
        }

        function moveSelect(step) {
            listItems.slice(active, active + 1).removeClass(CLASSES.ACTIVE);
            movePosition(step);
            var activeItem = listItems.slice(active, active + 1).addClass(CLASSES.ACTIVE);
            if (options.scroll) {
                var offset = 0;
                listItems.slice(0, active).each(function() {
                    offset += this.offsetHeight;
                });
                if ((offset + activeItem[0].offsetHeight - list.scrollTop()) > list[0].clientHeight) {
                    list.scrollTop(offset + activeItem[0].offsetHeight - list.innerHeight());
                } else if (offset < list.scrollTop()) {
                    list.scrollTop(offset);
                }
            }
        };

        function movePosition(step) {
            active += step;
            if (active < 0) {
                active = listItems.size() - 1;
            } else if (active >= listItems.size()) {
                active = 0;
            }
        }

        function limitNumberOfItems(available) {
            return options.max && options.max < available
			? options.max
			: available;
        }

        function fillList() {
            list.empty();
            var max = limitNumberOfItems(data.length);
            for (var i = 0; i < max; i++) {
                if (!data[i])
                    continue;
                var formatted = options.formatItem(data[i].data, i + 1, max, data[i].value, term);
                if (formatted === false)
                    continue;
                var li = $("<li/>").html(options.highlight(formatted, term)).addClass(i % 2 == 0 ? "ac_even" : "ac_odd").appendTo(list)[0];
                $.data(li, "ac_data", data[i]);
            }
            listItems = list.find("li");
            if (options.selectFirst) {
                listItems.slice(0, 1).addClass(CLASSES.ACTIVE);
                active = 0;
            }
            // apply bgiframe if available
            if ($.fn.bgiframe)
                list.bgiframe();
        }

        return {
            display: function(d, q) {
                init();
                data = d;
                term = q;
                fillList();
            },
            next: function() {
                moveSelect(1);
            },
            prev: function() {
                moveSelect(-1);
            },
            pageUp: function() {
                if (active != 0 && active - 8 < 0) {
                    moveSelect(-active);
                } else {
                    moveSelect(-8);
                }
            },
            pageDown: function() {
                if (active != listItems.size() - 1 && active + 8 > listItems.size()) {
                    moveSelect(listItems.size() - 1 - active);
                } else {
                    moveSelect(8);
                }
            },
            hide: function() {
                element && element.hide();
                listItems && listItems.removeClass(CLASSES.ACTIVE);
                active = -1;
            },
            visible: function() {
                return element && element.is(":visible");
            },
            current: function() {
                return this.visible() && (listItems.filter("." + CLASSES.ACTIVE)[0] || options.selectFirst && listItems[0]);
            },
            show: function() {
                var offset = $(input).offset();
                element.css({
                    width: typeof options.width == "string" || options.width > 0 ? options.width : $(input).width(),
                    top: offset.top + input.offsetHeight,
                    left: offset.left
                }).show();
                if (options.scroll) {
                    list.scrollTop(0);
                    list.css({
                        maxHeight: options.scrollHeight,
                        overflow: 'auto'
                    });

                    if ($.browser.msie && typeof document.body.style.maxHeight === "undefined") {
                        var listHeight = 0;
                        listItems.each(function() {
                            listHeight += this.offsetHeight;
                        });
                        var scrollbarsVisible = listHeight > options.scrollHeight;
                        list.css('height', scrollbarsVisible ? options.scrollHeight : listHeight);
                        if (!scrollbarsVisible) {
                            // IE doesn't recalculate width when scrollbar disappears
                            listItems.width(list.width() - parseInt(listItems.css("padding-left")) - parseInt(listItems.css("padding-right")));
                        }
                    }

                }
            },
            selected: function() {
                var selected = listItems && listItems.filter("." + CLASSES.ACTIVE).removeClass(CLASSES.ACTIVE);
                return selected && selected.length && $.data(selected[0], "ac_data");
            },
            emptyList: function() {
                list && list.empty();
            },
            unbind: function() {
                element && element.remove();
            }
        };
    };

    $.fn.selection = function(start, end) {
        if (start !== undefined) {
            return this.each(function() {
                if (this.createTextRange) {
                    var selRange = this.createTextRange();
                    if (end === undefined || start == end) {
                        selRange.move("character", start);
                        selRange.select();
                    } else {
                        selRange.collapse(true);
                        selRange.moveStart("character", start);
                        selRange.moveEnd("character", end);
                        selRange.select();
                    }
                } else if (this.setSelectionRange) {
                    this.setSelectionRange(start, end);
                } else if (this.selectionStart) {
                    this.selectionStart = start;
                    this.selectionEnd = end;
                }
            });
        }
        var field = this[0];
        if (field.createTextRange) {
            var range = document.selection.createRange(),
			orig = field.value,
			teststring = "<->",
			textLength = range.text.length;
            range.text = teststring;
            var caretAt = field.value.indexOf(teststring);
            field.value = orig;
            this.selection(caretAt, caretAt + textLength);
            return {
                start: caretAt,
                end: caretAt + textLength
            }
        } else if (field.selectionStart !== undefined) {
            return {
                start: field.selectionStart,
                end: field.selectionEnd
            }
        }
    };

})(jQuery);

/*!*
* @filename jquery include 
* @name jQuery Include File
* @type jQuery
* @projectDescription Include a file (css and js) in a head of the document and execute
* @date 08/07/2008
* @version 1.0
* @cat Ajax
* @require
* @author Alex
* @param required none url String|Array The address of the plugin that will be inserted.
* You can pass a indexed array of url
* @param optional none callback Function The function to be executed after the file has loaded
* @example
* $.include('/foo/test/file.js');
* @desc load the current script
* @example
* var files = ['test.js','another.js','onemore.js'];
* $.include(files,function(){
* 		//execute some code after all scripts are completed
* });
* @desc load all the script inside the array
* @return false | Element (object)
*/

(function($) {

    $.extend({
        // You can change the base path to be applied in all imports
        ImportBasePath: '',
        // Associative array storing wating tasks and their callback
        __WaitingTasks: new Object(),
        // Called when a single file is loaded successfully - update and check WaitingTasks to see if it's ok to load callback
        __loadedSuccessfully: function(taskId) {
            if (taskId in $.__WaitingTasks) {
                if (($.__WaitingTasks[taskId].loading -= 1) < 1) {
                    var callback = $.__WaitingTasks[taskId].task;
                    if (typeof callback == 'function') {
                        callback();
                    }
                    delete $.__WaitingTasks[taskId];
                }
            }
        },
        //pass a file name and return a array with file name and extension
        fileinfo: function(data) {
            data = data.replace(/^\s|\s$/g, "");
            var m;
            if (/\.\w+$/.test(data)) {
                m = data.match(/([^\/\\]+)\.(\w+)$/);
                if (m) {
                    if (m[2] == 'js') {
                        return {
                            filename: m[1],
                            ext: m[2],
                            tag: 'script'
                        };
                    }
                    else
                        if (m[2] == 'css') {
                        return {
                            filename: m[1],
                            ext: m[2],
                            tag: 'link'
                        };
                    }
                    else {
                        return {
                            filename: m[1],
                            ext: m[2],
                            tag: null
                        };
                    }
                }
                else {
                    return {
                        filename: null,
                        ext: null
                    };
                }
            } else {
                m = data.match(/([^\/\\]+)$/);
                if (m) {
                    return {
                        filename: m[1],
                        ext: null,
                        tag: null
                    };
                }
                else {
                    return {
                        filename: null,
                        ext: null,
                        tag: null
                    };
                }
            }
        },
        //Check if the file that is been included already exist and return a Boolean value
        fileExist: function(filename, filetype, attrCheck) {
            var elementsArray = document.getElementsByTagName(filetype);
            for (var i = 0; i < elementsArray.length; i++) {
                if (elementsArray[i].getAttribute(attrCheck) == $.ImportBasePath + filename) {
                    return true;
                }
            }
            return false;
        },
        //Create the element depending of the file type and return the element (Object)
        createElement: function(filename, filetype) {
            switch (filetype) {
                case 'script':
                    if (!$.fileExist(filename, filetype, 'src')) {
                        var scriptTag = document.createElement(filetype);
                        scriptTag.setAttribute('language', 'javascript');
                        scriptTag.setAttribute('type', 'text/javascript');
                        scriptTag.setAttribute('src', $.ImportBasePath + filename);
                        return scriptTag;
                    } else {
                        return false;
                    }
                    break;
                case 'link':
                    if (!$.fileExist(filename, filetype, 'href')) {
                        var styleTag = document.createElement(filetype);
                        styleTag.setAttribute('type', 'text/css');
                        styleTag.setAttribute('rel', 'stylesheet');
                        styleTag.setAttribute('href', $.ImportBasePath + filename);
                        return styleTag;
                    } else {
                        return false;
                    }
                    break;

                default:
                    return false;
                    break;
            }
        },
        cssReady: function(index, taskId) {
            function check() {
                if (document.styleSheets[index]) {
                    window.clearInterval(checkInterval);
                    $.__loadedSuccessfully(taskId);
                }
            }
            var checkInterval = window.setInterval(check, 200);
        },
        //The main function to insert the file
        include: function(file, callback) {
            var headerTag = document.getElementsByTagName('head')[0];
            var fileArray = [];
            //if file is string, give a single index element
            typeof file == 'string' ? fileArray[0] = file : fileArray = file;
            // Create a unique id using the current time
            var taskId = new Date().getTime().toString();
            $.__WaitingTasks[taskId] = { 'loading': fileArray.length, 'task': callback };
            //go through all the files
            for (var i = 0; i < fileArray.length; i++) {
                var elementTag = $.fileinfo(fileArray[i]).tag;
                var el = [];
                if (elementTag !== null) {
                    el[i] = $.createElement(fileArray[i], elementTag);
                    if (el[i]) {
                        headerTag.appendChild(el[i]);
                        if ($.browser.msie) {
                            el[i].onreadystatechange = function() {
                                if (this.readyState === 'loaded' || this.readyState === 'complete') {
                                    $.__loadedSuccessfully(taskId);
                                }
                            };
                        }
                        else {
                            if (elementTag == 'link') {
                                $.cssReady(i, taskId);
                            }
                            else {
                                if (/WebKit/i.test(navigator.userAgent)) {
                                    var _timer = setInterval(function() {
                                        if (/loaded|complete/.test(document.readyState)) {
                                            $.__loadedSuccessfully(taskId); // call of the call
                                        }
                                    }, 100);
                                }
                                el[i].onload = function() {
                                    $.__loadedSuccessfully(taskId);
                                };
                            }
                        }
                    } else {
                        $.__loadedSuccessfully(taskId);
                    }
                } else {
                    return false;
                }
            }
        }
    });

})(jQuery);
/**
* This jQuery plugin displays pagination links inside the selected elements.
* 
* This plugin needs at least jQuery 1.4.2
*
* @author Gabriel Birke (birke *at* d-scribe *dot* de)
* @version 2.1
* @param {int} maxentries Number of entries to paginate
* @param {Object} opts Several options (see README for documentation)
* @return {Object} jQuery Object
*/
(function($) {
    /**
    * @class Class for calculating pagination values
    */
    $.PaginationCalculator = function(maxentries, opts) {
        this.maxentries = maxentries;
        this.opts = opts;
    }

    $.extend($.PaginationCalculator.prototype, {
        /**
        * Calculate the maximum number of pages
        * @method
        * @returns {Number}
        */
        numPages: function() {
            return Math.ceil(this.maxentries / this.opts.items_per_page);
        },
        /**
        * Calculate start and end point of pagination links depending on 
        * current_page and num_display_entries.
        * @returns {Array}
        */
        getInterval: function(current_page) {
            var ne_half = Math.floor(this.opts.num_display_entries / 2);
            var np = this.numPages();
            var upper_limit = np - this.opts.num_display_entries;
            var start = current_page > ne_half ? Math.max(Math.min(current_page - ne_half, upper_limit), 0) : 0;
            var end = current_page > ne_half ? Math.min(current_page + ne_half + (this.opts.num_display_entries % 2), np) : Math.min(this.opts.num_display_entries, np);
            return { start: start, end: end };
        }
    });

    // Initialize jQuery object container for pagination renderers
    $.PaginationRenderers = {}

    /**
    * @class Default renderer for rendering pagination links
    */
    $.PaginationRenderers.defaultRenderer = function(maxentries, opts) {
        this.maxentries = maxentries;
        this.opts = opts;
        this.pc = new $.PaginationCalculator(maxentries, opts);
    }
    $.extend($.PaginationRenderers.defaultRenderer.prototype, {
        /**
        * Helper function for generating a single link (or a span tag if it's the current page)
        * @param {Number} page_id The page id for the new item
        * @param {Number} current_page 
        * @param {Object} appendopts Options for the new item: text and classes
        * @returns {jQuery} jQuery object containing the link
        */
        createLink: function(page_id, current_page, appendopts) {
            var lnk, np = this.pc.numPages();
            page_id = page_id < 0 ? 0 : (page_id < np ? page_id : np - 1); // Normalize page id to sane value
            appendopts = $.extend({ text: page_id + 1, classes: "" }, appendopts || {});
            if (page_id == current_page) {
                lnk = $("<span class='current'>" + appendopts.text + "</span>");
            }
            else {
                lnk = $("<a>" + appendopts.text + "</a>")
					.attr('href', this.opts.link_to.replace(/__id__/, page_id));
            }
            if (appendopts.classes) { lnk.addClass(appendopts.classes); }
            lnk.data('page_id', page_id);
            return lnk;
        },
        // Generate a range of numeric links 
        appendRange: function(container, current_page, start, end, opts) {
            var i;
            for (i = start; i < end; i++) {
                this.createLink(i, current_page, opts).appendTo(container);
            }
        },
        getLinks: function(current_page, eventHandler) {
            var begin, end,
				interval = this.pc.getInterval(current_page),
				np = this.pc.numPages(),
				fragment = $("<div class='pagination'></div>");

            // Generate "Previous"-Link
            if (this.opts.prev_text && (current_page > 0 || this.opts.prev_show_always)) {
                fragment.append(this.createLink(current_page - 1, current_page, { text: this.opts.prev_text, classes: "prev" }));
            }
            // Generate starting points
            if (interval.start > 0 && this.opts.num_edge_entries > 0) {
                end = Math.min(this.opts.num_edge_entries, interval.start);
                this.appendRange(fragment, current_page, 0, end, { classes: 'sp' });
                if (this.opts.num_edge_entries < interval.start && this.opts.ellipse_text) {
                    jQuery("<span>" + this.opts.ellipse_text + "</span>").appendTo(fragment);
                }
            }
            // Generate interval links
            this.appendRange(fragment, current_page, interval.start, interval.end);
            // Generate ending points
            if (interval.end < np && this.opts.num_edge_entries > 0) {
                if (np - this.opts.num_edge_entries > interval.end && this.opts.ellipse_text) {
                    jQuery("<span>" + this.opts.ellipse_text + "</span>").appendTo(fragment);
                }
                begin = Math.max(np - this.opts.num_edge_entries, interval.end);
                this.appendRange(fragment, current_page, begin, np, { classes: 'ep' });

            }
            // Generate "Next"-Link
            if (this.opts.next_text && (current_page < np - 1 || this.opts.next_show_always)) {
                fragment.append(this.createLink(current_page + 1, current_page, { text: this.opts.next_text, classes: "next" }));
            }
            $('a', fragment).click(eventHandler);
            return fragment;
        }
    });

    // Extend jQuery
    $.fn.pagination = function(maxentries, opts) {

        // Initialize options with default values
        opts = jQuery.extend({
            items_per_page: 10,
            num_display_entries: 11,
            current_page: 0,
            num_edge_entries: 0,
            link_to: "#",
            prev_text: "Prev",
            next_text: "Next",
            ellipse_text: "...",
            prev_show_always: true,
            next_show_always: true,
            renderer: "defaultRenderer",
            callback: function() { return false; }
        }, opts || {});

        var containers = this,
			renderer, links, current_page;

        /**
        * This is the event handling function for the pagination links. 
        * @param {int} page_id The new page number
        */
        function paginationClickHandler(evt) {
            var links,
				new_current_page = $(evt.target).data('page_id'),
				continuePropagation = selectPage(new_current_page);
            if (!continuePropagation) {
                evt.stopPropagation();
            }
            return continuePropagation;
        }

        /**
        * This is a utility function for the internal event handlers. 
        * It sets the new current page on the pagination container objects, 
        * generates a new HTMl fragment for the pagination links and calls
        * the callback function.
        */
        function selectPage(new_current_page) {
            // update the link display of a all containers
            containers.data('current_page', new_current_page);
            links = renderer.getLinks(new_current_page, paginationClickHandler);
            containers.empty();
            links.appendTo(containers);
            // call the callback and propagate the event if it does not return false
            var continuePropagation = opts.callback(new_current_page, containers);
            return continuePropagation;
        }

        // -----------------------------------
        // Initialize containers
        // -----------------------------------
        current_page = opts.current_page;
        containers.data('current_page', current_page);
        // Create a sane value for maxentries and items_per_page
        maxentries = (!maxentries || maxentries < 0) ? 1 : maxentries;
        opts.items_per_page = (!opts.items_per_page || opts.items_per_page < 0) ? 1 : opts.items_per_page;

        if (!$.PaginationRenderers[opts.renderer]) {
            throw new ReferenceError("Pagination renderer '" + opts.renderer + "' was not found in jQuery.PaginationRenderers object.");
        }
        renderer = new $.PaginationRenderers[opts.renderer](maxentries, opts);

        // Attach control events to the DOM elements
        var pc = new $.PaginationCalculator(maxentries, opts);
        var np = pc.numPages();
        containers.bind('setPage', { numPages: np }, function(evt, page_id) {
            if (page_id >= 0 && page_id < evt.data.numPages) {
                selectPage(page_id); return false;
            }
        });
        containers.bind('prevPage', function(evt) {
            var current_page = $(this).data('current_page');
            if (current_page > 0) {
                selectPage(current_page - 1);
            }
            return false;
        });
        containers.bind('nextPage', { numPages: np }, function(evt) {
            var current_page = $(this).data('current_page');
            if (current_page < evt.data.numPages - 1) {
                selectPage(current_page + 1);
            }
            return false;
        });

        // When all initialisation is done, draw the links
        links = renderer.getLinks(current_page, paginationClickHandler);
        containers.empty();
        links.appendTo(containers);
        // call callback function
        opts.callback(current_page, containers);
    } // End of $.fn.pagination block

})(jQuery);


/*
	Masked Input plugin for jQuery
	Copyright (c) 2007-2011 Josh Bush (digitalbush.com)
	Licensed under the MIT license (http://digitalbush.com/projects/masked-input-plugin/#license) 
	Version: 1.3
*/
(function($) {
	var pasteEventName = ($.browser.msie ? 'paste' : 'input') + ".mask";
	var iPhone = (window.orientation != undefined);

	$.mask = {
		//Predefined character definitions
		definitions: {
			'9': "[0-9]",
			'a': "[A-Za-z]",
			'*': "[A-Za-z0-9]"
		},
		dataName:"rawMaskFn"
	};

	$.fn.extend({
		//Helper Function for Caret positioning
		caret: function(begin, end) {
			if (this.length == 0) return;
			if (typeof begin == 'number') {
				end = (typeof end == 'number') ? end : begin;
				return this.each(function() {
					if (this.setSelectionRange) {
						this.setSelectionRange(begin, end);
					} else if (this.createTextRange) {
						var range = this.createTextRange();
						range.collapse(true);
						range.moveEnd('character', end);
						range.moveStart('character', begin);
						range.select();
					}
				});
			} else {
				if (this[0].setSelectionRange) {
					begin = this[0].selectionStart;
					end = this[0].selectionEnd;
				} else if (document.selection && document.selection.createRange) {
					var range = document.selection.createRange();
					begin = 0 - range.duplicate().moveStart('character', -100000);
					end = begin + range.text.length;
				}
				return { begin: begin, end: end };
			}
		},
		unmask: function() { return this.trigger("unmask"); },
		mask: function(mask, settings) {
			if (!mask && this.length > 0) {
				var input = $(this[0]);
				return input.data($.mask.dataName)();
			}
			settings = $.extend({
				placeholder: "_",
				completed: null
			}, settings);

			var defs = $.mask.definitions;
			var tests = [];
			var partialPosition = mask.length;
			var firstNonMaskPos = null;
			var len = mask.length;

			$.each(mask.split(""), function(i, c) {
				if (c == '?') {
					len--;
					partialPosition = i;
				} else if (defs[c]) {
					tests.push(new RegExp(defs[c]));
					if(firstNonMaskPos==null)
						firstNonMaskPos =  tests.length - 1;
				} else {
					tests.push(null);
				}
			});

			return this.trigger("unmask").each(function() {
				var input = $(this);
				var buffer = $.map(mask.split(""), function(c, i) { if (c != '?') return defs[c] ? settings.placeholder : c });
				var focusText = input.val();

				function seekNext(pos) {
					while (++pos <= len && !tests[pos]);
					return pos;
				};
				function seekPrev(pos) {
					while (--pos >= 0 && !tests[pos]);
					return pos;
				};

				function shiftL(begin,end) {
					if(begin<0)
					   return;
					for (var i = begin,j = seekNext(end); i < len; i++) {
						if (tests[i]) {
							if (j < len && tests[i].test(buffer[j])) {
								buffer[i] = buffer[j];
								buffer[j] = settings.placeholder;
							} else
								break;
							j = seekNext(j);
						}
					}
					writeBuffer();
					input.caret(Math.max(firstNonMaskPos, begin));
				};

				function shiftR(pos) {
					for (var i = pos, c = settings.placeholder; i < len; i++) {
						if (tests[i]) {
							var j = seekNext(i);
							var t = buffer[i];
							buffer[i] = c;
							if (j < len && tests[j].test(t))
								c = t;
							else
								break;
						}
					}
				};

				function keydownEvent(e) {
					var k=e.which;

					//backspace, delete, and escape get special treatment
					if(k == 8 || k == 46 || (iPhone && k == 127)){
						var pos = input.caret(),
							begin = pos.begin,
							end = pos.end;
						
						if(end-begin==0){
							begin=k!=46?seekPrev(begin):(end=seekNext(begin-1));
							end=k==46?seekNext(end):end;
						}
						clearBuffer(begin, end);
						shiftL(begin,end-1);

						return false;
					} else if (k == 27) {//escape
						input.val(focusText);
						input.caret(0, checkVal());
						return false;
					}
				};

				function keypressEvent(e) {
					var k = e.which,
						pos = input.caret();
					if (e.ctrlKey || e.altKey || e.metaKey || k<32) {//Ignore
						return true;
					} else if (k) {
						if(pos.end-pos.begin!=0){
							clearBuffer(pos.begin, pos.end);
							shiftL(pos.begin, pos.end-1);
						}

						var p = seekNext(pos.begin - 1);
						if (p < len) {
							var c = String.fromCharCode(k);
							if (tests[p].test(c)) {
								shiftR(p);
								buffer[p] = c;
								writeBuffer();
								var next = seekNext(p);
								input.caret(next);
								if (settings.completed && next >= len)
									settings.completed.call(input);
							}
						}
						return false;
					}
				};

				function clearBuffer(start, end) {
					for (var i = start; i < end && i < len; i++) {
						if (tests[i])
							buffer[i] = settings.placeholder;
					}
				};

				function writeBuffer() { return input.val(buffer.join('')).val(); };

				function checkVal(allow) {
					//try to place characters where they belong
					var test = input.val();
					var lastMatch = -1;
					for (var i = 0, pos = 0; i < len; i++) {
						if (tests[i]) {
							buffer[i] = settings.placeholder;
							while (pos++ < test.length) {
								var c = test.charAt(pos - 1);
								if (tests[i].test(c)) {
									buffer[i] = c;
									lastMatch = i;
									break;
								}
							}
							if (pos > test.length)
								break;
						} else if (buffer[i] == test.charAt(pos) && i!=partialPosition) {
							pos++;
							lastMatch = i;
						}
					}
					if (!allow && lastMatch + 1 < partialPosition) {
						input.val("");
						clearBuffer(0, len);
					} else if (allow || lastMatch + 1 >= partialPosition) {
						writeBuffer();
						if (!allow) input.val(input.val().substring(0, lastMatch + 1));
					}
					return (partialPosition ? i : firstNonMaskPos);
				};

				input.data($.mask.dataName,function(){
					return $.map(buffer, function(c, i) {
						return tests[i]&&c!=settings.placeholder ? c : null;
					}).join('');
				})

				if (!input.attr("readonly"))
					input
					.one("unmask", function() {
						input
							.unbind(".mask")
							.removeData($.mask.dataName);
					})
					.bind("focus.mask", function() {
						focusText = input.val();
						var pos = checkVal();
						writeBuffer();
						var moveCaret=function(){
							if (pos == mask.length)
								input.caret(0, pos);
							else
								input.caret(pos);
						};
						($.browser.msie ? moveCaret:function(){setTimeout(moveCaret,0)})();
					})
					.bind("blur.mask", function() {
						checkVal();
						if (input.val() != focusText)
							input.change();
					})
					.bind("keydown.mask", keydownEvent)
					.bind("keypress.mask", keypressEvent)
					.bind(pasteEventName, function() {
						setTimeout(function() { input.caret(checkVal(true)); }, 0);
					});

				checkVal(); //Perform initial check for existing values
			});
		}
	});
})(jQuery);
