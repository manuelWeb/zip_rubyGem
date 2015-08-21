(function(){
    // lien global
    var globalLink = document.getElementById('globalLink');
    try{

        if ( globalLink ) {
            globalLink.style.cursor = 'pointer';
            
            var globalLink_tab = globalLink.children,
                globalLink_tabLength = globalLink_tab.length;
            //console.log(globalLink_tab[1])
            for (var i = 0; i < globalLink_tabLength; i++) {
                //console.log(globalLink_tab[i].innerHTML)
                if(globalLink_tab[i].className == 'btn'){
                    var url_bt = globalLink_tab[i].getAttribute('href');
                    //alert(url_bt)
                    globalLink.onclick = function() {
                        if(url_bt) {document.location = url_bt};
                    };
                };
            };// end for   
        };// end if

    }catch(e){
        if(console){ console.log(e)}
    };

})();// end IEF
