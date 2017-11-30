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
    // var json = "{\"table\": [{";
    $('#ingredients tr').each(function(){
        //  var count = 1
        var row = [];
        $(this).find('td').each(function(){
            // if(count == 1){
            //     json += "quantity\" : \"" + $(this) + "\"},{";
            //     count++;
            // }
            // if(count == 2){
            //     json += "unit\" : \"" + $(this) + "\"},{";
            //     count++;
            // }
            // if(count == 3){
            //     json += "ingredient\" : \"" + $(this) + "\"},{";
            //     count++;
            // }
            // if(count == 4){
            //     json += "prep\" : \"" + $(this) + "\"},{";
            //     count = 1;
            // }
            row.append($(this));
        });
        table.append(row);
    });
    // json += "]}";
    
    var request  = JSON.stringify(table)
    
    // $.ajax(url: "recipes/new");
}