var testName = "Test Name";
var testDesc = "Test Description";
var testPrice = "1.00";

module("clearForm");
test( "clearEditForm", function() {
	populateEditForm();
	$('#editForm :button').attr("disabled", false);		

	clearEditForm();

	var prevName = $('#prevName').val();
	var modifiedName = $('#editForm input[name="itemName"]').val();
	var category = $('#editForm select[name="category"] option:selected')[0].innerText;
	var desc = $('#editForm input[name="desc"]').val();
	var price = $('#editForm input[name="price"]').val(); 
	var isVeg = $('#editForm input[name="vegetarian"]').is(':checked');
	var isDisabled = $('#editForm :button').is(':disabled');

	equal(prevName, "" , "Current item name is cleared");
	equal(modifiedName, "" , "Modified item name is cleared");
	equal(category, "Appetizers", "Category is set to default");
	equal(desc, "", "Description is cleared");
	equal(price, "", "Price is cleared");
	equal(isVeg, false, "Vegetairian checkbox is unchecked");
	equal(isDisabled, true, "Submit button is disabled");
});

test( "clearAddForm", function() {
	populateAddForm();
	$('#addForm :button').attr("disabled", false);

	clearAddForm();

	var itemName = $('#addForm input[name="itemName"]').val();
	var category = $('#addForm select[name="category"] option:selected')[0].innerText;
	var desc = $('#addForm input[name="desc"]').val();
	var price = $('#addForm input[name="price"]').val(); 
	var isVeg = $('#addForm input[name="vegetarian"]').is(':checked');
	var isDisabled = $('#addForm :button').is(':disabled');

	equal(itemName, "" , "Item name is cleared");
	equal(category, "Appetizers", "Category is set to default");
	equal(desc, "", "Description is cleared");
	equal(price, "", "Price is cleared");
	ok(!isVeg, "Vegetairian checkbox is unchecked");
	ok(isDisabled, "Submit button is disabled");
});

module("testIfCanSubmit");
test( "addForm empty", function() {
	testIfCanSubmit();

	var isSubmitBtnDisabled = $('#addForm :button').is(':disabled');
	ok(isSubmitBtnDisabled, "Submit button is disabled");
});

test( "addForm partially filled", function() {
	$('#addForm input[name="itemName"]').val(testName);

	testIfCanSubmit();

	var isSubmitBtnDisabled = $('#addForm :button').is(':disabled');
	ok(isSubmitBtnDisabled, "Submit button is disabled");
});

test( "addForm filled", function() {
	populateAddForm();

	testIfCanSubmit();

	var isSubmitBtnDisabled = $('#addForm :button').is(':disabled');
	ok(!isSubmitBtnDisabled, "Submit button is enabled");
});

test( "editForm empty", function() {
	testIfCanSubmit();

	var isSubmitBtnDisabled = $('#editForm :button').is(':disabled');
	ok(isSubmitBtnDisabled, "Submit button is disabled");
});

test( "editForm partially filled", function() {
	$('#editForm input[name="itemName"]').val(testName);

	testIfCanSubmit();

	var isSubmitBtnDisabled = $('#editForm :button').is(':disabled');
	ok(isSubmitBtnDisabled, "Submit button is disabled");
});

test( "editForm filled", function() {
	populateEditForm();

	testIfCanSubmit();

	var isSubmitBtnDisabled = $('#editForm :button').is(':disabled');
	ok(!isSubmitBtnDisabled, "Submit button is enabled");
});


function populateAddForm() {
	$('#addForm input[name="itemName"]').val(testName);
	$('#addForm select[name="category"]').val(2);
	$('#addForm input[name="desc"]').val(testDesc);                                                                                                                                 
    $('#addForm input[name="price"]').val(testPrice);
    $('#addForm input[name="vegetarian"]').prop('checked', 1); 
}

function populateEditForm() {
	$('#prevName').val("Test Name");
	$('#editForm input[name="itemName"]').val(testName);
	$('#editForm select[name="category"]').val(2);
	$('#editForm input[name="desc"]').val(testDesc);
    $('#editForm input[name="price"]').val(testPrice);
    $('#editForm input[name="vegetarian"]').prop('checked', 1); 
}
