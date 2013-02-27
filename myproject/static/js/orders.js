$(function() {
        $(".appetizer").change(function() {
                if ($('.appetizer:checked').length == $('.appetizer').length) {
                        $('.entree').attr("disabled", false);

                        if ($('.entree:checked').length == $('.entree').length) {
                                $('.dessert').attr("disabled", false);
                        }
                } else {
                        $('.entree').attr("disabled", true);
                        $('.dessert').attr("disabled", true);
                }
        });
        $(".entree").change(function() {
                if ($('.entree:checked').length == $('.entree').length) {
                        $('.dessert').attr("disabled", false);
                } else {
                        $('.dessert').attr("disabled", true);
                }
        });
});
