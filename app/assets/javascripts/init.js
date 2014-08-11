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
            value: 7
        });
    }
}

$(
    function(){
        dataTableInit();
        select2Init();
        sliderInit();
    });