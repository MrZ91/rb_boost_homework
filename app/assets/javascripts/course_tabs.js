var do_on_load = function() {
    $('ul.nav a[href="' + window.location.hash + '"]').tab('show')
};

$(document).ready(do_on_load);
