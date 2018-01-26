// Add Ingredient onClick event
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

function reviewEdit(id, oldReview, recipeId){
    var x;
    var newReview = prompt("Edit your review", oldReview);
    
    $.ajax({
        type: 'POST',
        url: "/recipes/edit_review",
        data: {
            id: id,
            text: newReview,
            recipe_id: recipeId
        },
        dataType: "json",
        success: function(){ 
            window.location.href=window.location.href;
            alert("Review updated successfully"); 
        }
    });
}



//***********************
// Pretty sure these functions aren't being used. -T
//***********************


// Create onClick event
// $('document').ready(function() {
//      $("#create").unbind().click(tableSave());
// }); 


function tableSave() {
    var table = [];
    
    // Create an associative array for each row in the ingredients table
    $('#ingredients tr').each(function(){
        var count = 1;
        var row = [];
        $(this).find('td').each(function(){
            if(count == 1){
                row["quantity"] = $(this);
                count++;
            }
            else if(count == 2){
                row["unit"] = $(this);
                count++;
            }
            else if(count == 3){
                row["ingredient"] = $(this);
                count++;
            }
            else if(count == 4){
                row["prep"] = $(this);
                count = 1;
            }
        });
        table.append(row);
    });
    
    // Post the full array to the recipes controller
    $.ajax({
        type: 'POST',
        url: "/recipes/new",
        data: JSON.stringify(table),
        dataType: "json",
        success: function(data){ alert(data); }
    });
}