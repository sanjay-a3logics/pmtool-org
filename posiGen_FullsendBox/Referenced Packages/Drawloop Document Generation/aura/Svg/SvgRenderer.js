({
    render: function(component, helper) {
        //grab attributes from the component markup
        var classname = component.get("v.class");
        var xlinkhref = component.get("v.xlinkHref");
        var mouseOver = component.get("v.mouseOver");
        var mouseOut = component.get("v.mouseOut");
        var onclick = component.get("v.onclick");
        var id = component.get("v.id");
        var display = component.get("v.display");
        var style = component.get("v.style");

        //return an svg element w/ the attributes
        var svg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
        svg.setAttribute('class', classname);
        svg.setAttribute('display', display ? 'inline' : 'none');
        if (mouseOver) {
	        svg.setAttribute('onmouseover', mouseOver);
        }
        if (mouseOut) {
	        svg.setAttribute('onmouseout', mouseOut);
        }
        if (onclick) {
            svg.setAttribute('onclick', onclick);
        }
        if (id) {
            svg.setAttribute('id', id);
        }
        if (style) {
            svg.setAttribute('style', style);
        }
        svg.innerHTML = '<use xlink:href="' + xlinkhref + '"></use>';
        return svg;
    }
})