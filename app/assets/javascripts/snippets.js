$(document).ready(function() {
    var $readonly = $('input[readonly="readonly"]');
    $readonly.focus(function() {
        $(this).select();
    });
    $readonly.click(function() {
        $(this).select();
    });
    $('a[data-method="delete"]').on("ajax:complete", function(data, status, xhr) {
        if (status.status < 300) {
            $(this).closest("dd").slideUp("slow", function () {
                var $dd = $(this);
                $dd.prev("dt").slideUp("slow", function() {
                    $dd.remove();
                    $(this).remove();
                })
            });
        } else {
            alert("Something wrong happened!");
        }
    });
    $('a[data-method="post"]').on("ajax:success", function(data, status, xhr) {
        $(this).closest("p").find(".count").text(status.count);
    });
});
