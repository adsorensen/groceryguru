// Add Ingredient onClick event
$('document').ready(function() {
    var count = 1;
    $("#addIngredient").unbind().click(function(event){ // unbind makes this only be called once
        document.getElementById("header").style.display = 'block';
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

function reviewEdit(id, oldReview, recipeId)
{
    swal(
    {
        title: 'Edit your review',
        input: 'text',
        inputValue: oldReview,
        showCancelButton: true,
        showCloseButton: true,
        confirmButtonText: 'Update',
        showLoaderOnConfirm: true,
        allowOutsideClick: () => !swal.isLoading(),
    }).then(function(value) {
         $.ajax(
            {
               type: 'POST',
                url: "/recipes/edit_review",
                data: {
                    id: id,
                    text: value,
                    recipe_id: recipeId
                },
                dataType: "json",
               success: function(data){
                  swal({
                     type: 'success',
                     title: 'Review updated successfully',
                     showConfirmButton: false,
                     timer: 1500
                  });
                  window.setTimeout(refresh, 2000);
               }
            }
         );
      });
}
function refresh()
{
    window.location.href=window.location.href;
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

function showReviewForm()
{
   document.getElementById('new-review').style.display = "block"
}

function showNutritionalFacts()
{
    
}

function importField(value)
{
    if (value === 'title') {
        document.getElementById('title').value = window.getSelection().toString();
    }
     if (value === 'desc') {
        document.getElementById('description').value = window.getSelection().toString();
    }
     if (value === 'directions') {
        document.getElementById('directions').value = window.getSelection().toString();
    }
     if (value === 'ingr') {
        document.getElementById('title').value = window.getSelection().toString();
    }
     if (value === 'time-to-cook') {
        document.getElementById('time-to-cook').value = window.getSelection().toString();
    }
    if (value === 'servings') {
        document.getElementById('servings').value = window.getSelection().toString();
    }
    if (value === 'source') {
        document.getElementById('source').value = window.getSelection().toString();
    }
}