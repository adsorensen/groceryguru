function getPictureUrl(url) {
    if (url.includes('http')) {
        url = url.substring(url.indexOf("http"), url.length)
        if (url.includes("%3A")) {
            url = url.replace("%3A", ":/");
        }
    }
    return url;
}

var calEventStatus = [];
$(document).ready(function() {
    $("[data-toggle=popover]").draggable({
        stop: function() {
            // show popover when drag stops
            $(this).popover('hide');
        }
    });

    /* deal with popovers
    -----------------------------------------------------------------*/
    $('.fc-event').popover({
        "html": true,
        "content": function() {
            var id = $(this).data('info');
            $.ajax({
                url: '/recipes/' + id + '.json',
                type: 'GET',
                dataType: 'json',
                async: false,
                success: function(data) {
                    id = data.id
                    name = data.name
                    instructions = data.instructions
                    directions = data.directions
                    picture = data.picture.url
                }
            });

            var myContent = "<center><a href='/recipes/" + id + "'>Go to recipe page</a>";

            myContent += "<br><img src='" +
                getPictureUrl(picture) + "' height='100' width='200' style='object-fit: cover;'/></center><br>";
            myContent += "<strong>Ingredients</strong><br><ul>"

            for (var i = 0; i < instructions.length; i++) {
                $.ajax({
                    url: '/ingredients/' + instructions[i].ingredient_id + '.json',
                    type: 'GET',
                    dataType: 'json',
                    async: false,
                    success: function(data) {
                        ing_name = data.name
                    }
                });
                myContent += "<li>" + instructions[i].amount;
                if (instructions[i].unit != null) {
                    myContent += " " + instructions[i].unit;
                }
                myContent += " " + ing_name + "</li>";
            }
            myContent += "</ul><strong>Directions</strong><br>" + directions
            return myContent;
        }
    });

    /* initialize the external events
    -----------------------------------------------------------------*/
    $('#external-events .fc-event').each(function() {
        // store data so the calendar knows to render an event upon drop
        $(this).data('event', {
            title: $.trim($(this).text()), // use the element's text as the event title
            stick: true // maintain when user navigates (see docs on the renderEvent method)
        });

        // make the event draggable using jQuery UI
        $(this).draggable({
            zIndex: 999,
            revert: true, // will cause the event to go back to its
            revertDuration: 0 //  original position after the drag
        });
    });

    /* initialize the Calendar
        -----------------------------------------------------------------*/
    $('#calendar1').fullCalendar({
        eventColor: '#80b719',
        selectOverlap: true,
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        editable: true,
        droppable: true, // this allows things to be dropped onto the calendar
        dragRevertDuration: 0,
        eventLimit: true, // allow "more" link when too many events
        drop: function(date, jsEvent, ui) {
            $(this).popover('hide');
        },
        eventDragStop: function(event, jsEvent) {

            var trashEl = jQuery('#calendarTrash');
            var ofs = trashEl.offset();

            var x1 = ofs.left;
            var x2 = ofs.left + trashEl.outerWidth(true);
            var y1 = ofs.top;
            var y2 = ofs.top + trashEl.outerHeight(true);

            if (jsEvent.pageX >= x1 && jsEvent.pageX <= x2 &&
                jsEvent.pageY >= y1 && jsEvent.pageY <= y2) {
                $('#calendar1').fullCalendar('removeEvents', event._id);
            }
        }
    });
});
