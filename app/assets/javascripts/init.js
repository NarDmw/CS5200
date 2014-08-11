function dataTableInit() {
    $('.datatable').dataTable();
}

function select2Init(){
    $('.select2').select2({
        placeholder: 'Select',
        allowClear: true,
        'width': 'resolve'
    });


    if(typeof gon != 'undefined' && typeof gon.skills != 'undefined'){
        $('#selectSkills').select2('val', gon.skills);
    }
}

function sliderInit(){
    var sliderElements = $('input.slider');
    if(sliderElements.length > 0){
        sliderElements.slider({
            min: 1,
            max: 14,
            value: 7,
            formater: function(value) {
                return 'Days Active: '+value;
            }
        });
    }
}

function highlightNavInit(){
    var pathname = window.location.pathname;
    var element;

    if (pathname == '/') {
        element = $('#navHome');
    }else if (pathname == '/about') {
        element = $('#navAbout');
    }else if (pathname == '/contact') {
        element = $('#navContact');
    }else if (pathname == '/postings') {
        if (location.search == '?my_posts=true') {
            element = $('#navUser');
        } else {
            element = $('#navPostings');
        }
    }
/*    else if (/users/.test(pathname)){
        element = $('#navUser');
    }*/

    if(element != undefined){
        element.addClass('active');
    }
}

$(
    function(){
        dataTableInit();
        select2Init();
        sliderInit();
        highlightNavInit();
    });