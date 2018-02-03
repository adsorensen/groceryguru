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
   document.getElementById('title').textContent = "Ingredients"
   document.getElementById('instructions').style.display = "none"
   document.getElementById('ingredients').style.display = "block"
   document.getElementById('reviews').style.display = "none"
}

function showInstructions()
{
   document.getElementById('title').textContent = "Instructions"
   document.getElementById('instructions').style.display = "block"
   document.getElementById('ingredients').style.display = "none"
   document.getElementById('reviews').style.display = "none"
}

function showReviews()
{
   document.getElementById('title').textContent = "Reviews"
   document.getElementById('instructions').style.display = "none"
   document.getElementById('ingredients').style.display = "none"
   document.getElementById('reviews').style.display = "block"
}