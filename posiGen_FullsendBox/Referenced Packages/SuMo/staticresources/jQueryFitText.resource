(function ($) {
  $.fn.getTextWidth = function(params) {
    var spanText = $("BODY #spanCalculateTextWidth");

    if (spanText.size() <= 0) {
      spanText = $("<span id='spanCalculateTextWidth' style='filter: alpha(0);'></span>");
      spanText.appendTo("BODY");
    }

    var valu = this.val();
    if (!valu) valu = this.text();

    spanText.text(valu);

    spanText.css({
      "fontSize": this.css('fontSize'),
      "fontWeight": this.css('fontWeight'),
      "fontFamily": this.css('fontFamily'),
      "position": "absolute",
      "top": 0,
      "opacity": 0,
      "left": -2000
    });
    
	if (params && params.ret == 'height') {
		return spanText.outerHeight() + parseInt(this.css('paddingBottom')) + 'px';	
	}
    return spanText.outerWidth() + parseInt(this.css('paddingLeft')) + 'px';
  };

  $.fn.getTextHeight = function(width) {
    var spanText = $("BODY #spanCalculateTextHeight");

    if (spanText.size() <= 0) {
      spanText = $("<span id='spanCalculateTextHeight'></span>");
      spanText.appendTo("BODY");
    }

    var valu = this.val();
    if (!valu) valu = this.text();

    spanText.text(valu);

    spanText.css({
      "fontSize": this.css('fontSize'),
      "fontWeight": this.css('fontWeight'),
      "fontFamily": this.css('fontFamily'),
      "top": 0,
      "left": -1 * parseInt(width) + 'px',
      "position": 'absolute',
      "display": "inline-block",
      "width": width
    });

    return spanText.innerHeight() + 'px';
  };

  /**
   * Adjust the font-size of the text so it fits the container.
   *
   * @param minSize     Minimum font size?
   * @param maxSize     Maximum font size?
   * @param truncate    Truncate text after sizing to make sure it fits?
   */
  $.fn.autoTextSize = function(minSize, maxSize, truncate, params) {
 	if (params && params.reverse) {
 		$(this).css("font-size", minSize + "px");
 	}
 	
    var _self = this,
        _width = _self.innerWidth(),
        _height = _self.innerHeight(),
        _textWidth = parseInt(_self.getTextWidth()),
        _textHeight = parseInt(_self.getTextWidth({ret : 'height'})),
        _fontSize = parseInt(_self.css('font-size'));

	params = params == undefined ? {} : params;
	
	if (params.referenceWidth) {
		_width = params.referenceWidth;
	}
	if (params.referenceHeight) {
		_height = params.referenceHeight;
	}	
	
	if (params.debug) {
		console.log('width', _width);
		console.log('_height', _height);
		console.log('_textWidth', _textWidth),
		console.log('_textHeight', _textHeight),
		console.log('_fontSize', _fontSize);
		console.log('-----');
	}
	
	// text fitting from small to big fonts
	if (params.reverse) {
		var c = 0;
	    while (true && c < 100) { 
	      if (maxSize && _fontSize >= maxSize) {break;}  
	       
	      _fontSize++;
	      _self.css('font-size', _fontSize + 'px');
	
	      _textWidth = parseInt(_self.getTextWidth());
	      //_textHeight = parseInt(_self.getTextWidth({ret : 'height'}));
	      _textHeight = _self.innerHeight();
	      
	      if (_width <= _textWidth || _height <= _textHeight) {
	      	_fontSize--;
	        _self.css('font-size', _fontSize + 'px');
	      	break;
	      } 
	      
		  if (params.debug) {  
			console.log('width', _width);
			console.log('_height', _height);
			console.log('_textWidth', _textWidth),
			console.log('_textHeight', _textHeight),
			console.log('_fontSize', _fontSize);
			console.log('-----');
	      }
	      c++;	
	    }	
	}
	// text fitting from big to small fonts
	else {
		var c = 0;
	    while ((_width < _textWidth || (maxSize && _fontSize > parseInt(maxSize))) && c < 100) {
	      if (minSize && _fontSize <= parseInt(minSize)) break;
	
	      _fontSize--;
	      _self.css('font-size', _fontSize + 'px');
	
	      _textWidth = parseInt(_self.getTextWidth());
	    
		    if (params.debug) {  
				console.log('width', _width);
				console.log('_textWidth', _textWidth);
				console.log('_fontSize', _fontSize);
				console.log('-----');
			}	
	    	c++;
	    }
    }

    if (truncate) _self.autoTruncateText();
  	return this;
  };

  /**
   * Function that truncates the text inside a container according to the
   * width and height of that container. In other words, makes it fit by chopping
   * off characters and adding '...'.
   */
  $.fn.autoTruncateText = function() {
    var _self = this,
        _width = _self.outerWidth(),
        _textHeight = parseInt(_self.getTextHeight(_width)),
        _text = _self.text();

    // As long as the height of the text is higher than that
    // of the container, we'll keep removing a character.
    while (_textHeight > _self.outerHeight()) {
      _text = _text.slice(0,-1);
      _self.text(_text);
      _textHeight = parseInt(_self.getTextHeight(_width));
      _truncated = true;
    }

    // When we actually truncated the text, we'll remove the last
    // 3 characters and replace it with '...'.
    if (!_truncated) return;
    _text = _text.slice(0, -3);

    // Make sure there is no dot or space right in front of '...'.
    var lastChar = _text[_text.length - 1];
    if (lastChar == ' ' || lastChar == '.') _text = _text.slice(0, -1);
    _self.text(_text + '...');
  };
})(successJQ);