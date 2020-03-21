$(document).ready(function() {
    $(".simple_form.withdraw").submit(function(event) {
        //var data = $(this).serializeFormJSON();
        var data = {
            account_number: $("#withdraw_account_number").val(),
            value: $('#withdraw_value').val()
        };

        event.preventDefault();
        $.ajax({
            type:     'POST',
            url:      '/transactions/withdraw',
            data:     data,
            dataType: 'json',
            encode:   true
        }).done(function(data) {
            if (data['success?'] == true) {
                toastr.success(data.message);
            } else {
                toastr.error(data.message);
            }
        }).fail(function(data) {
            console.log(data);
            toastr.error(data.message);
        });

    });

    $(".simple_form.deposit").submit(function(event) {
        //var data = $(this).serializeFormJSON();
        var data = {
            account_number: $("#deposit_account_number").val(),
            value: $('#deposit_value').val()
        };

        event.preventDefault();
        $.ajax({
            type:     'POST',
            url:      '/transactions/deposit',
            data:     data,
            dataType: 'json',
            encode:   true
        }).done(function(data) {
            if (data['success?'] == true) {
                toastr.success(data.message);
            } else {
                toastr.error(data.message);
            }
        }).fail(function(data) {
            toastr.error(data.message);
        });
        $('#depositModal').modal('hide');

    });

    $(".simple_form.transfer").submit(function(event) {
        var data = {
            account_from: $("#transfer_account_number").val(),
            account_to: $("#transfer_account_to").val(),
            value: $('#transfer_value').val()
        };

        event.preventDefault();
        $.ajax({
            type:     'POST',
            url:      '/transactions/transfer',
            data:     data,
            dataType: 'json',
            encode:   true
        }).done(function(data) {
            if (data['success?'] == true) {
                toastr.success(data.message);
            } else {
                toastr.error(data.message);
            }
        }).fail(function(data) {
            toastr.error(data.message);
        });
    });
})
