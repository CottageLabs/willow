Blacklight.onLoad(function () {

    // This javascript modifies the collection form's CSRF token if it does not match the page's CSRF token.
    // It is a work-around for issue https://github.com/samvera/hyrax/issues/1191

    $('[data-behavior="updates-collection"]').on('click', function() {
        var form = $(this).closest("form");
        var form_authenticity_token = form.find(":input[name='authenticity_token']");
        var header_authenticity_token = $("meta[name='csrf-token']").attr('content');
        if (form_authenticity_token.attr('value') != header_authenticity_token) {
            form_authenticity_token.attr('value', header_authenticity_token);
        }
    });
});
