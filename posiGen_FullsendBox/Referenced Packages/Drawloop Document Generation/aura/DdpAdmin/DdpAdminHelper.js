({
    searchHelper : function(component) {
        var searchString = document.getElementById("search").value;
        document.getElementById("noResults").setAttribute("data-hidden", "true");
        if (!searchString) {
            var branches = ["buttonToggle", "configuration", "users"];
            for (var i = 0; i < branches.length; i++) {
                var br = component.find(branches[i] + "-Node");
                var icon = component.find(branches[i] + "-icon");
                document.getElementById(branches[i]).setAttribute("data-hidden", "false");
                $A.util.addClass(br, "slds-collapsed");
                $A.util.removeClass(icon, "icon-on");
            }
            var branchItems = ["classicExperienceButtons", "buttonWizard", 
                               "edition", "thirdpartyIntegrations", "jobQueueStatus", "settings", "sampleDdps", 
                               "testUserConfiguration", "userPermissions"];
            for (var i = 0; i < branchItems.length; i++) {
                document.getElementById(branchItems[i]).setAttribute("data-hidden", "false");
            }
        } else {
            this.searchHeaders(component, searchString.toLowerCase());
        }
    },
    searchHeaders : function(component, searchString) {
        var escapedSearchString = this.escapeRegExp(searchString);
        var re = new RegExp(escapedSearchString, 'i');
        var buttonCount = 0;
        var buttonHeader = 0;
        var configCount = 0;
        var configHeader = 0;
        var usersCount = 0;
        var usersHeader = 0;
        
        if ("classic buttons".match(re) || "classic experience buttons".match(re) || "button wizard".match(re)) {
            buttonCount++;
            if ("classic buttons".match(re)) {
                buttonHeader++;
            }
        }
        if ("configuration".match(re) || "edition".match(re) || "third-party integrations".match(re) || 
            "job queue status".match(re) || "settings".match(re) || "sample ddps".match(re)) {
            configCount++;
            if ("configuration".match(re)) {
                configHeader++
            }
        }
    	if ("users".match(re) || "test user configuration".match(re) || "user permissions".match(re)) {
    		usersCount++;
            if ("users".match(re)) {
                usersHeader++;
            }
        }
        this.searchHeadersResults(component, buttonCount, configCount, usersCount);
        this.searchItemsResults(component, escapedSearchString, buttonCount, configCount, usersCount, buttonHeader, configHeader, usersHeader);
        if ((buttonCount + configCount + usersCount) == 0) {
            document.getElementById("noResults").setAttribute("data-hidden", "false");
        } else {
            document.getElementById("noResults").setAttribute("data-hidden", "true");
        }
    },
    searchHeadersResults : function(component, buttonCount, configCount, usersCount) {
        var showBranches = [];
        var hideBranches = [];
        if (buttonCount > 0) {
            showBranches.push("buttonToggle");
        } else {
            hideBranches.push("buttonToggle");
        }
        if (configCount > 0) {
            showBranches.push("configuration");
        } else {
            hideBranches.push("configuration");
        }
        if (usersCount > 0) {
            showBranches.push("users");
        } else {
            hideBranches.push("users");
        }
        for (var i = 0; i < showBranches.length; i++) {
            var branch = document.getElementById(showBranches[i]);
            var br = component.find(showBranches[i] + "-Node");
            var icon = component.find(showBranches[i]+ "-icon");
            
            if (branch.getAttribute("data-hidden") != "false") {
            	branch.setAttribute("data-hidden", "false");
            }
            if ($A.util.hasClass(br, "slds-collapsed")) {
                $A.util.removeClass(br, "slds-collapsed");
            }
            if (!$A.util.hasClass(icon, "icon-on")) {
                $A.util.addClass(icon, "icon-on");
            }
        }
        for (var i = 0; i < hideBranches.length; i++) {
            var branch = document.getElementById(hideBranches[i]);
            var br = component.find(hideBranches[i] + "-Node");
            var icon = component.find(hideBranches[i]+ "-icon");
            
            if (branch.getAttribute("data-hidden") != "true") {
            	branch.setAttribute("data-hidden", "true");
                $A.util.removeClass(component.find(hideBranches[i] + "-icon"), "icon-on");
            }
            if (!$A.util.hasClass(br, "slds-collapsed")) {
                $A.util.addClass(br, "slds-collapsed");
            }
            if ($A.util.hasClass(icon, "icon-on")) {
                $A.util.removeClass(icon, "icon-on");
            }
        }
    },
    searchItemsResults : function(component, escapedSearchString, buttonCount, configCount, usersCount, buttonHeader, configHeader, usersHeader) {
        var re = new RegExp(escapedSearchString, 'i');
        
        if (buttonCount > 0 && buttonHeader == 0) {
            var buttonItems = [{option:"classic experience button", element:"classicExperienceButtons"}, 
                               {option:"button wizard", element:"buttonWizard"}];
            for (var i = 0; i < buttonItems.length; i++) {
                var item = document.getElementById(buttonItems[i].element);
                if (buttonItems[i].option.match(re)) {
                    if (item.getAttribute("data-hidden") != "false") {
            			item.setAttribute("data-hidden", "false");
                    }
                } else {
                    if (item.getAttribute("data-hidden") != "true") {
            			item.setAttribute("data-hidden", "true");
                    }
                }
            }
        }
        if (configCount > 0 && configHeader == 0) {
            var configItems = [{option:"edition", element:"edition"},
                               {option:"third-party integrations", element:"thirdpartyIntegrations"},
                               {option:"job queue status", element:"jobQueueStatus"},
                               {option:"settings", element:"settings"},
                               {option:"sample ddps", element:"sampleDdps"}];
            for (var i = 0; i < configItems.length; i++) {
                var item = document.getElementById(configItems[i].element);
                if (configItems[i].option.match(re)) {
                    if (item.getAttribute("data-hidden") != "false") {
            			item.setAttribute("data-hidden", "false");
                    }
                } else {
                    if (item.getAttribute("data-hidden") != "true") {
            			item.setAttribute("data-hidden", "true");
                    }
                }
            }
        }
        if (usersCount > 0 && usersHeader == 0) {
            var usersItems = [{option:"test user configuration", element:"testUserConfiguration"},
                              {option:"user permissions", element:"userPermissions"}];
            for (var i = 0; i < usersItems.length; i++) {
                var item = document.getElementById(usersItems[i].element);
                if (usersItems[i].option.match(re)) {
                    if (item.getAttribute("data-hidden") != "false") {
            			item.setAttribute("data-hidden", "false");
                    }
                } else {
                    if (item.getAttribute("data-hidden") != "true") {
            			item.setAttribute("data-hidden", "true");
                    }
                }
            }
        }
    },
    toggleBranch : function(component, branchName) {
        var element = component.find(branchName);
        $A.util.toggleClass(element, "slds-collapsed");
    },
    isSelected : function(component, event) {
        var elements = document.getElementsByClassName('slds-is-selected');
        var id = event.target.getAttribute("id");
        if (!elements) {
            return;
        }
        for ( var i = 0; i < elements.length; i++) {
            var element = elements[i].getAttribute("id")
            $A.util.removeClass(component.find(element), "slds-is-selected");
        }
        $A.util.addClass(component.find(id), "slds-is-selected");
    },
    escapeRegExp : function(str) {
    	return str.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&");
	}
})