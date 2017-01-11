({
    updateObjectGroups : function(component) {
        var allGroups = component.get("v.allObjectGroups");
        var filteredGroups = this.filterObjectGroups(component, allGroups);

        var selectedCount = 0;
        var checkedExist = false;
        var uncheckedExist = false;
        for (var i = filteredGroups.length - 1; i > -1; i--) {
            var group = filteredGroups[i];
			
            if (group.isGroup) {
                if (checkedExist) {
                    group.enabled = true;
                    if (uncheckedExist) {
                        group.tristate = true;
                    }
                }
                checkedExist = false;
                uncheckedExist = false;
            } else {
                if (group.enabled) {
                    checkedExist = true;
                } else {
                    uncheckedExist = true;
                }
            } 
            
            selectedCount += ((!group.isGroup && group.enabled) ? 1 : 0);
        }        
        
        component.set("v.objectGroups", filteredGroups);
        component.find("selectedCount").getElement().innerHTML = selectedCount > 0 ? ' (' + selectedCount + ')' : '';
        
        var noRecordRow = component.find("noRecordRow");
        if (filteredGroups.length == 0) {
            var spinner = noRecordRow.getElement().getElementsByTagName('div')[0];
            if (spinner) {
				spinner.remove();
            }
            noRecordRow.getElement().getElementsByTagName('span')[0].innerHTML = 'There are no records to display.';
			$A.util.removeClass(noRecordRow, "rowHidden");
        } else {
            $A.util.addClass(noRecordRow, "rowHidden");
        }
        this.toggleLinkAndSpinner(component, true);
    },
	getObjectGroups : function(component) {
		var action = component.get("c.getLayouts");
        action.setParams({
            sessionId: component.get("v.sessionId")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var groupsJson = response.getReturnValue();
                var groups = JSON.parse(groupsJson);
                
                if (groups.error) {
                    component.getEvent('showError').setParams({
                        message: groups.error
                    }).fire();
                    return;
                }

                var layoutMetadata = {};
                var allGroups = [];
                for (var i in groups) {
                    var group = groups[i];
                    allGroups.push(group);
                    for (var j in group.objectItems) {
                        var item = group.objectItems[j];
						allGroups.push({
                            id: item.id,
                            name: item.name,
                            multiple: false,
                            page: item.page,
                            obj: item.obj,
                            objClass: item.objClass,
                            enabled: item.hasButton,
                            isGroup: false,
                            index: (parseInt(j) + 1)
                        });
                        layoutMetadata[item.id] = item.metadata;
                    }
                }
                component.set("v.allObjectGroups", allGroups);
                component.set("v.layoutMetadata", JSON.stringify(layoutMetadata));
            } else if (state === "ERROR") {
                component.getEvent('showError').setParams({
                    message: 'There was a problem retrieving layout metadata.'
                }).fire();
            }
        });
        $A.enqueueAction(action);
    },
    filterObjectGroups : function(component, allGroups) {
		var searchText = component.get("v.searchText");

        var filteredGroups = {};
        for (var i in allGroups) {
            var group = allGroups[i];
            if (group.isGroup) {
                var subGroups = [group];
                filteredGroups[group.obj] = subGroups;
                continue;
            } else {
                if (searchText) {
                    var values = '';
                    for (var key in group) {
                        if (['obj', 'page'].indexOf(key) >= 0) {
	                        values += group[key];
                        }
                    }
                    var escapedSearchText = this.escapeRegExp(searchText);
                    var re = new RegExp(escapedSearchText, 'i');
                    if (!values.match(re) || values.match(re).length == 0) {
                        continue;
                    }
                }
                filteredGroups[group.obj].push(group);
            }
        }

        var groupsWithSubgroups = [];
        var fgKeys = Object.keys(filteredGroups);
        for (var i in fgKeys) {
            var group = filteredGroups[fgKeys[i]];
            if (group.length > 1) { // The first item is the grouping (header), not a ddp
                groupsWithSubgroups = groupsWithSubgroups.concat(group);
            }
        }
        return groupsWithSubgroups;
    },
    findAncestorWithName : function(el, name) {
        while((el = el.parentElement) && el.nodeName != name);
        return el;
    },
    getAvailableCustomObjects : function(component) {
		var action = component.get("c.getAvailableCustomObjects");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var customObjectsJson = response.getReturnValue();
                var customObjects = JSON.parse(customObjectsJson);
                if (Object.keys(customObjects).length > 0) {
                    component.set('v.availableCustomObjects', customObjects);
                    var optionsArray = [];
                    optionsArray.push({
                        value: '',
                        label: 'Select a custom object',
                        class: 'optionClass'
                    });
                    for (var i = Object.keys(customObjects).length - 1; i > -1; i--) {
                        var customObjectKey = Object.keys(customObjects)[i];
                        optionsArray.push({
                            value: customObjectKey,
                            label: customObjects[customObjectKey],
                            class: 'optionClass'
                        });
                    }
                    component.find('customObjectSelect').set('v.options', optionsArray);
                    component.find('customObjectRow').getElement().style.display = '';
                }
            } else if (state === "ERROR") {
                var error = response.getError();
                var message = 'There was a problem saving changes.';
                if (error && error[0] && error[0].message) {
                    message = error[0].message;
                }
                component.getEvent('showError').setParams({
                    message: message
                }).fire();
            }
        });
        $A.enqueueAction(action);        
    },
    toggleLinkAndSpinner : function(component, showLink) {
        if (!showLink) {
            component.find('addButtonLink').getElement().style.display = 'none';
            component.find('addButtonSpinner').getElement().style.display = '';
        } else {
            component.find('addButtonLink').getElement().style.display = '';
            component.find('addButtonSpinner').getElement().style.display = 'none';
        }
    },
    expandGroup : function(row, industry) {
        row.setAttribute('data-expanded', 'true');
        
        // Update icon
        var div = row.childNodes[0].childNodes[0];
        $A.util.addClass(div, 'divHidden');
        $A.util.removeClass(div.nextSibling, 'divHidden');
        
        // Update rows
        while(row.nextSibling && row.nextSibling.id == industry) {
            $A.util.removeClass(row.nextSibling, 'rowHidden');
            $A.util.addClass(row.nextSibling, 'slds-hint-parent');
            row = row.nextSibling;
        }
    },
    retractGroup : function(row, industry) {
        row.setAttribute('data-expanded', 'false');
        
        // Update icon
        var div = row.childNodes[0].childNodes[1];
        $A.util.addClass(div, 'divHidden');
        $A.util.removeClass(div.previousSibling, 'divHidden');
        
        // Update rows
        while(row.nextSibling && row.nextSibling.id == industry) {
            $A.util.removeClass(row.nextSibling, 'slds-hint-parent');
            $A.util.addClass(row.nextSibling, 'rowHidden');
            row = row.nextSibling;
        }        
    },
    escapeRegExp : function(str) {
        return str.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&");
	}
})