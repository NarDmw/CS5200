$(
    function(){
        dataTableInit();
        select2Init();
    });

function select2Init(){
    $('.select2').select2({
        placeholder: 'Select',
        allowClear: true,
        //minimumInputLength: 2,
        'width': 'resolve'
    });


    if(typeof gon != 'undefined' && typeof gon.skills != 'undefined'){
        $('#selectSkills').select2('val', gon.skills);
    }
}

function dataTableInit() {
    $('.datatable').dataTable();
}