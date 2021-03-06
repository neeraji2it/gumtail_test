
$(document).ready(function() {
    frSearch();
});

function frSearch() {

    $("#fr_search").keyup(function() {
        // When value of the input is not blank
        if ($(this).val() != "")
        {
            // Show only matching TR, hide rest of them
            $("#friends-table").show();
            $("#friends-table tbody>tr").hide();
            $("#friends-table td:contains-ci('" + $(this).val() + "')").parent("tr").show();
        }
        else
        {
            // When there is no input or clean again, show everything back
            $("#friends-table").hide();
            $("#friends-table tbody>tr").show();
        }
    });

}
// jQuery expression for case-insensitive filter
$.extend($.expr[":"],
        {
            "contains-ci": function(elem, i, match, array)
            {
                return (elem.textContent || elem.innerText || $(elem).text() || "").toLowerCase().indexOf((match[3] || "").toLowerCase()) >= 0;
            }
        });
