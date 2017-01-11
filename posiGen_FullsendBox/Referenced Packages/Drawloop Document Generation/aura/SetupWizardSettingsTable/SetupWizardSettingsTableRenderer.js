({
    rerender : function(cmp, helper) {
       var ret = this.superRerender();
     	setTimeout(function() {
            window.resize();
        }, 100);
        return ret;
	}
})