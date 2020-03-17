$(document).ready(function() {
    $(".simple_form.withdraw").submit(function(event) {
        console.log(this);
        //var data = $(this).serializeFormJSON();
        var data = {
            account_number: $("#withdraw_account_number").val(),
            value: $('#withdraw_value').val()
        };

        $.ajax({
            type:     'POST',
            url:      '/transactions/withdraw',
            data:     data,
            dataType: 'json',
            encode:   true
        })

        event.preventDefault();
    });

    $(".simple_form.deposit").submit(function(event) {
        console.log(this);
        //var data = $(this).serializeFormJSON();
        var data = {
            account_number: $("#deposit_account_number").val(),
            value: $('#deposit_value').val()
        };
        console.log(data);

        $.ajax({
            type:     'POST',
            url:      '/transactions/deposit',
            data:     data,
            dataType: 'json',
            encode:   true
        })

        event.preventDefault();
    });

    $(".simple_form.transfer").submit(function(event) {
        console.log(this);
        //var data = $(this).serializeFormJSON();
        var data = {
            account_from: $("#transfer_account_number").val(),
            account_to: $("#transfer_account_to").val(),
            value: $('#transfer_value').val()
        };
        console.log(data);

        $.ajax({
            type:     'POST',
            url:      '/transactions/transfer',
            data:     data,
            dataType: 'json',
            encode:   true
        })

        event.preventDefault();
    });


})
