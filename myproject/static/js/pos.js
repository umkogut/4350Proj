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
      }
    });
  });
});
