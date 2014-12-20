//put in a 16x16 grid of $square div
width = 16;
height = 16;
square = '<div id="square"></div>'; 
hsquare = '<div id="square" class="highlighted"></div>';
function createGrid() {
    console.log("starting createSquares()");
    console.log("Width is " + width + ", height is " + height);
    for(i = 0; i < width; i += 1) {
        for(j = 0; j < height; j += 1)  { 
            $('#grid').append(square); 
        }
        $('#grid').append('<br id = "blank"/>');
    }
}

function clearGrid() {
    $('#grid').empty(); 
}

function reset() {
    clearGrid();
    width = prompt("Enter a new width: (max of 32)");
    while(width > 32) {
        width = prompt("Width must be less than 32:");
    }
    height = prompt("Enter a new height: (max of 32)");
    while(height > 32) {
        height = prompt("Height must be less than 32");
    }
    createGrid();
}

$(document).ready(function() {
    createGrid();
    $(document).on('mouseenter', '#square', function() {
        $(this).addClass("highlighted");
    }); 
    $('#reset').click(function() {
        reset();
    });
});


