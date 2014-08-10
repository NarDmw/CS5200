$(
    function(){
        dataTableInit();
        select2Init();
    });

function select2Init(){
    $('.select2').select2({
        allowClear: true
    });
}

function dataTableInit(){
    $('.datatable').dataTable();
}