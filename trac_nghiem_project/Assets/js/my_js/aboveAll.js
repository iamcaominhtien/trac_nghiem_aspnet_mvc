document.getElementById("out_aboveALl").addEventListener("click", function (e) {
    if (e.target !== e.currentTarget) return;
    this.style = "display:none"
});

function closeAboveAll() {
    document.getElementById("out_aboveALl").style = "display:none";
}