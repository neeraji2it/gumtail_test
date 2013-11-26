function openOffersDialog(us_name, tw_id) {
    $('#overlay').fadeIn('fast', function() {
        $('#boxpopup').css('display', 'block');
        $('#boxpopup').animate({'left': '30%'}, 500);
        $("#username").val(us_name);
        $("#twitter_id").val(tw_id);
    });
}

function delete_product() {
    $('#overlay').fadeIn('fast', function() {
        $('#boxpopup').css('display', 'block');
        $('#boxpopup').animate({'left': '30%'}, 500);
    });
}

function closeOffersDialog(prospectElementID) {
    $(function($) {
        $(document).ready(function() {
            $('#boxpopup').css('display', 'none');
            $('#' + prospectElementID).css('position', 'absolute');
            $('#' + prospectElementID).animate({'left': '-100%'}, 500, function() {
                $('#' + prospectElementID).css('position', 'fixed');
                $('#' + prospectElementID).css('left', '100%');
                $('#overlay').fadeOut('fast');
            });
        });
    });
}

function signup_form() {
    $("#login_form").slideUp("slow");
    $("#registration").slideDown("slow");
}
function signin_form() {
    $("#registration").slideUp("slow");
    $("#login_form").slideDown("slow");
}

function hide_div() {
    $("#registration").slideUp("slow");
    $("#login_form").slideUp("slow");
}