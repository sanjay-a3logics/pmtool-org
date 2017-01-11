(function ($) {
  $.fn.fitText = function( kompressor, options ) {

    // Setup options
    var compressor = kompressor || 1,
        settings = $.extend({
          'minFontSize' : Number.NEGATIVE_INFINITY,
          'maxFontSize' : Number.POSITIVE_INFINITY
        }, options);

    return this.each(function(){

      // Store the object
      var $this = $(this);

      // Resizer() resizes items based on the object width divided by the compressor * 10
      var resizer = function () {
      	var refWidth = $this.width();
      	if (settings.referenceWidth) {
      		refWidth = settings.referenceWidth;
      	}
      
      	var fontSize = Math.max(Math.min(refWidth / (compressor*10), parseFloat(settings.maxFontSize)), parseFloat(settings.minFontSize));
        $this.css('font-size', fontSize);
        
        if (settings.debug) {
	        console.log('Id/Class: ', $this.attr('id'), $this.attr('class'), 'This width: ', refWidth);
	        console.log('Calculated maxFontSize: ', refWidth / (compressor*10) );
	        console.log('Calculated fontsize: ', fontSize);
	        console.log('-----------'); 
      	}
      };

      // Call once to set.
      resizer();

      // Call on resize. Opera debounces their resize by default.
      $(window).on('resize.fittext orientationchange.fittext', resizer);

    });

  };

  $.fn.extend({
      centerVertical : function(params) {
          var containerHeight = $(this).parent().height();
          var elementHeight = $(this).height();
		  if (params && params.referenceHeight) {
		  	containerHeight = params.referenceHeight;
		  }      	

          var top = (containerHeight - elementHeight ) / 2;
          $(this).css("position", 'relative');
          $(this).css("top", top);
          if (params && params.debug) {
          	console.log('containerHeight: ', containerHeight, 'elementHeight: ', elementHeight, 'top: ', top);
          }
          return this;
      }
  });

  // not really needed anymore 
  /*$.fn.extend({
      breakLine : function(params) {
      	if (params && params.break == false) {
      		return this;
      	}
          var text = $(this).text();
          var spaces = [];
          n = 0;
          while (text.indexOf(' ', n) != -1) {
              spaces.push(text.indexOf(' ', n));
              n = text.indexOf(' ', n) + 1;
          };
          textCenter = text.length / 2;
          centerSpace = 0;
          for (var i = 0; i < spaces.length; i++) {
              if (Math.abs(textCenter - spaces[i]) < Math.abs(textCenter - centerSpace)) {
                  centerSpace = spaces[i];
              }
          }
          $(this).empty();
          $(this).append(text.slice(0, centerSpace));
          $(this).append($('<br/>'));
          $(this).append(text.slice(centerSpace));
          return this;
      }
  });*/

  $.fn.animateRotate = function(angle, duration, easing, complete) {
    var args = $.speed(duration, easing, complete);
    var step = args.step;
    return this.each(function(i, e) {
        args.step = function(now) {
            $.style(e, 'transform', 'rotate(' + now + 'deg)');
            if (step) return step.apply(this, arguments);
        };

        $({deg: 0}).animate({deg: angle}, args);
    });
  };

})(successJQ);

function sizeRatio(child, parent) {
	var childRatio = child.width() / child.height();
	var parentRatio = parent.width() / parent.height();
	return childRatio / parentRatio;
}

function rgbToHex(cssRgb) {
    rgb = cssRgb.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/);
    return '#' + (+rgb[1]).toString(16) + (+rgb[2]).toString(16) + (+rgb[3]).toString(16);
}
 
function hexToRgb(hex) {
    var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
    return result ? {
        r: parseInt(result[1], 16),
        g: parseInt(result[2], 16),
        b: parseInt(result[3], 16)
    } : null;
}
    
function ColorLuminance(hex, lum) {
	// validate hex string
	hex = String(hex).replace(/[^0-9a-f]/gi, '');
	if (hex.length < 6) {
		hex = hex[0]+hex[0]+hex[1]+hex[1]+hex[2]+hex[2];
	}
	lum = lum || 0;

	// convert to decimal and change luminosity
	var rgb = "#", c, i;
	for (i = 0; i < 3; i++) {
		c = parseInt(hex.substr(i*2,2), 16);
		c = Math.round(Math.min(Math.max(0, c + (c * lum)), 255)).toString(16);
		rgb += ("00"+c).substr(c.length);
	}

	return rgb;
}

// an ISO date parser which runs on safari as well
Date.fromISO = (function($){
    var testIso = '2011-11-24T09:00:27+0200';
    // Chrome
    var diso= Date.parse(testIso);
    if(diso===1322118027000) return function(s){
        return Date.parse(s);
    }
    // JS 1.8 gecko
    var noOffset = function(s) {

      var day = $.map(s.slice(0,-5).split(/\D/), function(itm){
        return parseInt(itm, 10) || 0;
      });

      day[1]-= 1;
      day= new Date(Date.UTC.apply(Date, day));  
      var offsetString = s.slice(-5)
      var offset = parseInt(offsetString,10)/100; 
      if (offsetString.slice(0,1)=="+") offset*=-1;
      day.setHours(day.getHours()+offset);
      return day.getTime();
    }
    if (noOffset(testIso)===1322118027000) {
       return noOffset;
    }  
    return function(s){ // kennebec@SO + QTax@SO
        var day, tz, 
        rx = /^(\d{4}\-\d\d\-\d\d([tT][\d:\.]*)?)([zZ]|([+\-])(\d\d):?(\d\d))?$/,
            
        p= rx.exec(s) || [];
        if(p[1]){
            day= p[1].split(/\D/).map(function(itm){
                return parseInt(itm, 10) || 0;
            });
            day[1]-= 1;
            day= new Date(Date.UTC.apply(Date, day));
            if(!day.getDate()) return NaN;
            if(p[5]){
                tz= parseInt(p[5], 10)/100*60;
                if(p[6]) tz += parseInt(p[6], 10);
                if(p[4]== "+") tz*= -1;
                if(tz) day.setUTCMinutes(day.getUTCMinutes()+ tz);
            }
            return day;
        }
        return NaN;
    }
})(successJQ)

function ieVersion() {
	if(navigator.appVersion.indexOf("MSIE 7.")!=-1) {
		return 7;
	}
	if(navigator.appVersion.indexOf("MSIE 8.")!=-1) {
		return 8;
	}
	if(navigator.appVersion.indexOf("MSIE 9.")!=-1) {
		return 9;
	}
	return 0;	
}

function isMobileDevice() {
	return /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
}

