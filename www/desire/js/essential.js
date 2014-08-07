
/////

function onDeviceReady() {
    document.addEventListener("pause", onPause, false);
    document.addEventListener("resume", onResume, false);

    angular.element(document).ready(function() {
       angular.bootstrap(document);
    });

    beforeFineshedLoad();
    
    finishedLoad();

    afterFineshedLoad();
}

function onPause() {
    CordovaExec(function(){}, "FormPlugin", "OnPauseReceived");
}

function onResume() {
    CordovaExec(function(){}, "FormPlugin", "OnResumeReceived");
}

document.addEventListener("deviceready", onDeviceReady, false);

function beforeFineshedLoad(){
    
}

function beforeStatLoadLoad(){
    $('body').hide();
    console.log('body is hiding')
}

function afterFineshedLoad(){
    $('body').show();
    console.log('body is showing')   
}

function afterStatLoadLoad(){
}

$(document).ready(function(){
    beforeStatLoadLoad()

    startLoad()

    afterStatLoadLoad()
})

//Funcoes criada apenas para não passar como inexistentes,
//essas funcoes são chamadas pelo .js de cada pagina correspondente
function startLoad(){console.log('startLoad is never used in this page')}

function finishedLoad(){console.log('finishedLoad is never used in this page')}