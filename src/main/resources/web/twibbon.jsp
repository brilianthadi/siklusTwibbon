<html xmlns:th="http://www.w3.org/1999/xhtml">
<head>
    <title>Siklus 2.0 | Cluster</title>
    <link rel="icon" type="image/png" href="/img-siklus" />
</head>
<body bgcolor="#E6E6FA">
<div style="text-align: center">
    <h1 style="color: #0c3059; margin-bottom: 0px">Siklus 2.0</h1>
    <p id="countdown"></p>
    <canvas id = "white" height="500" width="1000" style="position: absolute; margin-right: auto; margin-left: auto; right: 0; left: 0">
        <p>Canvas not supported</p>
    </canvas>
    <div style="height: 500px">
        <img id="img-twibbon" style="height: 500px; position: absolute; margin-right: auto; margin-left: auto; right: 0; left: 0" src='/img-twibbon' />
        <img id="img-upload" src='' />
    </div>
    <input id="inputan" type="file" onchange="previewFile()" style="margin-top: 10px"><br>
    <button id="reset" style="display: none; margin-bottom: 10px" onclick="reloadPage()">Reset</button><br>
    <div class="slidecontainer">
        <input disabled id="scroller" class="slider" type="range" name="points" min="1" max="200" oninput="scale()" style="margin-bottom: 10px">
    </div>
    <div>
        <button id="up" disabled onmousedown="up()">V</button>
        <div>
            <button id="left" disabled onmousedown="left()" style="margin-right: 25px"><</button>
            <button id="right" disabled onmousedown="right()" style="margin-left: 25px">></button>
        </div>
        <button id="down" disabled onmousedown="down()">V</button>
    </div>
    <button disabled id="download" style="margin-top: 10px" onclick="draw()">Download</button>
    <canvas id = "drawing" height="1000" width="1000" style="display: none;">
        <p>Canvas not supported</p>
    </canvas>
    <button id="hiddenButton" style="display: none" onclick="loadImage()">load</button>
</div>
</body>
</html>

<script>
    var heightOri = 1;
    var widthOri = 1;
    var error = false;
    var white = document.getElementById("white");
    var con = white.getContext("2d");
    con.fillStyle = ("#E6E6FA");
    con.fillRect(0,0,250,500);
    con.fillRect(750,0,250,500)


    // Set the date we're counting down to
    var countDownDate = new Date("Juni 15, 2019 16:00:00").getTime();

    // Update the count down every 1 second
    var x = setInterval(function() {

        // Get today's date and time
        var now = new Date().getTime();

        // Find the distance between now and the count down date
        var distance = countDownDate - now;

        // Time calculations for days, hours, minutes and seconds
        var days = Math.floor(distance / (1000 * 60 * 60 * 24));
        var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        var seconds = Math.floor((distance % (1000 * 60)) / 1000);

        // Output the result in an element with id="countdown"
        document.getElementById("countdown").innerHTML = "Kantun "+days + "d " + hours + "h "
            + minutes + "m " + seconds + "s deui daks...";

        // If the count down is over, write some text
        if (distance < 0) {
            clearInterval(x);
            document.getElementById("countdown").innerHTML = "EXPIRED";
        }
    }, 1000);

    function previewFile(){
        var preview = document.getElementById("img-upload"); //selects the query named img
        var file    = document.querySelector('input[type=file]').files[0]; //sames as here
        var reader  = new FileReader();
        var scroller = document.getElementById("scroller");
        var reset = document.getElementById("reset");
        var inputan = document.getElementById("inputan");
        var hiddenButton = document.getElementById("hiddenButton");

        reader.onloadend = function () {
            preview.src = reader.result;
            preview.refresh;
            hiddenButton.click();
        }

        if (file) {
            reader.readAsDataURL(file); //reads the data as a URL
        } else {
            preview.src = "";
        }
    }

    function loadImage(){
        var preview = document.getElementById("img-upload"); //selects the query named img
        var scroller = document.getElementById("scroller");
        var reset = document.getElementById("reset");
        var inputan = document.getElementById("inputan");
        var height = preview.height;
        var width = preview.width;
        if (width>height) {
            width = 500;
            preview.width = width;
            preview.style.marginTop = (500-preview.height)/2;
            preview.style.marginLeft = 0;
        } else {
            height = 500;
            preview.height = height;
            preview.style.marginLeft = 0;
            preview.style.marginTop = 0;
        }
        if (height==0 || width==0) {
            error = true;
        } else {
            widthOri = preview.width;
            heightOri = preview.height;
        }
        scroller.value = 100;
        inputan.style.display = "none";
        reset.style.display = "inline-block";
        enableButton();
    }

    function scaleOld(){
        var scroller = document.getElementById("scroller");
        var preview = document.getElementById("img-upload");
        if (error) {
            fixing();
        } else {
            if (preview.width>preview.height) {
                var widthOld = preview.width;
                preview.width = 500*scroller.value/100;
                preview.height = preview.height*(preview.width/widthOld);
            } else {
                var heightOld = preview.height;
                preview.height = 500*scroller.value/100;
                preview.width = preview.width*(preview.height/heightOld);
            }
            preview.style.marginTop = (500-preview.height)/2;
        }
    }

    function scale(){
        var scroller = document.getElementById("scroller");
        var preview = document.getElementById("img-upload");
        if (error) {
            heightOri = preview.height;
            widthOri = preview.width;
            error = false;
        }
        var heightOld = preview.height;
        preview.width = widthOri*scroller.value/100;
        preview.height = heightOri*scroller.value/100;
        var marginTop = parseFloat(preview.style.marginTop.replace("px",""));
        preview.style.marginTop = marginTop+(heightOld-preview.height)/2;
    }

    function enableButton(){
        document.getElementById("up").removeAttribute("disabled");
        document.getElementById("down").removeAttribute("disabled");
        document.getElementById("left").removeAttribute("disabled");
        document.getElementById("right").removeAttribute("disabled");
        document.getElementById("scroller").removeAttribute("disabled");
        document.getElementById("download").removeAttribute("disabled");
    }

    function up(){
        move("up");
    }

    function down(){
        move("down");
    }

    function left(){
        move("left");
    }

    function right(){
        move("right");
    }

    function move(direction) {
        var preview = document.getElementById("img-upload");
        var marginTop = preview.style.marginTop.replace("px","");
        var marginLeft = preview.style.marginLeft.replace("px","");
        if (direction=="up") {
            preview.style.marginTop = parseFloat(marginTop)-5;
        } else if(direction=="down"){
            preview.style.marginTop = parseFloat(marginTop)+5;
        } else if(direction=="left"){
            preview.style.marginLeft = parseFloat(marginLeft)-5;
        } else if(direction=="right"){
            preview.style.marginLeft = parseFloat(marginLeft)+5;
        }
    }

    function draw(){
        var drawing = document.getElementById("drawing");
        drawing.style.display = "inline-block";
        var con = drawing.getContext("2d");
        con.fillStyle = ("#FFFFFF");
        con.fillRect(0,0,1000,1000);
        var twibbon = document.getElementById("img-twibbon");
        var upload = document.getElementById("img-upload");
        var width = upload.width;
        var height = upload.height;
        var marginLeft = parseFloat(upload.style.marginLeft.replace("px",""));
        var marginLeftPlus = marginLeft + (500-width)/2;
        var marginTop = parseFloat(upload.style.marginTop.replace("px",""));
        con.drawImage(upload, marginLeftPlus*2, marginTop*2, width*2, height*2);
        con.drawImage(twibbon, 0, 0, 1000, 1000);
        download()
    }

    function download() {
        var canvas = document.getElementById("drawing");
        var img    = canvas.toDataURL("image/jpeg");
        document.write('<img src="'+img+'"/>');
    }

    function reloadPage(){
        location.reload();
    }
</script>


<style>
    button,#inputan {
        -moz-box-shadow:inset 0px 1px 0px 0px #1f5958;
        -webkit-box-shadow:inset 0px 1px 0px 0px #1f5958;
        box-shadow:inset 0px 1px 0px 0px #1f5958;
        background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #1b4a59), color-stop(1, #0c3059));
        background:-moz-linear-gradient(top, #1b4a59 5%, #0c3059 100%);
        background:-webkit-linear-gradient(top, #1b4a59 5%, #0c3059 100%);
        background:-o-linear-gradient(top, #1b4a59 5%, #0c3059 100%);
        background:-ms-linear-gradient(top, #1b4a59 5%, #0c3059 100%);
        background:linear-gradient(to bottom, #1b4a59 5%, #0c3059 100%);
        filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#1b4a59', endColorstr='#0c3059',GradientType=0);
        background-color:#1b4a59;
        -moz-border-radius:6px;
        -webkit-border-radius:6px;
        border-radius:6px;
        border:1px solid #051f59;
        display:inline-block;
        cursor:pointer;
        color:#ffffff;
        font-family:Arial;
        font-size:15px;
        font-weight:bold;
        padding:6px 24px;
        text-decoration:none;
        text-shadow:0px 1px 0px #051f59;
    }
    button,#inputan:hover {
        background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #0c3059), color-stop(1, #1b4a59));
        background:-moz-linear-gradient(top, #0c3059 5%, #1b4a59 100%);
        background:-webkit-linear-gradient(top, #0c3059 5%, #1b4a59 100%);
        background:-o-linear-gradient(top, #0c3059 5%, #1b4a59 100%);
        background:-ms-linear-gradient(top, #0c3059 5%, #1b4a59 100%);
        background:linear-gradient(to bottom, #0c3059 5%, #1b4a59 100%);
        filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#0c3059', endColorstr='#1b4a59',GradientType=0);
        background-color:#0c3059;
    }
    button#inputan:active {
        position:relative;
        top:1px;
    }

    .slidecontainer {
        width: 100%;
    }

    .slider {
        -webkit-appearance: none;
        width: 450px;
        height: 15px;
        border-radius: 5px;
        background: #bdbdbd;
        outline: none;
        opacity: 0.7;
        -webkit-transition: .2s;
        transition: opacity .2s;
    }

    .slider:hover {
        opacity: 1;
    }

    .slider::-webkit-slider-thumb {
        -webkit-appearance: none;
        appearance: none;
        width: 25px;
        height: 25px;
        border-radius: 50%;
        background: #1f5958;
        cursor: pointer;
    }

    .slider::-moz-range-thumb {
        width: 25px;
        height: 25px;
        border-radius: 50%;
        background: #1f5958;
        cursor: pointer;
    }

    #up {
        -webkit-transform: rotate(180deg);
        -moz-transform: rotate(180deg);
        -o-transform: rotate(180deg);
        -ms-transform: rotate(180deg);
        transform: rotate(180deg);
    }

    #countdown {
        text-align: center;
        font-size: 30px;
        margin-top: 0px;
        margin-bottom: 10px;
        color: #0c3059
    }
</style>