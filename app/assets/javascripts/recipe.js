// Add Ingredient onClick event
$('document').ready(function() {
    var count = 1;
    $("#addIngredient").unbind().click(function(event) { // unbind makes this only be called once
        document.getElementById("header").style.display = 'block';
        var newRow =
            '<tr>' +
            '<td><input type="number" name="quantity' + count + '"/></td>' +
            '<td><input type="text" name="unit' + count + '"/></td>' +
            '<td><input type="text" name="ingredient' + count + '"/></td>' +
            '<td><input type="text" name="prep' + count + '"/></td>' +
            '</tr>';
        count++;
        $("#ingredients").append(newRow);
    });
});

function reviewEdit(id, oldReview, recipeId) {
    swal({
        title: 'Edit your review',
        input: 'text',
        inputValue: oldReview,
        html: '<p>Rating:</p>' +
            '<fieldset class="rating">' +
            '<input type="radio" id="star5" name="rating" value="5" /><label class = "full" for="star5" title="Awesome - 5 stars"></label>' +
            '<input type="radio" id="star4" name="rating" value="4" /><label class = "full" for="star4" title="Pretty good - 4 stars"></label>' +
            '<input type="radio" id="star3" name="rating" value="3" /><label class = "full" for="star3" title="Meh - 3 stars"></label>' +
            '<input type="radio" id="star2" name="rating" value="2" /><label class = "full" for="star2" title="Kinda bad - 2 stars"></label>' +
            '<input type="radio" id="star1" name="rating" value="1" /><label class = "full" for="star1" title="Really bad - 1 star"></label>' +
            '</fieldset>',
        showCancelButton: true,
        showCloseButton: true,
        confirmButtonText: 'Update',
        showLoaderOnConfirm: true,
        allowOutsideClick: () => !swal.isLoading(),
    }).then(function(value) {
        var rate = 1;
        if ($('#star1').is(':checked'))
            rate = 1;
        if ($('#star2').is(':checked'))
            rate = 2;
        if ($('#star3').is(':checked'))
            rate = 3;
        if ($('#star4').is(':checked'))
            rate = 4;
        if ($('#star5').is(':checked'))
            rate = 5;
        $.ajax({
            type: 'POST',
            url: "/recipes/edit_review",
            data: {
                id: id,
                text: value,
                recipe_id: recipeId,
                newRate: rate
            },
            dataType: "json",
            success: function(data) {
                swal({
                    type: 'success',
                    title: 'Review updated successfully',
                    showConfirmButton: false,
                    timer: 1500
                });
                window.setTimeout(refresh, 2000);
            }
        });
    });
}

function refresh() {
    window.location.href = window.location.href;
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
    $('#ingredients tr').each(function() {
        var count = 1;
        var row = [];
        $(this).find('td').each(function() {
            if (count == 1) {
                row["quantity"] = $(this);
                count++;
            }
            else if (count == 2) {
                row["unit"] = $(this);
                count++;
            }
            else if (count == 3) {
                row["ingredient"] = $(this);
                count++;
            }
            else if (count == 4) {
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
        success: function(data) { alert(data); }
    });
}

function showReviewForm() {
    document.getElementById('new-review').style.display = "block"
}

function showNutritionalFacts() {

}

function importField(value) {
    var text = window.getSelection().toString();
    if (text.length == 0) {
        swal('Oops...', 'Something went wrong!\nMake sure you have highlighted text on the left!', 'error')
    }
    else {
        if (value === 'title') {
            if (text.length > 70) {
                if (!/\d/.test(text)) {
                    swal('Oops...', 'Something went wrong!\nTitle length should be no more than 70 characters!', 'error')
                }
            }
            else {
                document.getElementById('title').value = text;
            }
        }
        if (value === 'desc') {
            document.getElementById('description').value = text;
        }
        if (value === 'directions') {
            document.getElementById('directions').value = text;
        }
        if (value === 'ingr') {
            document.getElementById('ingr').value = text;
        }
        if (value === 'time-to-cook') {
            var re = new RegExp("^(\d+\s*(hours|hour|hrs|hr|h)(\s*\d+\s*(minutes|minute|mins|min|m))*)$");
            if (!/\d/.test(text)) {
                swal('Oops...', 'Something went wrong!\nTotal prep + cook time must include a number!', 'error')
            }
            else if (/^(\d+\s*(hours|hour|hrs|hr|h)(\s*\d+\s*(minutes|minute|mins|min|m))*)$/.test(text.toLowerCase())) {
                var conversion = convertToMinutes(text)
                swal({
                    title: 'Convert to Minutes?',
                    text: 'Total time must be represented in minutes!\n\nYour input: ' + text + '\nConverted minutes: ' + conversion,
                    type: 'question',
                    confirmButtonColor: '#5cdb95',
                    showCancelButton: true,
                    confirmButtonText: 'Yes, convert it!',
                    cancelButtonText: 'No, I\'ll try again'
                }).then(function(e) {
                    document.getElementById('time-to-cook').value = conversion;
                })
            }
            else if (/^(\d+\s*(minutes|minute|mins|min|m))$/.test(text)) {
                var m = text.match(/\d+\s*?(?=min|minutes|m|mins|minutes)/g);
                document.getElementById('time-to-cook').value = parseInt(m);
            }
            else if (/^\d+$/.test(text)) {
                document.getElementById('time-to-cook').value = text;
            }
            else {
                swal('Incorrect Format!', 'Please make sure you have highlighted \nthe total prep + cook time!', 'error')
            }
        }
        if (value === 'servings') {
            if (!/\d/.test(text)) {
                swal('Oops...', 'Something went wrong!\nServing size must include a number!', 'error')
            }
            else if (/^\d+\s*(servings|serving|svgs|svg|s)$/.test(text)) {
                var s = text.match(/\d+\s*?(?=servings|servings|svgs|svg|s)/g);
                document.getElementById('servings').value = parseInt(s);
            }
            else if (/^\d+$/.test(text)) {
                document.getElementById('servings').value = text;
            }
            else if (/^\d+\s*-\s*\d+$/.test(text) || /^\d+\s*(-|to)\s*\d+\s*(servings|servings|svgs|svg|s)$/.test(text)) {
                if (text.includes("-")) {
                    var min = parseInt(text.split('-')[0]);
                    var max = parseInt(text.split('-')[1]);
                }
                else if (text.includes("to")) {
                    var min = parseInt(text.split('to')[0]);
                    var max = parseInt(text.split('to')[1]);
                }
                swal({
                    title: 'Serving Size Cannot Be a Range',
                    text: 'Your input: ' + text + '\n\nPlease select a single value:',
                    type: 'warning',
                    input: 'range',
                    showCancelButton: true,
                    inputAttributes: {
                        min: min,
                        max: max,
                        step: 1
                    },
                    inputValue: Math.floor((min + max) / 2)
                }).then(function(e) {
                    document.getElementById('servings').value = e;
                })
            }
            else {
                swal('Incorrect Format!', 'Please make sure you have highlighted the \nimport the serving size!', 'error')
            }
        }
        if (value === 'source') {
            document.getElementById('source').value = text;
        }
    }
}

function convertToMinutes(value) {
    var hours = value.split("h")[0];
    var hrs = parseInt(hours);
    if (value.includes('m')) {
        var m = value.match(/\d+\s*?(?=min|minutes|m|mins|minutes)/g);
    }
    else {
        m = 0;
    }
    return (hrs * 60 + parseInt(m));
}

$(document).ready(function() {
    $('[data-toggle="tooltip"]').tooltip();
});

$(document).ready(function() {
    $('form').on('submit', function(e) {
        document.getElementById('title').classList.remove("error");
        document.getElementById('title-label').classList.remove("error");
        document.getElementById('ingr').classList.remove("error");
        document.getElementById('ingr-label').classList.remove("error");
        document.getElementById('directions').classList.remove("error");
        document.getElementById('directions-label').classList.remove("error");
        document.getElementById('servings').classList.remove("error");
        document.getElementById('servings-label').classList.remove("error");
        document.getElementById('time-to-cook').classList.remove("error");
        document.getElementById('time-label').classList.remove("error");
        var ingredients = document.getElementById('ingr').value;
        var valid = true;
        var errors = "";
        if (document.getElementById('title').value.length == 0) {
            valid = false;
            errors += 'Please fill out the title field!\n';
            document.getElementById('title').classList.add('error');
            document.getElementById('title-label').classList.add('error');
        }
        if (document.getElementById('ingr').value.length == 0) {
            valid = false;
            errors += 'Please fill out the ingredients field!\n';
            document.getElementById('ingr').classList.add('error');
            document.getElementById('ingr-label').classList.add('error');
        }
        else {
            if (!validateIngredients(ingredients)) {
                valid = false;
                errors += '\nMake sure ingredients are formatted correctly!\n*Hover over the info icon for help!\n\n';
                document.getElementById('ingr').classList.add('error');
                document.getElementById('ingr-label').classList.add('error');
            }
            else {
                parseIngredients(document.getElementById('ingr').value);
            }
        }
        if (document.getElementById('directions').value.length == 0) {
            valid = false;
            errors += 'Please fill out the directions field!\n';
            document.getElementById('directions').classList.add('error');
            document.getElementById('directions-label').classList.add('error');
        }
        if (document.getElementById('servings').value.length != 0 && !/^\d+$/.test(document.getElementById('servings').value)) {
            valid = false;
            errors += 'The servings field must only contain numbers!\n';
            document.getElementById('servings').classList.add('error');
            document.getElementById('servings-label').classList.add('error');
        }
        if (document.getElementById('time-to-cook').value.length != 0 && !/^\d+$/.test(document.getElementById('time-to-cook').value)) {
            valid = false;
            errors += 'The total time field must only contain numbers!\n';
            document.getElementById('time-to-cook').classList.add('error');
            document.getElementById('time-label').classList.add('error');
        }

        if (!valid) {
            e.preventDefault();
            swal('Failed to Add Recipe!', errors, 'error')
        }
    });
});

function validateIngredients(text) {
    var matches = true;
    var lines = text.split('\n');
    for (var i = 0; i < lines.length; i++) {
        if (!/^((\d+\s*\d*\/\d+|\d+){1}\s*\w*\s*[A-Za-z\s]+(,\s*.+)*)$/.test(lines[i])) {
            matches = false;
            break;
        }
    }
    return matches;
}

function parseIngredients(text) {
    var lines = text.split('\n');
    for (var i = 0; i < lines.length; i++) {
        var unit = "";
        var ingredient = "";
        var prep = "";
        var quantity = lines[i].match(/(\d+\s*\d*\/\d+|\d+)/g);
        var amount = "";


        // Matching mixed fractions
        if (/\d+\s\d+\/\d+/g.test(quantity)) {
            var f = String(quantity).split(" ")[0];
            var s = String(quantity).split(" ")[1];
            var numerator = String(s).split("/")[0];
            var denominator = String(s).split("/")[1];
            var newNumerator = parseInt(denominator) * parseInt(f) + parseInt(numerator);
            quantity = parseInt(newNumerator) / parseInt(denominator);
        }

        // Matching fractions
        if (/\d+\/\d+/g.test(quantity)) {
            var numerator = String(quantity).split("/")[0];
            var denominator = String(quantity).split("/")[1];
            quantity = parseInt(numerator) / parseInt(denominator);
        }

        // Matching single quantity
        if (/\d+/g.test(quantity)) {
            quantity = quantity;
        }

        if (lines[i].includes(",")) {
            prep = lines[i].substring(lines[i].indexOf(",") + 1, lines[i].length)
            prep = prep.trim()

            var unit_or_ing = lines[i].substring(amount.length + 1, lines[i].indexOf(","))
            unit_or_ing = unit_or_ing.trim()
            var firstWord = unit_or_ing.split(" ")[0]
            if (isUnit(String(firstWord))) {
                unit = firstWord;
                ingredient = unit_or_ing.substring(firstWord.length + 1, unit_or_ing.length)
            }
            else {
                ingredient = unit_or_ing
            }
        }
        else {
            amount = lines[i].match(/(\d+\s*\d*\/\d+|\d+)/g);
            var unit_or_ing = lines[i].substring(String(amount).length + 1, lines[i].length)
            unit_or_ing = unit_or_ing.trim()
            var firstWord = unit_or_ing.split(" ")[0]
            if (isUnit(String(firstWord))) {
                unit = firstWord;
                ingredient = unit_or_ing.substring(firstWord.length + 1, unit_or_ing.length)
            }
            else {
                ingredient = unit_or_ing
            }
        }

        var newIndex = parseInt(i) + 1
        var newRow =
            '<tr>' +
            '<td><input type="number" value=' + parseFloat(quantity) + ' name="quantity' + newIndex + '"/></td>' +
            '<td><input type="text" value=\'' + unit + '\' name="unit' + newIndex + '"/></td>' +
            '<td><input type="text" value=\'' + ingredient + '\' name="ingredient' + newIndex + '"/></td>' +
            '<td><input type="text" value=\'' + prep + '\' name="prep' + newIndex + '"/></td>' +
            '</tr>';
        $("#ingredients").append(newRow);
    }
}

function isUnit(input) {
    var units = ['oz', 'cups', 'pound', 'teaspoons', 'cup', 'tablespoon', 'pounds', 'ounce', 'ounces', 'cloves', 'teaspoon', 'servings', 'Bunch', 'tbsp', 'piece', 'tsp', 'g', 'handfuls', 'handful', 'Tbs', 'slices', 'tablespoons', 'packet', 'pieces', 'serving', 'can', 'lb', 'heads', 'lbs', 'chunks', 'dashes', 'c', 'head', 'sprigs', 'pinch', 'dash', 'pint', 'cans', 'clove', 'leaves', 'pinches', 'stalks', 'box', 'strips', 'Tb', 'stalk', 'kg', 'bag', 'sprig', 'inch', 'ml', 'carton'];
    units.map(function(x) { return x.toLowerCase() })
    return (units.includes(String(input).toLowerCase()));
}

$(document).ready(function urlPressedEnter() {
    $('#url-text-box').keypress(function(e) {
        if (e.keyCode == 13) {
            parseUrl()
        }
    });
});

function parseUrl() {
    var url = $('#url-text-box').val()
    if (!/https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/g.test(url)) {
        swal('Failed to Parse!', 'Please paste a URL in the box in the appropriate format!\n\nAll URLs must begin with HTTP:// or HTTPS://', 'error')
    }
    else {
        swal({
            title: 'Please Wait...',
            text: 'The Gurus are hard at work importing your recipe!',
            showConfirmButton: true,
            allowOutsideClick: false,
            allowEscapeKey: false,
            allowEnterKey: false,
            onOpen: () => {
                swal.showLoading()
            }
        })
        $.ajax({
            type: 'POST',
            url: "/recipes/url_parse",
            data: {
                url: url
            },
            success: function(result) {
                swal.hideLoading()
                            },
            error: function(result) {
                swal.hideLoading()
                swal({
                    title: "We're Sorry..",
                    text: "The Gurus were unable to parse your recipe due to formatting issues. Please try our point and click tool instead!",
                    type: "error",
                    showCancelButton: true,
                    reverseButtons: true,
                    cancelButtonText: 'Never Mind',
                    confirmButtonText: 'Go There Now!',
                }).then(function(e) {
                    window.location.href = "/recipes/text";
                })
            }
        });
    }
}
