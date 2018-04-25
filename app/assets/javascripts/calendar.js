function getPictureUrl(url) {
    if (url.includes('http')) {
        url = url.substring(url.indexOf("http"), url.length)
        if (url.includes("%3A")) {
            url = url.replace("%3A", ":/");
        }
    }

    if (!url) {
        alert("here");
        url = 'http://mushkilnahi.com/wp-content/uploads/2014/01/no-image-available.jpg';
    }
    return url;
}


function emailPage() {
    window.location = "mailto:xyz@abc.com";
}

function getEvents() {
    $.ajax({
        type: 'GET',
        url: "/event",
        async: false,
        dataType: "json",
        success: function(data) {
            array = data;
        }
    });
    // alert(JSON.stringify(array));
    var myJson = "[";
    var count = array.length;
    array.forEach(function(element) {
        myJson += "{";
        myJson += "\"id\": \"" + element.event_id + "\",";
        myJson += "\"title\": \"" + element.title + "\",";
        myJson += "\"start\": \"" + element.start_time + "\",";
        myJson += "\"end\": \"" + element.end_time + "\",";
        myJson += "\"allDay\": " + element.allday;
        count--;
        myJson += "}"
        if (count != 0) {
            myJson += ",";
        }
    });
    myJson += "]";
    return myJson;
}

var calEventStatus = [];
$(document).ready(function() {
    getEvents();

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

            var myContent = "<center><a href='/recipes/" + id + "'>Go to recipe page</a><br>";
            myContent += "<a id='tagit' class='" + id + "'>Add to grocery list</a>";
            myContent += "<br><img src='" +
                getPictureUrl(picture) + "' height='100' width='200' style='object-fit: cover;'/></center><br>";
            // myContent += "<strong>Ingredients</strong><br><ul>"

            // for (var i = 0; i < instructions.length; i++) {
            //     $.ajax({
            //         url: '/ingredients/' + instructions[i].ingredient_id + '.json',
            //         type: 'GET',
            //         dataType: 'json',
            //         async: false,
            //         success: function(data) {
            //             ing_name = data.name
            //         }
            //     });
            //     myContent += "<li>" + instructions[i].amount;
            //     if (instructions[i].unit != null) {
            //         myContent += " " + instructions[i].unit;
            //     }
            //     myContent += " " + ing_name + "</li>";
            // }
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
        events: JSON.parse(getEvents()),
        eventColor: '#55AE3A',
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
            $.ajax({
                type: 'GET',
                url: "/event",
                async: false,
                dataType: "json",
            });
        },
        eventDrop: function(event, delta, revertFunc, jsEvent, ui, view) {
            $.ajax({
                type: 'POST',
                url: "/calendar/drag",
                data: { event_id: event._id, start_time: String(event.start), end_time: String(event.end), allday: event.allDay },
                async: false,
                dataType: "json",
            });
        },
        eventReceive: function(event, view) {
            event._id = event._id + "" + Date.now();
            $.ajax({
                type: 'POST',
                url: "/calendar",
                data: { event_id: event._id, title: event.title, start_time: String(event.start), allday: event.allDay },
                dataType: "json",
            });
            $('#calendar').fullCalendar('updateEvent', event);
        },
        eventResize: function(event, delta, revertFunc, jsEvent, ui, view) {
            $.ajax({
                type: 'POST',
                url: "/calendar/drag",
                data: { event_id: event._id, start_time: String(event.start), end_time: String(event.end), allday: event.allDay },
                async: false,
                dataType: "json",
            });
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
                $.ajax({
                    type: 'DELETE',
                    url: "/calendar",
                    data: { event_id: event._id },
                    dataType: "json",
                });
            }
        }
    });
});

$(document).on('click', "#tagit", function() {
    var id = $('#tagit').attr('class');
    console.log("HERE HERE");
    $.ajax({
        type: 'POST',
        url: "/cart",
        data: {
            recipe: id
        },
        dataType: "json",
        success: function(response) {
            swal({
                type: 'success',
                title: "Recipe added to list!",
            });
        }
    });
});
