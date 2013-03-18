var intRegex = /^\d+\.\d{2}$/;

$('#addForm input[name="itemName"], #editForm input[name="itemName"]').bind('change keyup', function() {
        testIfCanSubmit();
});

$('#addForm input[name="price"]').bind('change keyup', function() {
        if(intRegex.test($('#addForm input[name="price"]').val()))
                testIfCanSubmit();
        else
                $('#addForm :button').attr("disabled", true);
});

$('#editForm input[name="price"]').bind('change keyup', function() {
        if(intRegex.test($('#editForm input[name="price"]').val()))
                testIfCanSubmit();
        else
                $('#editForm :button').attr("disabled", true);
});

$('#addForm input[name="desc"], #editForm input[name="desc"]').bind('change keyup', function() {
        testIfCanSubmit();
});

$('#prevName').keyup(function(e) {
        if(e.keyCode == 13)
                $(this).trigger("fillData");
});

$('#prevName').bind("change fillData", function() {
        var itemName = JSON.stringify({'name':$('#prevName').val()});
        $.post('/getMenuItem.json', itemName, function(data) {
                $.each(data, function (key, value) {
                        if(key == 'name')
                                $('#editForm input[name="itemName"]').val(value);
                        else if(key == 'price')
                                $('#editForm input[name="price"]').val(value);
                        else if(key == 'description')
                                $('#editForm input[name="desc"]').val(value);
                        else if(key == 'category')
                                $('#editForm select[name="category"]').val(value);
                        else if(key == 'isVeg')
                                $('#editForm input[name="vegetarian"]').prop('checked', value);
                        else if(key == 'isSuccess' && !value)
                                $('#editForm label[name="result"]').text("Error: \"" + $('#prevName').val() + "\" does not exist");
                        testIfCanSubmit();
                });
        }, "json");
});


function addMenuItem() {
        var itemName = JSON.stringify({
                'name': $('#addForm input[name="itemName"]').val(), 
                'category': $('#addForm select[name="category"]').val(), 
                'description': $('#addForm input[name="desc"]').val(), 
                'price': $('#addForm input[name="price"]').val(), 
                'isVeg': $('#addForm input[name="vegetarian"]').prop('checked'), 
                'image': ''});
        $.post('/addMenuItem.json', itemName, function(data) {
                $.each(data, function (key, value) {
                        if (key == 'isSuccess' && value) {
                                $('#addForm label[name="result"]').text("Successfully added item \"" + $('#addForm input[name="itemName"]').val() + "\"");
                                clearAddForm();
                        } else if (key == 'isSuccess' && !value) {
				$('#addForm label[name="result"]').text("Error: Menu Item \"" + $('#addForm input[name="itemName"]').val() + "\" already exist");
			}
                });
        }, "json");
}

function editMenuItem() {
        var itemName = JSON.stringify({
                'prevItemName': $('#prevName').val(), 
                'name': $('#editForm input[name="itemName"]').val(), 
                'category': $('#editForm select[name="category"]').val(), 
                'description': $('#editForm input[name="desc"]').val(), 
                'price': $('#editForm input[name="price"]').val(), 
                'isVeg': $('#editForm input[name="vegetarian"]').prop('checked'), 
                'image': ''});
        $.post('/editMenuItem.json', itemName, function(data) {
                $.each(data, function (key, value) {
                        if (key == 'isSuccess') {
                                if (value) {
                                        $('#editForm label[name="result"]').text("Successfully modified item \"" + $('#prevName').val() + "\"");
                                        clearEditForm();
					$('#menuItems').empty();
					$.post('/getMenuName.json', function(data) {
						var menuItems = $.parseJSON(data);
                                        	$.each(menuItems, function (key, value) {
							$('#menuItems').append('<option>' + value['menuName'] + '</option>');
						});
					}, "json");                                                                                   
                                } else                                                                                                                                             
                                        $('#editForm label[name="result"]').text("Error: \"" + $('#prevName').val() + "\" does not exist");                                        
                        }                                                                                                                                                          
                });                                                                                                                                                                
        }, "json");                                                                                                                                                                
}

function clearEditForm() {                                                                                                                                                         
        $('#prevName').val("");                                                                                                                                                    
        $('#editForm input[name="itemName"]').val("");                                                                                                                             
        $('#editForm select[name="category"]').val(1);                                                                                                                             
        $('#editForm input[name="desc"]').val("");                                                                                                                                 
        $('#editForm input[name="price"]').val("");                                                                                                                                
        $('#editForm input[name="vegetarian"]').prop('checked', 0);                                                                                                                
        $('#editForm :button').attr("disabled", true);                                                                                                                             
}                                                                                                                                                                                  
                                                                                                                                                                                   
function clearAddForm() {                                                                                                                                                          
        $('#addForm input[name="itemName"]').val("");                                                                                                                              
        $('#addForm select[name="category"]').val(1);                                                                                                                              
        $('#addForm input[name="desc"]').val("");                                                                                                                                  
        $('#addForm input[name="price"]').val("");                                                                                                                                 
        $('#addForm input[name="vegetarian"]').prop('checked', 0);                                                                                                                 
        $('#addForm :button').attr("disabled", true);                                                                                                                              
}                                                                                                                                                                                  
                                                                                                                                                                                   
function testIfCanSubmit() {                                                                                                                                                       
        if($('#addForm input[name="itemName"]').val() == "" || $('#addForm input[name="price"]').val() == "" || $('#addForm input[name="desc"]').val() == "")                      
                $('#addForm :button').attr("disabled", true);                                                                                                                      
        else                                                                                                                                                                       
                $('#addForm :button').attr("disabled", false);                                                                                                                     
                                                                                                                                                                                   
        if($('#editForm input[name="itemName"]').val() == "" || $('#editForm input[name="price"]').val() == "" || $('#editForm input[name="desc"]').val() == "")                   
                $('#editForm :button').attr("disabled", true);                                                                                                                     
        else                                                                                                                                                                       
                $('#editForm :button').attr("disabled", false);                                                                                                                    
}                                                                                                                                                                           
