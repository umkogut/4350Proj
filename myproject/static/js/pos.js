$(function() {
  $('input:checkbox').bind('change',function() {
    $('#'+this.id+'_lb').toggle($(this).is(':checked'));
  });
 
  $("#pay").click(function() {
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

       var itemsToPayFor = JSON.stringify({
	'table':tableNum,
	'menuItem':itemNum,
	'group':groupNum,
	'order':orderNum
        });

       $.post('/payForItems.json', itemsToPayFor, function(data) {}, "json");
      }
    });
  });
});

function displayTableBill(tableNum) {
    $(".tab-pane").hide();
    $("#tableNum" + tableNum).show();
}
