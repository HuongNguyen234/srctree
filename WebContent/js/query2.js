$(document).ready(function () {
    $('.gom img').click(function (e) {
        e.preventDefault();
        var srcImg1 = $(this).attr('src');
        $('#img').attr('src', srcImg1);
    });
});