function highlightBusinessHour(){
        $("#bhd tr").click(function() {
        var selected = $(this).hasClass("highlight");
        $("#bhd tr").children().removeClass("highlight");
        if(!selected)
           $(this).children().addClass( "highlight" );
        });
    }
   
    function saveUsers() {
        var usersToSave = new Array();
        var selectedUsers = $('#droppableUsers').children();
        for(var i=0; i < selectedUsers.length; i++) {
            var userRec = new Object();
            userRec['id'] = selectedUsers[i].getAttribute('userid');
            usersToSave[i] = userRec;
        }
        var usersJson = JSON.stringify(usersToSave);
        saveUsersList(usersJson);             
    }
    
	var isSearchRequested = false;
    function fetchUsersBasedOnName(filter) {
        userName= filter;
		if (!isSearchRequested) {			
			isSearchRequested = true;
			setTimeout(searchUsers, 1000);
		}
    }

	function searchUsers() {
		fetchAvailableUserList(userName);
		isSearchRequested = false;
	}
    
	    
    function populateAvailableUsers(result) {
        $('#draggableUsers').empty();
        $.each(result, function(){
                var user = $('#' + this.Id);
                if (!user.attr('id')) {              
                    var content = '<div style="width:90%; " class="draggableUsers draggable availableUsers" '+
                              'Id="' + this.Id + '" userid="' + this.Id + '" email="' + document.createElement( 'div' ).appendChild( 
        document.createTextNode( this.Email ) ).parentNode.innerHTML + '" username="' + document.createElement( 'div' ).appendChild( 
        document.createTextNode( this.FirstName ) ).parentNode.innerHTML + ' ' + document.createElement( 'div' ).appendChild( 
        document.createTextNode( this.LastName ) ).parentNode.innerHTML + '" >'                        
                            +'<p style="margin-top: 5px;">' + document.createElement( 'div' ).appendChild( 
        document.createTextNode( this.FirstName ) ).parentNode.innerHTML + ' ' + document.createElement( 'div' ).appendChild( 
        document.createTextNode( this.LastName ) ).parentNode.innerHTML + '&nbsp;&nbsp;&nbsp;&nbsp;' + document.createElement( 'div' ).appendChild( 
        document.createTextNode( this.Email ) ).parentNode.innerHTML + '</p></div>';
                    $('#draggableUsers').append(content);
                }                
            }
        );
        setTableHeight();
        $(".draggable").draggable({
            zIndex: 999,
            revert: "invalid",
            revertDuration: 0,
        }); 
        $('#draggableUsers').children().sortElements(function(a, b){
            return $(a).attr("username") > $(b).attr("username") ? 1 : -1;
        });
    }

    function populateAssignedUsers(result ) {
        $('#draggableUsers').droppable ({
                drop: removeSelectedUser    
            });
            $('#droppableUsers').droppable ({
                drop: addToAssignedUsers 
            }); 
		$('#droppableUsers').empty();      
            
        $(result).each(
            function(){             
                var content = '<div style="width:90%; " class="draggableUsers draggable availableUsers" '+
                          'Id="' + this.Id + '" userid="' + this.Id + '" email="' + document.createElement( 'div' ).appendChild( 
        document.createTextNode( this.Email ) ).parentNode.innerHTML + '" username="' + document.createElement( 'div' ).appendChild( 
        document.createTextNode( this.FirstName ) ).parentNode.innerHTML + ' ' + document.createElement( 'div' ).appendChild( 
        document.createTextNode( this.LastName ) ).parentNode.innerHTML + '" >'
                        +'<p style="margin-top: 5px;">' + document.createElement( 'div' ).appendChild( 
        document.createTextNode( this.FirstName ) ).parentNode.innerHTML + ' ' + document.createElement( 'div' ).appendChild( 
        document.createTextNode( this.LastName ) ).parentNode.innerHTML + '&nbsp;&nbsp;&nbsp;&nbsp;' + document.createElement( 'div' ).appendChild( 
        document.createTextNode( this.Email ) ).parentNode.innerHTML + '</p></div>';
                $('#droppableUsers').append(content);                               
            }
        );
        setTableHeight();
        $(".draggable").draggable({
            zIndex: 999,
            revert: "invalid",
            revertDuration: 0,
        }); 
        $('#droppableUsers').children().sortElements(function(a, b){
            return $(a).attr("username") > $(b).attr("username") ? 1 : -1;
        });
    }
    
    function removeSelectedUser(event, ui) {
        var divId = ui.draggable.attr("id");
        var content = '<div style="width:90%;" class="draggableUsers draggable availableUsers" '+
                              ' Id="' + ui.draggable.attr("id") + '" email="' + document.createElement( 'div' ).appendChild( 
        document.createTextNode(  ui.draggable.attr("email") ) ).parentNode.innerHTML  + '" userid="' + ui.draggable.attr("userid") + '" username="' + document.createElement( 'div' ).appendChild( 
        document.createTextNode(  ui.draggable.attr("username") ) ).parentNode.innerHTML  + '" >'+' <p style="margin-top: 5px;">' + document.createElement( 'div' ).appendChild( 
        document.createTextNode(  ui.draggable.attr("username") ) ).parentNode.innerHTML+ '&nbsp;&nbsp;&nbsp;&nbsp;' + document.createElement( 'div' ).appendChild( 
        document.createTextNode(  ui.draggable.attr("email") ) ).parentNode.innerHTML + '</p></div>';
        $("#" + divId).remove();
        $('#draggableUsers').append(content);
        
        $(".draggable").draggable({
            zIndex: 999,
            revert: "invalid",
            revertDuration: 0,
        });        
        $('#draggableUsers').children().sortElements(function(a, b){
            return $(a).attr("username") > $(b).attr("username") ? 1 : -1;
        });        
        setTableHeight();
    }

    function addToAssignedUsers(event, ui) {
		var divId = ui.draggable.attr("id");
        var content = '<div style="width:90%;" class="draggableUsers draggable updatedUsers" '+
                              'Id="' + ui.draggable.attr("id") + '" email="' + document.createElement( 'div' ).appendChild( 
        document.createTextNode(  ui.draggable.attr("email") ) ).parentNode.innerHTML + '" userid="' + ui.draggable.attr("userid") + '" username="' + document.createElement( 'div' ).appendChild( 
        document.createTextNode(  ui.draggable.attr("username")) ).parentNode.innerHTML + '" >'                        
                            + '<p style="margin-top: 5px;">' + document.createElement( 'div' ).appendChild( 
        document.createTextNode(  ui.draggable.attr("username") ) ).parentNode.innerHTML + '&nbsp;&nbsp;&nbsp;&nbsp;' + document.createElement( 'div' ).appendChild( 
        document.createTextNode( ui.draggable.attr("email") ) ).parentNode.innerHTML  + '</p></div>';
        $("#" + divId).remove();
        $('#droppableUsers').append(content);
        
        $(".draggable").draggable({
            zIndex: 999,
            revert: "invalid",
            revertDuration: 0,
        });        
        $('#droppableUsers').children().sortElements(function(a, b){
            return $(a).attr("username") > $(b).attr("username") ? 1 : -1;
        });
        setTableHeight();    
    }
    
    function setTableHeight() {
        var selectedUserCount = $('#droppableUsers').children().size();
        var availableUserCount = $('#draggableUsers').children().size();
        var maxUserCount = (selectedUserCount > availableUserCount ? selectedUserCount : availableUserCount ); 
        
        $( '#draggableUsers' ).css( "height", maxUserCount*30);
        $( '#droppableUsers' ).css( "height", maxUserCount*30);
    }
    
    
    jQuery.fn.sortElements = (function(){ 
        var sort = [].sort; 
        return function(comparator, getSortable) { 
            getSortable = getSortable || function(){return this;}; 
            var placements = this.map(function(){ 
                var sortElement = getSortable.call(this),
                    parentNode = sortElement.parentNode, 
                    nextSibling = parentNode.insertBefore(
                        document.createTextNode(''),
                        sortElement.nextSibling
                    );
     
                return function() { 
                    if (parentNode === this) {
                        throw new Error(
                            "You can't sort elements if any one is a descendant of another."
                        );
                    } 
                    parentNode.insertBefore(this, nextSibling);
                    parentNode.removeChild(nextSibling); 
                }; 
            });
     
            return sort.call(this, comparator).each(function(i){
                placements[i].call(getSortable.call(this));
            }); 
        }; 
    })();

     
	function displayMangeUserSection(){
		var manageUser = document.getElementById('UserManage');
		manageUser.style.display = 'block';   
		var hrsDetail = document.getElementById('hrDetailsDiv');
        hrsDetail.style.display = 'none';		
	}
  
	function  hideManageUserBlock(){
		var manageUser =document.getElementById('UserManage');
		manageUser.style.display = 'none'; 
		var hrsDetail = document.getElementById('hrDetailsDiv');
        hrsDetail.style.display = 'block'; 
		stopLoadingDialog();
	}
  
    function selectAllCheckboxes(obj,receivedInputID){
		var inputCheckBox = document.getElementsByTagName("input");                  
        for(var i=0; i<inputCheckBox.length; i++){          
            if(inputCheckBox[i].id.indexOf(receivedInputID)!=-1){                                     
                inputCheckBox[i].checked = obj.checked;
            }
        }
		
    }

    function removeCheckboxColor(element){
        $("#bhd tr").click(function() {
           var selected = $(this).hasClass("highlight");
           $("#bhd tr").children().removeClass("highlight"); 
        });
		
		if(!element.checked) {
			document.getElementById("checkAllBox").checked = false; 
		}
    }
	
	function updateUserCount(bhrId, userCount) {
		var recId = bhrId.concat('cnt');
		var totalUserCount = document.getElementById(recId);
		totalUserCount.innerHTML = userCount;
	}
         
    function showDetail(bhrId){
        retrieveAssignedUsers(bhrId);
	}
    
    function displayHrDetails(displayDetails) {		
		var hrsDetail = document.getElementById('hrDetailsDiv');
		var displayBtn = document.getElementById("deleteBusinessHoursbutton");      
	   
		if (displayDetails === 'false') {
			hrsDetail.style.display = 'none'; 
            displayBtn.style.display = 'none'; 
        } else{			
            hideManageUserBlock();
            hrsDetail.style.display = 'block';                
            displayBtn.style.display = 'block';              
        }		
    }	 
    function saveBusinessHrs() {
		saveRecords();saveBusinessHrRecord();
		stopLoadingDialog();
		
    }
        
    function saveAssignedUsersFunction() {
		saveRecords();saveAssigneduserRecord();
    }
     
    function saveRecords(){
		var element = document.getElementById("BusinessHourDiv");
		try {
            element.click();
		} catch(err) {
			var theEvent = document.createEvent("MouseEvent");
			theEvent.initMouseEvent("click", true, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0,null);
			element.dispatchEvent(theEvent);
		}
    }