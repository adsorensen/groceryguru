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
//= require sweetalert2
//= require sweet-alert2-rails
//= require_tree .
//= require bootstrap
// require 'open-uri'
// require 'hangry'

function searchFunction() {
   var input, filter, content, error, recipes, recipe, i, count;
   input = document.getElementById("recipe-search");
   filter = input.value.toUpperCase();
   error = document.getElementById("none_found_message");
   content = document.getElementById("content");
   recipes = content.getElementsByClassName("recipe");
   count = 0;

   if (filter === "") {
      content.style.display = "none";
   }
   else {
      for (i = 0; i < recipes.length; i++) {
         recipe = recipes[i].getElementsByClassName("name")[0];
         if (recipe) {
            content.style.display = "";
            error.style.display = "none";
            if (recipe.innerHTML.toUpperCase().indexOf(filter) > -1) {
               recipes[i].style.display = "";
               count++;
            }
            else {
               recipes[i].style.display = "none";
            }
         }
      }
      if (count == 0) {
         error.style.display = "";
         error.innerHTML = "<p>There are no recipes containing the term: <strong>" + String(input.value) + "</strong></p>";
      }
   }
}

function calendarSearchFunction() {
   var input, filter, content, error, recipes, recipe, searchLabel, i, count;
   input = document.getElementById("calendar-search");
   filter = input.value.toUpperCase();
   error = document.getElementById("none_found_message");
   content = document.getElementById("external-events-listing-1");
   recipes = content.getElementsByClassName("recipe");
   searchLabel = document.getElementById("search-results-label")
   count = 0;

   if (filter === "") {
      content.style.display = "none";
   }
   else {
      for (i = 0; i < recipes.length; i++) {
         recipe = recipes[i].getElementsByClassName("fc-event")[0];
         if (recipe) {
            content.style.display = "";
            searchLabel.style.display = "";
            error.style.display = "none";
            if (recipe.innerHTML.toUpperCase().indexOf(filter) > -1) {
               recipes[i].style.display = "";
               count++;
            }
            else {
               recipes[i].style.display = "none";
            }
         }
      }
      if (count == 0) {
         error.style.display = "";
         searchLabel.style.display = "none";
         error.innerHTML = "<h4>There are no recipes containing the term: <strong>" + String(input.value) + "</strong></h4>";
      }
   }
}

function printpage() {
   window.print()
}

function openPopup() {
   swal({
      type: "success",
      title: "Recipe has been saved!"
   });
}

function showAlert() {
   if ($("#name").val().length != 0 && $("#email").val().length != 0 && $("#body").val().length != 0) {
      swal({
         type: "success",
         title: "Your message was sent!",
         showConfirmButton: false,
         timer: 2500
      });
   }
}


function showIngredients() {
   document.getElementById('instructions').style.display = "none"
   document.getElementById('ingredients').style.display = "block"
   document.getElementById('reviews').style.display = "none"
   document.getElementById("tab_ing").className = "active"
   document.getElementById("tab_inst").className = ""
   document.getElementById("tab_rev").className = ""
}

function showInstructions() {
   document.getElementById('instructions').style.display = "block"
   document.getElementById('ingredients').style.display = "none"
   document.getElementById('reviews').style.display = "none"
   document.getElementById("tab_ing").className = ""
   document.getElementById("tab_inst").className = "active"
   document.getElementById("tab_rev").className = ""
}

function showReviews() {
   document.getElementById('instructions').style.display = "none"
   document.getElementById('ingredients').style.display = "none"
   document.getElementById('reviews').style.display = "block"
   document.getElementById("tab_ing").className = ""
   document.getElementById("tab_inst").className = ""
   document.getElementById("tab_rev").className = "active"
}

function newPlan() {
   swal({
      title: 'Enter a Meal Plan Title',
      input: 'text',
      inputPlaceholder: 'Meal Plan',
      html: '<input type="radio" name="private" id="priv"> Private<br>' +
         '<input type="radio" name="private" checked="checked" id="pub"> Public<br>',
      showCancelButton: true,
      showCloseButton: true,
      confirmButtonText: 'Create',
      showLoaderOnConfirm: true,
      allowOutsideClick: () => !swal.isLoading(),
   }).then(function(value) {
      if (value.length == 0) {
         swal({
            type: "error",
            title: "The title cannot be left blank!",
         }).then(function(e) {
            newPlan();
         })
      }
      else {
         var pri = false;
         if ($('#priv').is(':checked'))
            pri = true;
         $.ajax({
            type: "POST",
            url: "/mealplans",
            data: {
               name: value,
               priv: pri
            },
            success: function(data) {
               swal({
                  type: 'success',
                  title: 'Meal plan successfully created!',
                  showConfirmButton: false,
                  timer: 1500
               });
               window.setTimeout(refresh, 1500);
            }
         });
      }
   });
}

function mealPlan() {
   swal({
      title: 'Meal Plan Menu',
      showCancelButton: true,
      showCloseButton: true,
      showConfirmButton: false,
      html: '<br><button id="new" class=\'btn btn-outline\'>New Meal Plan</button>' +
         '<br><br>' +
         '<button id="add" class=\'btn btn-outline\'>Add to Existing</button>',

   });

   $("#new").on("click", function() {
      swal({
         title: 'Enter a Meal Plan name',
         input: 'text',
         inputValue: 'New Meal Plan',
         html: '<input type="radio" name="private" id="priv">Private<br>' +
            '<input type="radio" name="private" checked="checked" id="pub">Public<br>',
         showCancelButton: true,
         showCloseButton: true,
         confirmButtonText: 'Create',
         showLoaderOnConfirm: true,
         allowOutsideClick: () => !swal.isLoading(),
      }).then(function(value) {
         var url = $(location).attr('href');
         url = url.split('/');
         var recipeID = url[url.length - 1];
         var pri = false;
         if ($('#priv').is(':checked'))
            pri = true;
         $.ajax({
            type: "POST",
            url: "/mealplans",
            data: {
               name: value,
               priv: pri,
               recipe: recipeID
            },
            success: function(data) {
               swal({
                  type: 'success',
                  title: 'Recipe added to new Meal Plan!',
                  showConfirmButton: false,
                  timer: 1500
               });
            }
         });
      });
   });

   $("#add").on("click", function() {
      var selections = null;
      var inputOptionsPromise = new Promise(function(resolve) {
         $.ajax({
            type: "POST",
            url: "/userplans",
            success: function(data) {
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
         title: 'Pick a plan to add to',
         input: 'select',
         inputOptions: inputOptionsPromise,
         showCancelButton: true,
         showCloseButton: true,
         confirmButtonText: 'Add Recipe',
      }).then(function(result) {
         var url = $(location).attr('href');
         url = url.split('/');
         var recipeID = url[url.length - 1];
         $.ajax({
            type: "POST",
            url: "/addtoplan",
            data: {
               id: result,
               recipe: recipeID
            },
            success: function(data) {
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

function startJob() {
   var user = $("#jobBtn").data('session');
   alert("Job starting" + user);
   $.ajax({
      type: "POST",
      url: "https://groceryguru-docrosco.c9users.io:8081",
      data: {
         userId: user,
         store: 'walmart'
      },
      success: function(data) {
         alert("Job Sent");
      }
   });
}
