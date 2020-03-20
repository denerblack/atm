$(document).ready(function(){
    $("#accountForm").on("change", "input:checkbox", function(){
        $("#accountForm").submit();
    });
});
