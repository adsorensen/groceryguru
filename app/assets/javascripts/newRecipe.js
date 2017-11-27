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

function tableSave() {
    var table = [];
    
    $('#ingredients tr').each(function(){
         var row = [];
        $(this).find('td').each(function(){
            //do your stuff, you can use $(this) to get current cell
            row.push($(this));
        })
        table.push(row);
    })
}