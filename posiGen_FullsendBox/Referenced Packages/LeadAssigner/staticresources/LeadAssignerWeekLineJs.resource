function nextDay(e) {
    return function(t) {
        var n = new Date(t || new Date);
        return new Date(n.getTime() + ((e - n.getDay() + 7) % 7 + 1) * 864e5)
    }
}(function(e) {
    function r(e, t) {
        var n = new Date(e),
            n = new Date(n.setDate(n.getDate() + Number(t))),
            r = n.getDate(),
            i = n.getMonth() + 1,
            s = n.getFullYear();
        return (r < 10 ? "0" + r : r) + "/" + (i < 10 ? "0" + i : i) + "/" + s
    }
    var t = "selectedDay";
    e.fn.weekLine = function(t) {
        if (n[t]) {
            return n[t].apply(this, Array.prototype.slice.call(arguments, 1))
        } else if (typeof t === "object" || !t) {
            return n.init.apply(this, arguments)
        } else {
            e.error("Method " + t + " does not exist on jQuery.weekLine")
        }
    };
    e.fn.weekLine.defaultSettings = {
        dayLabels: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
        mousedownSel: true,
        startDate: null,
        onChange: null
    };
    var n = {
        init: function(n) {
            return this.each(function() {
                function u(n) {
                    e(n).toggleClass(t);
                    if (e.isFunction(r.settings.onChange)) {
                        r.settings.onChange.call(r)
                    }
                }
                var r = e(this),
                    s = false,
                    o = "";
                r.settings = e.extend(true, {}, e.fn.weekLine.defaultSettings, n || {});
                r.data("weekLine", r.settings);
                for (i in r.settings.dayLabels) {
                    o += "<a href='#" + i + "'>" + r.settings.dayLabels[i] + "</a>"
                }
                r.addClass("weekDays cleanslate").append(o).mouseup(function() {
                    s = false;
                    return false
                });
                $days = r.children().bind("mousedown", function() {
                    if (r.settings.mousedownSel) {
                        s = true
                    }
                    u(this);
                    return false
                }).bind("mouseenter", function() {
                    if (!s) {
                        return false
                    }
                    u(this);
                    return false
                })
            })
        },
        getSelected: function(n, i) {
            var s = e(this).data("weekLine"),
                o = null,
                u = "";
            this.children().each(function() {
                $day = e(this);
                if ($day.hasClass(t)) {
                    switch (n) {
                        case "indexes":
                            u += $day.attr("href").substr(1) + ",";
                            break;
                        case "dates":
                            u += r(i ? i : s.startDate ? s.startDate : new Date, $day.attr("href").substr(1)) + ",";
                            break;
                        case "descriptive":
                            if (o == null) {
                                u = $day.html()
                            } else {
                                if ($day.attr("href").substr(1) - o.attr("href").substr(1) == 1) {
                                    var a = u.split(",")[u.split(",").length - 1].split("-");
                                    if (a.length > 1) {
                                        u = u.replace(a[a.length - 1], $day.html())
                                    } else {
                                        u += "-" + $day.html()
                                    }
                                } else {
                                    u += ", " + $day.html()
                                }
                            }
                            o = $day;
                            break;
                        case "labels":
                        default:
                            u += $day.html() + ",";
                            break
                    }
                }
            });
            return u.replace(/,+$/, "")
        },
        setSelected: function(n) {
            var r = e(this),
                s = r.children(),
                o = n.split(",");
            s.removeClass(t);
            for (i in o) {
                s.filter(isNaN(o[i]) ? "a:contains('" + o[i] + "')" : "a:[href='#" + o[i] + "']").addClass(t)
            }
        }
    }
})(jQuery)