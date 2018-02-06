// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require sweetalert2
//= require sweet-alert2-rails
//= require_tree .
//= require bootstrap


function printpage()
{
   window.print()
}

function openPopup()
{
    alert("Recipe Has Been Saved");
}

function addReview()
{
    
}

function showIngredients()
{
   document.getElementById('instructions').style.display = "none"
   document.getElementById('ingredients').style.display = "block"
   document.getElementById('reviews').style.display = "none"
   document.getElementById("tab_ing").className = "active"
   document.getElementById("tab_inst").className = ""
   document.getElementById("tab_rev").className = ""
}

function showInstructions()
{
   document.getElementById('instructions').style.display = "block"
   document.getElementById('ingredients').style.display = "none"
   document.getElementById('reviews').style.display = "none"
   document.getElementById("tab_ing").className = ""
   document.getElementById("tab_inst").className = "active"
   document.getElementById("tab_rev").className = ""
}

function showReviews()
{
   document.getElementById('instructions').style.display = "none"
   document.getElementById('ingredients').style.display = "none"
   document.getElementById('reviews').style.display = "block"
   document.getElementById("tab_ing").className = ""
   document.getElementById("tab_inst").className = ""
   document.getElementById("tab_rev").className = "active"
}

function mealPlan() 
{
   swal({
      title: 'Meal Plan Menu',
      showCancelButton: true,
      showCloseButton: true,
      showConfirmButton: false,
      html:
            '<button id="new">New Meal Plan</button>'+
            '<p>&nbsp;</p>'+
            '<button id="add">Add to Existing</button>',

   });
   
   $("#new").on("click", function() {
         swal({
         title: 'Enter a Meal Plan name',
         input: 'text',
         inputValue: 'New Meal Plan',
         showCancelButton: true,
         showCloseButton: true,
         confirmButtonText: 'Create',
         showLoaderOnConfirm: true,
         allowOutsideClick: () => !swal.isLoading(),
      }).then(function(value) {
         $.ajax(
            {
               type: "POST",
               url: "/mealplans",
               data: "name="+value,
               success: function(data){
                  swal({
                     type: 'success',
                     title: 'Meal Plan Created!',
                     showConfirmButton: false,
                     timer: 1500
                  });
               }
            }
         );
      });
   });
   
   $("#add").on("click", function() {
      var selections = null;
      var inputOptionsPromise = new Promise(function(resolve) {
         $.ajax({
            type: "POST",
            url: "/userplans",
            success: function(data){
               selections = data;
            }
         });
         
         setTimeout(function() {
            var options = {};
           $.map(selections,
               function(o) {
                   options[o.id] = o.name;
               });
            resolve(options);
         }, 1000);
      });
      
      swal({
         title: 'Which Plan do you want to add to?',
         input: 'select',
         inputOptions: inputOptionsPromise,
         showCancelButton: true,
         showCloseButton: true,
         confirmButtonText: 'Add Recipe',
      }).then(function(result){
         var url = $(location).attr('href');
         url = url.split('/');
         var recipeID = url[url.length-1];
         $.ajax({
            type: "POST",
            url: "/addtoplan",
            data: 
            {
               id: result,
               recipe: recipeID
            },
             success: function(data){
                swal({
                  type: 'success',
                  title: 'Recipe added',
                  showConfirmButton: false,
                  timer: 1500
                });
             }
         });
      });
   }); 
}