$(
    function(){
        dataTableInit();
        select2Init();
    });

function select2Init(){
    $('.select2').select2();
}

function dataTableInit(){
    $('.datatable').dataTable();
}