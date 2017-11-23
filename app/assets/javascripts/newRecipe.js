$('document').ready(function() {
    var count = 1;
    $("#addIngredient").unbind().click(function(event){ // unbind makes this only be called once
        var newRow =
            '<tr>'+
                '<td><input type="number" name="quantity'+count+'"/></td>' +
                '<td><input type="text" name="unit'+count+'"/></td>' +
                '<td><input type="text" name="ingredient'+count+'"/></td>' +
                '<td><input type="text" name="prep'+count+'"/></td>' +
            '</tr>';
            count++;
        $("#ingredients").append(newRow);
    });
});