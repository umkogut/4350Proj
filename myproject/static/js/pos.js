$(function() {
  $('input:checkbox').bind('change',function() {
    $('#'+this.id+'_lb').toggle($(this).is(':checked'));
  });
});

function payBill(tableNumCheck) {
    var itemsToPayFor = "[";
    var itemCount = 0;

    $("#bill input[type=checkbox]").each(function() {
      if($(this).is(":checked"))
      {
       $(this).parent().hide();
       $(this).prop('checked', false);
       $('#'+ this.id +'_lb').hide();
      
       var itemInfo = this.id.split('_');
       var orderNum = itemInfo[0].substring(5);
       var tableNum = itemInfo[2].substring(5);
       var itemNum = itemInfo[1].substring(4);
       var groupNum = itemInfo[3].substring(5);

       if(tableNum == tableNumCheck) {
         var item = JSON.stringify({
	  'table':tableNum,
	  'menuItem':itemNum,
	  'group':groupNum,
	  'order':orderNum
          });
	//alert(item);
	if(itemCount > 0)
	  itemsToPayFor += ", " + item;
        else
          itemsToPayFor += item;

        itemCount++;
	//alert(itemsToPayFor);
       }
      }

     });
     itemsToPayFor += "]";
     $.post('/payForItems.json', JSON.stringify(itemsToPayFor), function(data) {}, "json");
}

function displayTableBill(tableNum) {
    $(".tab-pane").hide();
    $("#tableNum" + tableNum).show();
}
