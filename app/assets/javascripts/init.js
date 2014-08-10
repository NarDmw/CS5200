$(
    function(){
        dataTableInit();
        select2Init();
    });

function select2Init(){
    $('.select2').select2({
        placeholder: 'Select',
        allowClear: true,
        'width': 'resolve'
    });
}

function dataTableInit(){
    $('.datatable').dataTable();
}