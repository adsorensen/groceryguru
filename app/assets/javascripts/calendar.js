function getPictureUrl(url) {
    if (url.includes('http')) {
        url = url.substring(url.indexOf("http"), url.length)
        if (url.includes("%3A")) {
            url = url.replace("%3A", ":/");
        }
    }
    return url;
}

function getIngredientName(id) {
    $.ajax({
        url: '/ingredients/' + id + '.json',
        type: 'GET',
        dataType: 'json',
        async: false,
        success: function(data) {
            name = data.name
        }
    });

    return name;
}

// Manage status of dragging event and calendar
var calEventStatus = [];
$(document).on('turbolinks:load', function() {
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
            myContent += "<strong>Ingredients</strong><br>"

            for (var i = 0; i < instructions.length; i++) {
                myContent += instructions[i].amount;
                if (instructions[i].unit != null) {
                    myContent += " " + instructions[i].unit;
                }
                myContent += " " + getIngredientName(instructions[i].ingredient_id);
                myContent += "<br>";
            }
            myContent += "<br><strong>Directions</strong><br>" + directions
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
        eventColor: '#6B8E23',
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
            $('.fc-event').popover('hide');
        },
        eventDragStop: function(event, jsEvent, ui, view) {
            $('.fc-event').popover('hide');
        }
        // // eventReceive: function(event) {
        // //     console.log('calendar 1 eventReceive');
        // //     makeEventsDraggable(event.id);
        // // },
        // // eventDrop: function(event, delta, revertFunc, jsEvent, ui, view) {
        // //     console.log('calendar 1 eventDrop');
        // //     //alert(event.id)
        // //     makeEventsDraggable(event.id);
        // // },
        // eventDragStart: function(event, jsEvent, ui, view) {
        //     console.log(event);
        //     console.log(jsEvent);
        //     console.log(ui);
        //     console.log(view);

        //     // Add dragging event in global var 
        //     calEventStatus['calendar'] = '#calendar1';
        //     calEventStatus['event_id'] = event._id;
        //     console.log('calendar 1 eventDragStart');
        // },
        // eventDragStop: function(event, jsEvent, ui, view) {
        //     console.log('calendar 1 eventDragStop');

        //     if (isEventOverDiv(jsEvent.clientX, jsEvent.clientY)) {
        //         $('#calendar1').fullCalendar('removeEvents', event._id);
        //         //alert(event.id)

        //         if (event.id === 0) {
        //             var el = $("<div class='fc-event' id='0'>").appendTo('#external-events-listing').text(event.title);
        //         }
        //         else if (event.id === 1) {
        //             var el = $("<div class='fc-event' id='1'>").appendTo('#external-events-listing-1').text(event.title);
        //         }
        //         else {
        //             var el = $("<div class='fc-event' id='2'>").appendTo('#external-events-listing-2').text(event.title);
        //         }
        //         el.draggable({
        //             zIndex: 999,
        //             revert: true,
        //             revertDuration: 0
        //         });

        //         el.data('event', { title: event.title, id: event.id, stick: true });
        //     }

        //     calEventStatus = []; // Empty
        //     //makeEventsDraggable();
        // },
        // eventResize: function(event, delta, revertFunc, jsEvent, ui, view) {
        //     //makeEventsDraggable();
        // },
        // viewRender: function() {
        //     console.log('calendar 1 viewRender');
        //     //makeEventsDraggable();
        // }
    });
});
