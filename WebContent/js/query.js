$(document).ready(function () {
	
    $('#search').click(function (e) { 
        e.preventDefault();
        $('#myUL').toggle();
    });
    $('#change').click(function (e) {
        e.preventDefault();
//        $('#lb').css('display', 'block');
//        $('#sl').css('display', 'block');
        $('#a').css('display', 'block');
        $('#num').css('display', 'none');
    });
//    $('body').click(function (e) { 
//        e.preventDefault();
//        $('#myUL').fadeOut();
//    });
//    $('#search').click(function (e) {
//      e.preventDefault();
//      e.stopPropagation();
//    });
    
});
function myFunction() {
  var input, filter, ul, li, a, i, txtValue;
  input = document.getElementById('search');
  filter = input.value.toUpperCase();
  ul = document.getElementById('myUL');
  li = ul.getElementsByTagName('li');

  for (i = 0; i < li.length; i++) {
    a = li[i].getElementsByTagName("a")[0];
    txtValue = a.textContent || a.innerText;
    if (txtValue.toUpperCase().indexOf(filter) > -1) {
      li[i].style.display = "";
    } else {
      li[i].style.display = "none";
    }
  }
}

