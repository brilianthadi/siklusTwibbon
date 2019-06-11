<html xmlns:th="http://www.w3.org/1999/xhtml">
<head><title>Siklus 2.0 | Cluster</title></head>
<body>
<div style="text-align: center">
    <h1>Siklus 2.0 Twibbon</h1>
    <div style="height: 500px">
        <img id="img-twibbon" style="height: 500px; position: absolute; margin-right: auto; margin-left: auto; right: 0; left: 0" src='/img-twibbon' />
        <img id="img-upload" src='' />
    </div>
    <input id="inputan" type="file" onchange="previewFile()"><br>
    <button id="reset" style="display: none" onclick="reloadPage()">Reset</button><br>
    <input id="scroller" type="range" name="points" min="1" max="200" oninput="scale()">
    <div>
        <button id="up" disabled onmousedown="up()">A</button>
        <div>
            <button id="upload" style="margin-right: 100px; width: 75px" onclick="download()">Upload</button>
            <button id="left" disabled onmousedown="left()" style="margin-right: 10px"><</button>
            <button id="right" disabled onmousedown="right()" style="margin-left: 10px">></button>
            <button id="download" style="margin-left: 100px; width: 75px" onclick="draw()">Download</button>
        </div>
        <button id="down" disabled onmousedown="down()">V</button>
    </div>
    <canvas id = "drawing" height="1000" width="1000" style="display: none;">
        <p>Canvas not supported</p>
    </canvas>
</div>
</body>
</html>

<script>
    function previewFile(){
        var preview = document.getElementById("img-upload"); //selects the query named img
        var file    = document.querySelector('input[type=file]').files[0]; //sames as here
        var reader  = new FileReader();
        var scroller = document.getElementById("scroller");
        var reset = document.getElementById("reset");
        var inputan = document.getElementById("inputan");

        reader.onloadend = function () {
            preview.src = reader.result;
            preview.refresh;
            var height = preview.height;
            var width = preview.width;
            if (height==0 || width==0) {
                reloadPage();
            }
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
            scroller.value = 100;
            inputan.style.display = "none";
            reset.style.display = "inline-block";
            enableButton();
        }

        if (file) {
            reader.readAsDataURL(file); //reads the data as a URL
        } else {
            preview.src = "";
        }
    }

    function scale(){
        var scroller = document.getElementById("scroller");
        var preview = document.getElementById("img-upload");
        if (preview.width>preview.height) {
            preview.width = 500*scroller.value/100;
        } else {
            preview.height = 500*scroller.value/100;
        }
        preview.style.marginTop = (500-preview.height)/2;
    }

    function enableButton(){
        document.getElementById("up").removeAttribute("disabled");
        document.getElementById("down").removeAttribute("disabled");
        document.getElementById("left").removeAttribute("disabled");
        document.getElementById("right").removeAttribute("disabled");
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
        con.fillRect(0,0,500,500);
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