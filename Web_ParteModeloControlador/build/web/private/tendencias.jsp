<%-- 
    Document   : home
    Created on : 04-ene-2016, 17:45:43
    Author     : van
--%>

<%@page import="pruebabd.DBActions"%>
<%@page import="WSBeans.DataChart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="../css/style.css"/>
        <link rel="stylesheet" type="text/css" href="../plugin/css/style.css">
        <script src="../js/jquery-1.6.1.min.js" type="text/javascript"></script>
        <script src="../plugin/jquery-jplayer/jquery.jplayer.js" type="text/javascript"></script>
        <script src="../plugin/ttw-music-player-min.js" type="text/javascript"></script>
        <script src="../js/myplaylist.js" type="text/javascript"></script>
        
            <% 
                DataChart chartBar = DBActions.get3DColumn();
            %>
            <script type="text/javascript">
       
                $(function () {
                    $('#containerBar').highcharts({

                        chart: {
                            type: 'column',
                            options3d: {
                                enabled: true,
                                alpha: 15,
                                beta: 15,
                                viewDistance: 25,
                                depth: 40
                            },
                            marginTop: 80,
                            marginRight: 100
                        },

                        title: {
                            text: 'Total tweets por categoria'
                        },

                        xAxis: {
                            categories: <% out.print(chartBar.getCategorias()); %>, //['Apples', 'Oranges', 'Pears', 'Grapes', 'Bananas']
                            labels: {
                                reserveSpace: false,
                                enabled: true
                            },
                            title: {
                                text: 'Categorias'
                            }
                        },

                        yAxis: {
                            allowDecimals: false,
                            min: 0,
                            title: {
                                text: 'Nº de tweets'
                            }
                        },

                        tooltip: {
                            headerFormat: '<b>{point.key}</b><br>',
                            pointFormat: '<span style="color:{series.color}">\u25CF</span> {series.name}: {point.y} / {point.stackTotal}'
                        },

                        plotOptions: {
                            column: {
                                stacking: 'normal',
                                depth: 40
                            },
                            //series: {
                                //color: ['#ffcc00','#9999ff','#993366','#ffff99','#ff99cc','#ff9900','#0066cc','#ccccff','#000080','#ff00ff','#ffff00','#00ffff','#800080','#ff0000']  //'#FF0000'
                           // },
                        },

                        series: [{
                                name: <% out.print(chartBar.getSeries()); %> ,
                            data: <% out.print(chartBar.getDatos().get(0)); %>
                        }]
                    });
                    
                    // the button action
                    var chart = $('#containerBar').highcharts(),
                    series = chart.series[0],
                    //col = chart.series[0].data[2],
                    showBal = false,
                    showOcio = false;
                                       
                   var numCategories = series.xAxis.categories.length;
                   var $bBal = $('#buttonBaleares');
                   
                    $bBal.click(function() {                        
                        if(showBal){
                            for(i=0; i<numCategories;i++){
                                var categoria = series.xAxis.categories[i];
                                if(categoria=='baleares' || categoria=='formentera' 
                                    || categoria=='mallorca' || categoria=='menorca' ||
                                    categoria=='ibiza'){
                                    series.data[i].graphic.show(); 
                                }
                            }
                            $('#buttonBaleares').css({"background-image": "url('../images/bOn.bmp'"});
                        }else{
                            for(i=0; i<numCategories;i++){
                                var categoria = series.xAxis.categories[i];
                                if(categoria=='baleares' || categoria=='formentera' 
                                    || categoria=='mallorca' || categoria=='menorca' ||
                                    categoria=='ibiza'){
                                    series.data[i].graphic.hide(); 
                                }
                            }
                            $('#buttonBaleares').css({"background-image": "url('../images/bOff.png'"});
                        }
                        chart.redraw();
                        showBal = !showBal;
                    });
              
                
                $('#buttonOcio').click(function(){
                    if(showOcio){
                        for(i=0; i<numCategories;i++){
                            var categoria = series.xAxis.categories[i];
                            if(categoria=='arte' || categoria=='baile' 
                                || categoria=='cine' || categoria=='conciertos' ||
                                categoria=='hotel' || categoria=='musica' || 
                                categoria=='playa' || categoria=='restaurantes' || 
                                categoria=='teatro'){
                                series.data[i].graphic.show(); 
                            }
                        }
                            $('#buttonOcio').css({"background-image": "url('../images/bOn.bmp'","title":"hide"});
                        }else{
                            for(i=0; i<numCategories;i++){
                                var categoria = series.xAxis.categories[i];
                                if(categoria=='arte' || categoria=='baile' 
                                    || categoria=='cine' || categoria=='conciertos' ||
                                    categoria=='hotel' || categoria=='musica' || 
                                    categoria=='playa' || categoria=='restaurantes' || 
                                    categoria=='teatro')
                                {
                                    series.data[i].graphic.hide(); 
                                }
                            }
                            $('#buttonOcio').css({"background-image": "url('../images/bOff.png'","title":"show"});
                        }
                        showOcio=!showOcio;
                });
            
            });
                    
            </script>
            
            
            <% DataChart chartArea = DBActions.getPercArea(); %>
            <script type="text/javascript">
                    
                $(function () {
                    $('#containerArea').highcharts({
                        chart: {
                            type: 'area'
                        },
                        title: {
                            text: 'Total de tweets por %'
                        },
                        subtitle: {
                            text: 'Source: Wikipedia.org'
                        },
                        xAxis: {
                            categories: <%out.print(chartArea.getCategorias());%>,
                            tickmarkPlacement: 'on',
                            title: {
                                enabled: false
                            }
                        },
                        yAxis: {
                            title: {
                                text: 'Porcentaje de tweets'
                            }
                        },
                        tooltip: {
                            pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.percentage:.1f}%</b> ({point.y:,.0f})<br>',
                            shared: true
                        },
                        plotOptions: {
                            area: {
                                stacking: 'percent',
                                lineColor: '#ffffff',
                                lineWidth: 1,
                                marker: {
                                    lineWidth: 1,
                                    lineColor: '#ffffff'
                                }
                            }
                        },
                        series: [<%
                        int numSeries=chartArea.getSeries().size();
                        for(int i=0; i<numSeries;i++){
                            String serie, serieName = chartArea.getSeries().get(i);
                            serie="{\n name: "+ serieName+",\n"
                                    +"id: "+serieName.toLowerCase()+",\n"
                                  +"data: "+chartArea.getDatos().get(i)+"\n},\n";
                            out.print(serie);
                        }
                    %>]
                    });
                var chart = $("#containerArea").highcharts(),
                $bMallorca=$('#buttonMall1'),
                $bMenorca=$('#buttonMen1'),
                $bIbiza=$('#buttonIb1'),
                $bFormentera=$('#buttonFor1'),
                $bBal=$('#buttonBal1'),
                $bCine=$('#buttonCine1'),
                $bPlaya=$('#buttonPlaya1'),
                $bBaile=$('#buttonBaile1'),
                $bTeatro=$('#buttonTeatro1'),
                $bMusica=$('#buttonMusic1'),
                $bConciertos=$('#buttonConc1'),
                $bRestaurantes=$('#buttonRest1'),
                $bArte=$('#buttonArte1'),
                $bHotel=$('#buttonHotel1'),
                $bIslas=$('#buttonIslas1'),
                $bOcio=$('#buttonOcio1'),
                islasVisibility = false,
                ocioVisibility = false,
                seriesIslas = [chart.get("mallorca"),chart.get("menorca"),chart.get("ibiza"),chart.get("formentera"),chart.get("baleares")],
                seriesOcio = [chart.get("cine"),chart.get("playa"),chart.get("baile"),chart.get("arte"),chart.get("teatro"),chart.get("musica"),chart.get("conciertos"),chart.get("restaurantes"),chart.get("hotel")],
                hide =  [false,false,false,false,false,false,false,false,false,false,false,false,false,false],
                hideOcio = false,
                hideIslas = false;
                
                
                $bMallorca.click(function(){
                    seriesIslas[0].setVisible(hide[0]);
                    if(hide[0]) { // if se ha de mostrar el dato
                        if(hideIslas){ //if anteriormente se ocultaron todas las islas
                            $bIslas.css({"background-image": "url('../images/bOn.bmp')"});
                            $bIslas.attr("title","hide");
                            hideIslas=false;
                        }
                        $bMallorca.css({"background-image": "url('../images/bOn.bmp')"});
                        $bMallorca.attr("title","hide");
                    }else{
                        $bMallorca.css({"background-image": "url('../images/bOff.png')"});
                        $bMallorca.attr("title","show");
                    }
                    hide[0] = !(hide[0]);
                });
                $bMenorca.click(function(){
                    seriesIslas[1].setVisible(hide[1]);
                    if(hide[1]) { // if se ha de mostrar el dato
                        if(hideIslas){ //if anteriormente se ocultaron todas las islas
                            $bIslas.css({"background-image": "url('../images/bOn.bmp')"});
                            $bIslas.attr("title","hide");
                            hideIslas=false;
                        }
                        $bMenorca.css({"background-image": "url('../images/bOn.bmp')"});
                        $bMenorca.attr("title","hide");
                    }else{
                        $bMenorca.css({"background-image": "url('../images/bOff.png')"});
                        $bMenorca.attr("title","show");
                    }
                    hide[1] = !hide[1];
                });
                $bIbiza.click(function(){
                    seriesIslas[2].setVisible(hide[2]);
                    if(hide[2]) { // if se ha de mostrar el dato
                        if(hideIslas){ //if anteriormente se ocultaron todas las islas
                            $bIslas.css({"background-image": "url('../images/bOn.bmp')"});
                            $bIslas.attr("title","hide");
                            hideIslas=false;
                        }
                        $bIbiza.css({"background-image": "url('../images/bOn.bmp')"});
                        $bIbiza.attr("title","hide");
                    }else{
                        $bIbiza.css({"background-image": "url('../images/bOff.png')"});
                        $bIbiza.attr("title","show");
                    }
                    hide[2] = !hide[2];
                });
                $bFormentera.click(function(){
                    seriesIslas[3].setVisible(hide[3]);
                    if(hide[3]) { // if se ha de mostrar el dato
                        if(hideIslas){ //if anteriormente se ocultaron todas las islas
                            $bIslas.css({"background-image": "url('../images/bOn.bmp')"});
                            $bIslas.attr("title","hide");
                            hideIslas=false;
                        }
                        $bFormentera.css({"background-image": "url('../images/bOn.bmp')"});
                        $bFormentera.attr("title","hide");
                    }else{
                        $bFormentera.css({"background-image": "url('../images/bOff.png')"});
                        $bFormentera.attr("title","show");
                    }
                    hide[3] = !(hide[3]);
                });
                $bBal.click(function(){
                    seriesIslas[4].setVisible(hide[4]);
                    if(hide[4]) { // if se ha de mostrar el dato
                        if(hideIslas){ //if anteriormente se ocultaron todas las islas
                            $bIslas.css({"background-image": "url('../images/bOn.bmp')"});
                            $bIslas.attr("title","hide");
                            hideIslas=false;
                        }
                        $bBal.css({"background-image": "url('../images/bOn.bmp')"});
                        $bBal.attr("title","hide");
                    }else{
                        $bBal.css({"background-image": "url('../images/bOff.png')"});
                        $bBal.attr("title","show");
                    }
                    hide[4] = !hide[4];
                });
                $bCine.click(function(){  
                    seriesOcio[0].setVisible(hide[5]);
                    if(hide[5]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bCine.css({"background-image": "url('../images/bOn.bmp')"});
                        $bCine.attr("title","hide");
                    }else{
                        $bCine.css({"background-image": "url('../images/bOff.png')"});
                        $bCine.attr("title","show");
                    }
                    hide[5] = !hide[5];
                });
                $bPlaya.click(function(){
                    seriesOcio[1].setVisible(hide[6]);
                    if(hide[6]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bPlaya.css({"background-image": "url('../images/bOn.bmp')"});
                        $bPlaya.attr("title","hide");
                    }else{
                        $bPlaya.css({"background-image": "url('../images/bOff.png')"});
                        $bPlaya.attr("title","show");
                    }
                    hide[6] = !hide[6];
                });
                $bBaile.click(function(){
                    seriesOcio[2].setVisible(hide[7]);
                    if(hide[7]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bBaile.css({"background-image": "url('../images/bOn.bmp')"});
                        $bBaile.attr("title","hide");
                    }else{
                        $bBaile.css({"background-image": "url('../images/bOff.png')"});
                        $bBaile.attr("title","show");
                    }
                    hide[7] = !(hide[7]);
                });
                $bArte.click(function(){
                    seriesOcio[3].setVisible(hide[8]);
                    if(hide[8]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bArte.css({"background-image": "url('../images/bOn.bmp')"});
                        $bArte.attr("title","hide");
                    }else{
                        $bArte.css({"background-image": "url('../images/bOff.png')"});
                        $bArte.attr("title","show");
                    }
                    hide[8] = !hide[8];
                });
                $bTeatro.click(function(){
                    seriesOcio[4].setVisible(hide[9]);
                    if(hide[9]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bTeatro.css({"background-image": "url('../images/bOn.bmp')"});
                        $bTeatro.attr("title","hide");
                    }else{
                        $bTeatro.css({"background-image": "url('../images/bOff.png')"});
                        $bTeatro.attr("title","show");
                    }
                    hide[9] = !hide[9];
                });
                $bMusica.click(function(){
                    seriesOcio[5].setVisible(hide[10]);
                    if(hide[10]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bMusica.css({"background-image": "url('../images/bOn.bmp')"});
                        $bMusica.attr("title","hide");
                    }else{
                        $bMusica.css({"background-image": "url('../images/bOff.png')"});
                        $bMusica.attr("title","show");
                    }
                    hide[10] = !hide[10];
                });
                $bConciertos.click(function(){
                    seriesOcio[6].setVisible(hide[11]);
                    if(hide[11]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bConciertos.css({"background-image": "url('../images/bOn.bmp')"});
                        $bConciertos.attr("title","hide");
                    }else{
                        $bConciertos.css({"background-image": "url('../images/bOff.png')"});
                        $bConciertos.attr("title","show");
                    }
		    hide[11] = !(hide[11]);
                });
                $bRestaurantes.click(function(){
                    seriesOcio[7].setVisible(hide[12]);
                    if(hide[12]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bRestaurantes.css({"background-image": "url('../images/bOn.bmp')"});
                        $bRestaurantes.attr("title","hide");
                    }else{
                        $bRestaurantes.css({"background-image": "url('../images/bOff.png')"});
                        $bRestaurantes.attr("title","show");
                    }
                    hide[12] = !hide[12];
                });
                $bHotel.click(function(){
                    seriesOcio[8].setVisible(hide[13]);
                    if(hide[13]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bHotel.css({"background-image": "url('../images/bOn.bmp')"});
                        $bHotel.attr("title","hide");
                    }else{
                        $bHotel.css({"background-image": "url('../images/bOff.png')"});
                        $bHotel.attr("title","show");
                    }
                    hide[13] = !hide[13];
                });
                
                $bOcio.click(function(){
                    var pathImg,titulo;
                    for(i=0,l=seriesOcio.length;i<l;i++){
                        seriesOcio[i].setVisible(hideOcio,false);
                        hide[l-1-i] = !hideOcio;
                    }
                    chart.redraw();
                    if(hideOcio){
                        pathImg='"../images/bOn.bmp"';
                        titulo='hide';
                    }else{
                        pathImg='"../images/bOff.png"'; 
                        titulo='show';
                    }
                    $bCine.css({'background-image':'url('+pathImg+')'});
                    $bCine.attr("title",titulo);
                    $bPlaya.css({"background-image":'url('+pathImg+')'});
                    $bPlaya.attr('title',titulo);
                    $bBaile.css({"background-image":'url('+pathImg+')'});
                    $bBaile.attr('title',titulo);
                    $bTeatro.css({"background-image":'url('+pathImg+')'});
                    $bTeatro.attr('title',titulo);
                    $bMusica.css({"background-image":'url('+pathImg+')'});
                    $bMusica.attr('title',titulo);
                    $bConciertos.css({"background-image":'url('+pathImg+')'});
                    $bConciertos.attr('title',titulo);
                    $bRestaurantes.css({"background-image":'url('+pathImg+')'});
                    $bRestaurantes.attr('title',titulo);
                    $bArte.css({"background-image":'url('+pathImg+')'});
                    $bArte.attr('title',titulo);
                    $bHotel.css({"background-image":'url('+pathImg+')'});
                    $bHotel.attr('title',titulo);
                    $bOcio.css({"background-image":'url('+pathImg+')'});
                    $bOcio.attr("title",titulo);
                    hideOcio = !hideOcio;
                });

                $bIslas.click(function(){
                    var pathImg,titulo;
                    for(i=0,l=seriesIslas.length;i<l;i++){
                        seriesIslas[i].setVisible(hideIslas,false);
                        hide[i] = !hideIslas;
                    }
                    chart.redraw();
                    if(hideIslas){
                        pathImg='"../images/bOn.bmp"';
                        titulo='hide';
                    }else{
                        pathImg='"../images/bOff.png"'; 
                        titulo='show';
                    }
                    $bIslas.css({'background-image':'url('+pathImg+')'});
                    $bIslas.attr("title",titulo);
                    $bMallorca.css({"background-image":'url('+pathImg+')'});
                    $bIslas.attr('title',titulo);
                    $bMenorca.css({"background-image":'url('+pathImg+')'});
                    $bMenorca.attr('title',titulo);
                    $bIbiza.css({"background-image":'url('+pathImg+')'});
                    $bIbiza.attr('title',titulo);
                    $bFormentera.css({"background-image":'url('+pathImg+')'});
                    $bFormentera.attr('title',titulo);
                    $bBal.css({"background-image":'url('+pathImg+')'});
                    $bBal.attr('title',titulo);
                    hideIslas = !hideIslas;
                }); 
            });
            </script>  
            
            
            
            <%  DataChart chartDonut = DBActions.getDonut(); %>
            <script  type="text/javascript">
                $(function () {
                    $('#containerDonut').highcharts({
                        chart: {
                            type: 'pie',
                            options3d: {
                                enabled: true,
                                alpha: 35,
                                beta: 0
                            }
                        },
                        title: {
                            text: 'Distribución porcentual de tweets por categoria'
                        },
                        plotOptions: {
                            pie: {
                                allowPointSelect: true,
                                innerSize: 60,
                                depth: 40
                            }
                        },
                        series: [{
                            name: 'Tweets',
                            data:[<%
                                int l = chartDonut.getDatos().size();  
                                String nomSerie;
                                for(int i=0;i<l;i++){
                                    nomSerie = chartDonut.getCategorias().get(i);
                                    String point ="{\nid: "+nomSerie.toLowerCase()+",\n"
                                            +"name: "+nomSerie+",\n"
                                            +"y: "+chartDonut.getDatos().get(i)+"\n},\n";
                                    out.print(point); 
                                }
                                %>]
                        }]
                    });
                var chart = $('#containerDonut').highcharts(),
                $bMallorca=$('#buttonMall2'),
                $bMenorca=$('#buttonMen2'),
                $bIbiza=$('#buttonIb2'),
                $bFormentera=$('#buttonFor2'),
                $bBal=$('#buttonBal2'),
                $bCine=$('#buttonCine2'),
                $bPlaya=$('#buttonPlaya2'),
                $bBaile=$('#buttonBaile2'),
                $bTeatro=$('#buttonTeatro2'),
                $bMusica=$('#buttonMusic2'),
                $bConciertos=$('#buttonConc2'),
                $bRestaurantes=$('#buttonRest2'),
                $bArte=$('#buttonArte2'),
                $bHotel=$('#buttonHotel2'),
                $bIslas=$('#buttonIslas2'),
                $bOcio=$('#buttonOcio2'),
                hide =  [false,false,false,false,false,false,false,false,false,false,false,false,false,false],
                seriesIslas = [chart.get("mallorca"),chart.get("menorca"),chart.get("ibiza"),chart.get("formentera"),chart.get("baleares")],
                seriesOcio = [chart.get("cine"),chart.get("playa"),chart.get("baile"),chart.get("arte"),chart.get("teatro"),chart.get("musica"),chart.get("conciertos"),chart.get("restaurantes"),chart.get("hotel")],
                hideOcio = false,
                hideIslas = false;
                $bMallorca.click(function(){
                    seriesIslas[0].setVisible(hide[0]);
                    if(hide[0]) { // if se ha de mostrar el dato
                        if(hideIslas){ //if anteriormente se ocultaron todas las islas
                            $bIslas.css({"background-image": "url('../images/bOn.bmp')"});
                            $bIslas.attr("title","hide");
                            hideIslas=false;
                        }
                        $bMallorca.css({"background-image": "url('../images/bOn.bmp')"});
                        $bMallorca.attr("title","hide");
                    }else{
                        $bMallorca.css({"background-image": "url('../images/bOff.png')"});
                        $bMallorca.attr("title","show");
                    }
                    hide[0] = !(hide[0]);
                });
                $bMenorca.click(function(){
                    seriesIslas[1].setVisible(hide[1]);
                    if(hide[1]) { // if se ha de mostrar el dato
                        if(hideIslas){ //if anteriormente se ocultaron todas las islas
                            $bIslas.css({"background-image": "url('../images/bOn.bmp')"});
                            $bIslas.attr("title","hide");
                            hideIslas=false;
                        }
                        $bMenorca.css({"background-image": "url('../images/bOn.bmp')"});
                        $bMenorca.attr("title","hide");
                    }else{
                        $bMenorca.css({"background-image": "url('../images/bOff.png')"});
                        $bMenorca.attr("title","show");
                    }
                    hide[1] = !hide[1];
                });
                $bIbiza.click(function(){
                    seriesIslas[2].setVisible(hide[2]);
                    if(hide[2]) { // if se ha de mostrar el dato
                        if(hideIslas){ //if anteriormente se ocultaron todas las islas
                            $bIslas.css({"background-image": "url('../images/bOn.bmp')"});
                            $bIslas.attr("title","hide");
                            hideIslas=false;
                        }
                        $bIbiza.css({"background-image": "url('../images/bOn.bmp')"});
                        $bIbiza.attr("title","hide");
                    }else{
                        $bIbiza.css({"background-image": "url('../images/bOff.png')"});
                        $bIbiza.attr("title","show");
                    }
                    hide[2] = !hide[2];
                });
                $bFormentera.click(function(){
                    seriesIslas[3].setVisible(hide[3]);
                    if(hide[3]) { // if se ha de mostrar el dato
                        if(hideIslas){ //if anteriormente se ocultaron todas las islas
                            $bIslas.css({"background-image": "url('../images/bOn.bmp')"});
                            $bIslas.attr("title","hide");
                            hideIslas=false;
                        }
                        $bFormentera.css({"background-image": "url('../images/bOn.bmp')"});
                        $bFormentera.attr("title","hide");
                    }else{
                        $bFormentera.css({"background-image": "url('../images/bOff.png')"});
                        $bFormentera.attr("title","show");
                    }
                    hide[3] = !(hide[3]);
                });
                $bBal.click(function(){
                    seriesIslas[4].setVisible(hide[4]);
                    if(hide[4]) { // if se ha de mostrar el dato
                        if(hideIslas){ //if anteriormente se ocultaron todas las islas
                            $bIslas.css({"background-image": "url('../images/bOn.bmp')"});
                            $bIslas.attr("title","hide");
                            hideIslas=false;
                        }
                        $bBal.css({"background-image": "url('../images/bOn.bmp')"});
                        $bBal.attr("title","hide");
                    }else{
                        $bBal.css({"background-image": "url('../images/bOff.png')"});
                        $bBal.attr("title","show");
                    }
                    hide[4] = !hide[4];
                });
                $bCine.click(function(){  
                    seriesOcio[0].setVisible(hide[5]);
                    if(hide[5]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bCine.css({"background-image": "url('../images/bOn.bmp')"});
                        $bCine.attr("title","hide");
                    }else{
                        $bCine.css({"background-image": "url('../images/bOff.png')"});
                        $bCine.attr("title","show");
                    }
                    hide[5] = !hide[5];
                });
                $bPlaya.click(function(){
                    seriesOcio[1].setVisible(hide[6]);
                    if(hide[6]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bPlaya.css({"background-image": "url('../images/bOn.bmp')"});
                        $bPlaya.attr("title","hide");
                    }else{
                        $bPlaya.css({"background-image": "url('../images/bOff.png')"});
                        $bPlaya.attr("title","show");
                    }
                    hide[6] = !hide[6];
                });
                $bBaile.click(function(){
                    seriesOcio[2].setVisible(hide[7]);
                    if(hide[7]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bBaile.css({"background-image": "url('../images/bOn.bmp')"});
                        $bBaile.attr("title","hide");
                    }else{
                        $bBaile.css({"background-image": "url('../images/bOff.png')"});
                        $bBaile.attr("title","show");
                    }
                    hide[7] = !(hide[7]);
                });
                $bArte.click(function(){
                    seriesOcio[3].setVisible(hide[8]);
                    if(hide[8]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bArte.css({"background-image": "url('../images/bOn.bmp')"});
                        $bArte.attr("title","hide");
                    }else{
                        $bArte.css({"background-image": "url('../images/bOff.png')"});
                        $bArte.attr("title","show");
                    }
                    hide[8] = !hide[8];
                });
                $bTeatro.click(function(){
                    seriesOcio[4].setVisible(hide[9]);
                    if(hide[9]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bTeatro.css({"background-image": "url('../images/bOn.bmp')"});
                        $bTeatro.attr("title","hide");
                    }else{
                        $bTeatro.css({"background-image": "url('../images/bOff.png')"});
                        $bTeatro.attr("title","show");
                    }
                    hide[9] = !hide[9];
                });
                $bMusica.click(function(){
                    seriesOcio[5].setVisible(hide[10]);
                    if(hide[10]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bMusica.css({"background-image": "url('../images/bOn.bmp')"});
                        $bMusica.attr("title","hide");
                    }else{
                        $bMusica.css({"background-image": "url('../images/bOff.png')"});
                        $bMusica.attr("title","show");
                    }
                    hide[10] = !hide[10];
                });
                $bConciertos.click(function(){
                    seriesOcio[6].setVisible(hide[11]);
                    if(hide[11]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bConciertos.css({"background-image": "url('../images/bOn.bmp')"});
                        $bConciertos.attr("title","hide");
                    }else{
                        $bConciertos.css({"background-image": "url('../images/bOff.png')"});
                        $bConciertos.attr("title","show");
                    }
		    hide[11] = !(hide[11]);
                });
                $bRestaurantes.click(function(){
                    seriesOcio[7].setVisible(hide[12]);
                    if(hide[12]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bRestaurantes.css({"background-image": "url('../images/bOn.bmp')"});
                        $bRestaurantes.attr("title","hide");
                    }else{
                        $bRestaurantes.css({"background-image": "url('../images/bOff.png')"});
                        $bRestaurantes.attr("title","show");
                    }
                    hide[12] = !hide[12];
                });
                $bHotel.click(function(){
                    seriesOcio[8].setVisible(hide[13]);
                    if(hide[13]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bHotel.css({"background-image": "url('../images/bOn.bmp')"});
                        $bHotel.attr("title","hide");
                    }else{
                        $bHotel.css({"background-image": "url('../images/bOff.png')"});
                        $bHotel.attr("title","show");
                    }
                    hide[13] = !hide[13];
                });
                
                $bOcio.click(function(){
                    var pathImg,titulo;
                    for(i=0,l=seriesOcio.length;i<l;i++){
                        seriesOcio[i].setVisible(hideOcio,false);
                        hide[l-1-i] = !hideOcio;
                    }
                    chart.redraw();
                    if(hideOcio){
                        pathImg='"../images/bOn.bmp"';
                        titulo='hide';
                    }else{
                        pathImg='"../images/bOff.png"'; 
                        titulo='show';
                    }
                    $bCine.css({'background-image':'url('+pathImg+')'});
                    $bCine.attr("title",titulo);
                    $bPlaya.css({"background-image":'url('+pathImg+')'});
                    $bPlaya.attr('title',titulo);
                    $bBaile.css({"background-image":'url('+pathImg+')'});
                    $bBaile.attr('title',titulo);
                    $bTeatro.css({"background-image":'url('+pathImg+')'});
                    $bTeatro.attr('title',titulo);
                    $bMusica.css({"background-image":'url('+pathImg+')'});
                    $bMusica.attr('title',titulo);
                    $bConciertos.css({"background-image":'url('+pathImg+')'});
                    $bConciertos.attr('title',titulo);
                    $bRestaurantes.css({"background-image":'url('+pathImg+')'});
                    $bRestaurantes.attr('title',titulo);
                    $bArte.css({"background-image":'url('+pathImg+')'});
                    $bArte.attr('title',titulo);
                    $bHotel.css({"background-image":'url('+pathImg+')'});
                    $bHotel.attr('title',titulo);
                    $bOcio.css({"background-image":'url('+pathImg+')'});
                    $bOcio.attr("title",titulo);
                    hideOcio = !hideOcio;
                });
                
                $bIslas.click(function(){
                    var pathImg,titulo;
                    for(i=0,l=seriesIslas.length;i<l;i++){
                        seriesIslas[i].setVisible(hideIslas,false);
                        hide[i] = !hideIslas;
                    }
                    chart.redraw();
                    if(hideIslas){
                        pathImg='"../images/bOn.bmp"';
                        titulo='hide';
                    }else{
                        pathImg='"../images/bOff.png"'; 
                        titulo='show';
                    }
                    $bIslas.css({'background-image':'url('+pathImg+')'});
                    $bIslas.attr("title",titulo);
                    $bMallorca.css({"background-image":'url('+pathImg+')'});
                    $bIslas.attr('title',titulo);
                    $bMenorca.css({"background-image":'url('+pathImg+')'});
                    $bMenorca.attr('title',titulo);
                    $bIbiza.css({"background-image":'url('+pathImg+')'});
                    $bIbiza.attr('title',titulo);
                    $bFormentera.css({"background-image":'url('+pathImg+')'});
                    $bFormentera.attr('title',titulo);
                    $bBal.css({"background-image":'url('+pathImg+')'});
                    $bBal.attr('title',titulo);
                    hideIslas = !hideIslas;
                }); 
                
                
                    
                });
            </script>
            
            
            <% DataChart chartSpider = DBActions.getSpiderChart(); %>           
            <script type="text/javascript" >
               
            $(function () {
                $('#containerSpider').highcharts({

                chart: {
                    polar: true,
                    type: 'line'
                },

                title: {
                    text: 'Tweets por categoria y procedencia',
                    x: -80
                },

                pane: {
                    size: '80%'
                },

                xAxis: {
                    categories: <% out.print(chartSpider.getCategorias()); %>,
                    tickmarkPlacement: 'on',
                    lineWidth: 0
                },

                yAxis: {
                    gridLineInterpolation: 'polygon',
                    lineWidth: 0,
                    min: 0
                },

                tooltip: {
                    shared: true,
                    pointFormat: '<span style="color:{series.color}">{series.name}:<b>\${point.y:,.0f}</b><br/>'
                },

                legend: {
                    align: 'right',
                    verticalAlign: 'top',
                    y: 70,
                    layout: 'vertical'
                },

                series: [
                    <%
                        numSeries=chartSpider.getSeries().size();
                        for(int i=0; i<numSeries;i++){
                            String serie, serieName = chartSpider.getSeries().get(i).toString();
                            serie="{\n name: "+ serieName+",\n"
                                    +"id: "+serieName.toLowerCase()+",\n"
                                  +"data: "+chartSpider.getDatos().get(i)+"\n},\n";
                            out.print(serie);
                        }
                    %>
                    
                    ]
                });
                var chart = $("#containerSpider").highcharts(),
                $bMallorca=$('#buttonMall3'),
                $bMenorca=$('#buttonMen3'),
                $bIbiza=$('#buttonIb3'),
                $bFormentera=$('#buttonFor3'),
                $bBal=$('#buttonBal3'),
                $bCine=$('#buttonCine3'),
                $bPlaya=$('#buttonPlaya3'),
                $bBaile=$('#buttonBaile3'),
                $bTeatro=$('#buttonTeatro3'),
                $bMusica=$('#buttonMusic3'),
                $bConciertos=$('#buttonConc3'),
                $bRestaurantes=$('#buttonRest3'),
                $bArte=$('#buttonArte3'),
                $bHotel=$('#buttonHotel3'),
                $bIslas=$('#buttonIslas3'),
                $bOcio=$('#buttonOcio3'),
                seriesIslas = [chart.get("mallorca"),chart.get("menorca"),chart.get("ibiza"),chart.get("formentera"),chart.get("baleares")],
                seriesOcio = [chart.get("cine"),chart.get("playa"),chart.get("baile"),chart.get("arte"),chart.get("teatro"),chart.get("musica"),chart.get("conciertos"),chart.get("restaurantes"),chart.get("hotel")],
                hide =  [false,false,false,false,false,false,false,false,false,false,false,false,false,false],
                hideOcio = false,
                hideIslas = false;
                
                $bMallorca.click(function(){
                    seriesIslas[0].setVisible(hide[0]);
                    if(hide[0]) { // if se ha de mostrar el dato
                        if(hideIslas){ //if anteriormente se ocultaron todas las islas
                            $bIslas.css({"background-image": "url('../images/bOn.bmp')"});
                            $bIslas.attr("title","hide");
                            hideIslas=false;
                        }
                        $bMallorca.css({"background-image": "url('../images/bOn.bmp')"});
                        $bMallorca.attr("title","hide");
                    }else{
                        $bMallorca.css({"background-image": "url('../images/bOff.png')"});
                        $bMallorca.attr("title","show");
                    }
                    hide[0] = !(hide[0]);
                });
                $bMenorca.click(function(){
                    seriesIslas[1].setVisible(hide[1]);
                    if(hide[1]) { // if se ha de mostrar el dato
                        if(hideIslas){ //if anteriormente se ocultaron todas las islas
                            $bIslas.css({"background-image": "url('../images/bOn.bmp')"});
                            $bIslas.attr("title","hide");
                            hideIslas=false;
                        }
                        $bMenorca.css({"background-image": "url('../images/bOn.bmp')"});
                        $bMenorca.attr("title","hide");
                    }else{
                        $bMenorca.css({"background-image": "url('../images/bOff.png')"});
                        $bMenorca.attr("title","show");
                    }
                    hide[1] = !hide[1];
                });
                $bIbiza.click(function(){
                    seriesIslas[2].setVisible(hide[2]);
                    if(hide[2]) { // if se ha de mostrar el dato
                        if(hideIslas){ //if anteriormente se ocultaron todas las islas
                            $bIslas.css({"background-image": "url('../images/bOn.bmp')"});
                            $bIslas.attr("title","hide");
                            hideIslas=false;
                        }
                        $bIbiza.css({"background-image": "url('../images/bOn.bmp')"});
                        $bIbiza.attr("title","hide");
                    }else{
                        $bIbiza.css({"background-image": "url('../images/bOff.png')"});
                        $bIbiza.attr("title","show");
                    }
                    hide[2] = !hide[2];
                });
                $bFormentera.click(function(){
                    seriesIslas[3].setVisible(hide[3]);
                    if(hide[3]) { // if se ha de mostrar el dato
                        if(hideIslas){ //if anteriormente se ocultaron todas las islas
                            $bIslas.css({"background-image": "url('../images/bOn.bmp')"});
                            $bIslas.attr("title","hide");
                            hideIslas=false;
                        }
                        $bFormentera.css({"background-image": "url('../images/bOn.bmp')"});
                        $bFormentera.attr("title","hide");
                    }else{
                        $bFormentera.css({"background-image": "url('../images/bOff.png')"});
                        $bFormentera.attr("title","show");
                    }
                    hide[3] = !(hide[3]);
                });
                $bBal.click(function(){
                    seriesIslas[4].setVisible(hide[4]);
                    if(hide[4]) { // if se ha de mostrar el dato
                        if(hideIslas){ //if anteriormente se ocultaron todas las islas
                            $bIslas.css({"background-image": "url('../images/bOn.bmp')"});
                            $bIslas.attr("title","hide");
                            hideIslas=false;
                        }
                        $bBal.css({"background-image": "url('../images/bOn.bmp')"});
                        $bBal.attr("title","hide");
                    }else{
                        $bBal.css({"background-image": "url('../images/bOff.png')"});
                        $bBal.attr("title","show");
                    }
                    hide[4] = !hide[4];
                });
                $bCine.click(function(){  
                    seriesOcio[0].setVisible(hide[5]);
                    if(hide[5]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bCine.css({"background-image": "url('../images/bOn.bmp')"});
                        $bCine.attr("title","hide");
                    }else{
                        $bCine.css({"background-image": "url('../images/bOff.png')"});
                        $bCine.attr("title","show");
                    }
                    hide[5] = !hide[5];
                });
                $bPlaya.click(function(){
                    seriesOcio[1].setVisible(hide[6]);
                    if(hide[6]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bPlaya.css({"background-image": "url('../images/bOn.bmp')"});
                        $bPlaya.attr("title","hide");
                    }else{
                        $bPlaya.css({"background-image": "url('../images/bOff.png')"});
                        $bPlaya.attr("title","show");
                    }
                    hide[6] = !hide[6];
                });
                $bBaile.click(function(){
                    seriesOcio[2].setVisible(hide[7]);
                    if(hide[7]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bBaile.css({"background-image": "url('../images/bOn.bmp')"});
                        $bBaile.attr("title","hide");
                    }else{
                        $bBaile.css({"background-image": "url('../images/bOff.png')"});
                        $bBaile.attr("title","show");
                    }
                    hide[7] = !(hide[7]);
                });
                $bArte.click(function(){
                    seriesOcio[3].setVisible(hide[8]);
                    if(hide[8]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bArte.css({"background-image": "url('../images/bOn.bmp')"});
                        $bArte.attr("title","hide");
                    }else{
                        $bArte.css({"background-image": "url('../images/bOff.png')"});
                        $bArte.attr("title","show");
                    }
                    hide[8] = !hide[8];
                });
                $bTeatro.click(function(){
                    seriesOcio[4].setVisible(hide[9]);
                    if(hide[9]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bTeatro.css({"background-image": "url('../images/bOn.bmp')"});
                        $bTeatro.attr("title","hide");
                    }else{
                        $bTeatro.css({"background-image": "url('../images/bOff.png')"});
                        $bTeatro.attr("title","show");
                    }
                    hide[9] = !hide[9];
                });
                $bMusica.click(function(){
                    seriesOcio[5].setVisible(hide[10]);
                    if(hide[10]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bMusica.css({"background-image": "url('../images/bOn.bmp')"});
                        $bMusica.attr("title","hide");
                    }else{
                        $bMusica.css({"background-image": "url('../images/bOff.png')"});
                        $bMusica.attr("title","show");
                    }
                    hide[10] = !hide[10];
                });
                $bConciertos.click(function(){
                    seriesOcio[6].setVisible(hide[11]);
                    if(hide[11]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bConciertos.css({"background-image": "url('../images/bOn.bmp')"});
                        $bConciertos.attr("title","hide");
                    }else{
                        $bConciertos.css({"background-image": "url('../images/bOff.png')"});
                        $bConciertos.attr("title","show");
                    }
		    hide[11] = !(hide[11]);
                });
                $bRestaurantes.click(function(){
                    seriesOcio[7].setVisible(hide[12]);
                    if(hide[12]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bRestaurantes.css({"background-image": "url('../images/bOn.bmp')"});
                        $bRestaurantes.attr("title","hide");
                    }else{
                        $bRestaurantes.css({"background-image": "url('../images/bOff.png')"});
                        $bRestaurantes.attr("title","show");
                    }
                    hide[12] = !hide[12];
                });
                $bHotel.click(function(){
                    seriesOcio[8].setVisible(hide[13]);
                    if(hide[13]) { // if se ha de mostrar el dato
                        if(hideOcio){ //if anteriormente se ocultaron todas las islas
                            $bOcio.css({"background-image": "url('../images/bOn.bmp')"});
                            $bOcio.attr("title","hide");
                            hideOcio=false;
                        }
                        $bHotel.css({"background-image": "url('../images/bOn.bmp')"});
                        $bHotel.attr("title","hide");
                    }else{
                        $bHotel.css({"background-image": "url('../images/bOff.png')"});
                        $bHotel.attr("title","show");
                    }
                    hide[13] = !hide[13];
                });
                
                $bOcio.click(function(){
                    var pathImg,titulo;
                    for(i=0,l=seriesOcio.length;i<l;i++){
                        seriesOcio[i].setVisible(hideOcio,false);
                        hide[l-1-i] = !hideOcio;
                    }
                    chart.redraw();
                    if(hideOcio){
                        pathImg='"../images/bOn.bmp"';
                        titulo='hide';
                    }else{
                        pathImg='"../images/bOff.png"'; 
                        titulo='show';
                    }
                    $bCine.css({'background-image':'url('+pathImg+')'});
                    $bCine.attr("title",titulo);
                    $bPlaya.css({"background-image":'url('+pathImg+')'});
                    $bPlaya.attr('title',titulo);
                    $bBaile.css({"background-image":'url('+pathImg+')'});
                    $bBaile.attr('title',titulo);
                    $bTeatro.css({"background-image":'url('+pathImg+')'});
                    $bTeatro.attr('title',titulo);
                    $bMusica.css({"background-image":'url('+pathImg+')'});
                    $bMusica.attr('title',titulo);
                    $bConciertos.css({"background-image":'url('+pathImg+')'});
                    $bConciertos.attr('title',titulo);
                    $bRestaurantes.css({"background-image":'url('+pathImg+')'});
                    $bRestaurantes.attr('title',titulo);
                    $bArte.css({"background-image":'url('+pathImg+')'});
                    $bArte.attr('title',titulo);
                    $bHotel.css({"background-image":'url('+pathImg+')'});
                    $bHotel.attr('title',titulo);
                    $bOcio.css({"background-image":'url('+pathImg+')'});
                    $bOcio.attr("title",titulo);
                    hideOcio = !hideOcio;
                });
                
                $bIslas.click(function(){
                    var pathImg,titulo;
                    for(i=0,l=seriesIslas.length;i<l;i++){
                        seriesIslas[i].setVisible(hideIslas,false);
                        hide[i] = !hideIslas;
                    }
                    chart.redraw();
                    if(hideIslas){
                        pathImg='"../images/bOn.bmp"';
                        titulo='hide';
                    }else{
                        pathImg='"../images/bOff.png"'; 
                        titulo='show';
                    }
                    $bIslas.css({'background-image':'url('+pathImg+')'});
                    $bIslas.attr("title",titulo);
                    $bMallorca.css({"background-image":'url('+pathImg+')'});
                    $bIslas.attr('title',titulo);
                    $bMenorca.css({"background-image":'url('+pathImg+')'});
                    $bMenorca.attr('title',titulo);
                    $bIbiza.css({"background-image":'url('+pathImg+')'});
                    $bIbiza.attr('title',titulo);
                    $bFormentera.css({"background-image":'url('+pathImg+')'});
                    $bFormentera.attr('title',titulo);
                    $bBal.css({"background-image":'url('+pathImg+')'});
                    $bBal.attr('title',titulo);
                    hideIslas = !hideIslas;
                });                              
                
            });             
            </script>
    </head>
    <body>
        <%@include  file ="cabecera.jsp" %>
        <script src="../js-charts/highcharts.js"></script>
        <script src="../js-charts/highcharts-3d.js"></script>
        <script src="../js-charts/modules/exporting.js"></script>
        <script src="../js-charts/highcharts-more.js"></script>
        <script src="../js-charts/modules/data.js"></script>
        
        <nav id="leftMenu">
            <div class="user">
                <table border="0">
                    <tbody>
                        <tr>
                            <td>
                                <img src="../images/Icon-user.png" width="50" height="50" alt="Icon-user"/>
                            </td>
                            <td id="welcomUser">
                                <p id="welcom">Welcome</p>
                                <p id="username"><% out.print(session.getAttribute("user")); %></p>
                            </td>
                        </tr>
                    </tbody>
                </table>

            </div>
            <ul id="opcionList">
                <li class="opcion">
                    <div class="barra"></div>
                    <div class="menu" id="linkhome">
                         <a  class="menu" href="http://localhost:8080/WSPractica1/private/home.jsp">Home</a>
                    </div>     
                </li>
                
                <li class="opcion">
                    <div class="barra"></div>
                    <div class="menu" id="hold">
                        <a  class="menu" id="holdLi" href="http://localhost:8080/WSPractica1/private/tendencias.jsp">Tendencias</a>
                    </div> 
                </li>
                
                <li class="opcion">
                    <div class="barra"></div>
                    <div class="menu">
                        <a  class="menu" href="http://localhost:8080/WSPractica1/private/correo.jsp">Correo</a>
                    </div> 
                </li>
                
                <li class="opcion">
                    <div class="barra"></div>
                    <div class="menu">
                        <a  class="menu" href="http://localhost:8080/WSPractica1/private/gestion.jsp">Gestión de usuarios</a>
                    </div> 
                </li>
            </ul>
            <div id="bottomOr"></div>
            
        </nav>
        <div id="main">
            <div id="menuTop">
                <h1 id="titledash">Dash Board Tendencias</h1>
                <script type="text/javascript">
                     $(document).ready(function(){
                        var description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce id tortor nisi. Aenean sodales diam ac lacus elementum scelerisque. Suspendisse a dui vitae lacus faucibus venenatis vel id nisl. Proin orci ante, ultricies nec interdum at, iaculis venenatis nulla. ';

                        $( "#menuTop").ttwMusicPlayer(myPlaylist, {
                            autoPlay:false, 
                            description:description,
                            jPlayer:{
                                swfPath:'../plugin/jquery-jplayer' //You need to override the default swf path any time the directory structure changes
                            }
                        });
                    });
                    </script>
            </div>
            <div id="content">
                <table border="0" id="tableChart">
                    <tbody>
                        <tr>
                            <td class="celltable" colspan="1">
                                <div id="containerDonut"></div>
                                
                            </td>
                            <td class="celltable" colspan="1">
                                <div  id="containerSpider"></div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div id="botonesPie">
                    <h3>Control de series grafico Pie</h3>
                    <label for="buttonMall2">Mallorca:</label>
                    <button id="buttonMall2" name="areaIsla" title="hide" class="autocompare"> </button>
                    <label for="buttonMen2" >Menorca:
                        <button id="buttonMen2" name="areaIsla" title="hide" class="autocompare"></button></label>
                    <label for="buttonIb2" >Ibiza:</label>
                    <button id="buttonIb2" name="areaIsla" title="hide" class="autocompare"></button>
                    <label for="buttonFor2" >Formentera:</label>            
                    <button id="buttonFor2" name="areaOcio" title="hide" class="autocompare"></button>
                    <label for="buttonBal2" >Baleares:</label>
                    <button id="buttonBal2" name="areaIsla" title="hide" class="autocompare"></button>
                    <br>
                    <label for="buttonCine2" >Cine:</label>
                    <button id="buttonCine2" title="areaOcio" class="autocompare"></button>
                    <label for="buttonPlaya2" > Playa:</label>
                    <button id="buttonPlaya2" title="areaOcio" class="autocompare"></button>
                    <label for="buttonBaile2" >Baile:</label>
                    <button id="buttonBaile2" title="areaOcio" class="autocompare"></button>
                    <label for="buttonTeatro2" >Teatro:</label>
                    <button id="buttonTeatro2" title="areaOcio" class="autocompare"></button>
                    <label for="buttonMusic2" >Musica:</label>
                    <button id="buttonMusic2" title="areaOcio" class="autocompare"></button>
                    <label for="buttonConc2" >Conciertos:</label>
                    <button id="buttonConc2" title="areaOcio" class="autocompare"></button>
                    <label for="buttonRest2" >Rest.:</label>
                    <button id="buttonRest2" title="areaOcio" class="autocompare"></button>
                    <label for="buttonArte2" >Arte:</label>
                    <button id="buttonArte2" title="areaOcio" class="autocompare"></button>
                    <label for="buttonHotel2" >Hotel:</label>
                    <button id="buttonHotel2" title="areaOcio" class="autocompare"></button>
                    <br>
                    <label for="buttonIslas2">Islas:</label>
                    <button id="buttonIslas2" name="groupIslas" title="hide" class="autocompare"></button>
                    <label for="buttonOcio2">Ocio:</label>
                    <button id="buttonOcio2" title="point" class="autocompare"></button>    
                </div>
                <div id="botonesSpider">
                    <h3>Control de series grafico spider</h3>
                   <label for="buttonMall3">Mallorca:</label>
                    <button id="buttonMall3" name="areaIsla" title="hide" class="autocompare"> </button>
                    <label for="buttonMen3" >Menorca:
                        <button id="buttonMen3" name="areaIsla" title="hide" class="autocompare"></button></label>
                    <label for="buttonIb3" >Ibiza:</label>
                    <button id="buttonIb3" name="areaIsla" title="hide" class="autocompare"></button>
                    <label for="buttonFor3" >Formentera:</label>            
                    <button id="buttonFor3" name="areaOcio" title="hide" class="autocompare"></button>
                    <label for="buttonBal3" >Baleares:</label>
                    <button id="buttonBal3" name="areaIsla" title="hide" class="autocompare"></button>
                    <br>
                    <label for="buttonCine3" >Cine:</label>
                    <button id="buttonCine3" title="areaOcio" class="autocompare"></button>
                    <label for="buttonPlaya3" > Playa:</label>
                    <button id="buttonPlaya3" title="areaOcio" class="autocompare"></button>
                    <label for="buttonBaile3" >Baile:</label>
                    <button id="buttonBaile3" title="areaOcio" class="autocompare"></button>
                    <label for="buttonTeatro3" >Teatro:</label>
                    <button id="buttonTeatro3" title="areaOcio" class="autocompare"></button>
                    <label for="buttonMusic3" >Musica:</label>
                    <button id="buttonMusic3" title="areaOcio" class="autocompare"></button>
                    <label for="buttonConc3" >Conciertos:</label>
                    <button id="buttonConc3" title="areaOcio" class="autocompare"></button>
                    <label for="buttonRest3" >Rest.:</label>
                    <button id="buttonRest3" title="areaOcio" class="autocompare"></button>
                    <label for="buttonArte3" >Arte:</label>
                    <button id="buttonArte3" title="areaOcio" class="autocompare"></button>
                    <label for="buttonHotel3" >Hotel:</label>
                    <button id="buttonHotel3" title="areaOcio" class="autocompare"></button>
                    <br>
                    <label for="buttonIslas3">Islas:</label>
                    <button id="buttonIslas3" name="groupIslas" title="hide" class="autocompare"></button>
                    <label for="buttonOcio3">Ocio:</label>
                    <button id="buttonOcio3" title="point" class="autocompare"></button>     
            </div>
                <table border="0" id="tableChart">
                    
                    <tbody>
                        <tr>
                            <td class="celltable">
                                <div id="containerBar"></div>
                                <div>
                                    <label for="buttonOcio">Ocio:</label>
                                    <button id="buttonOcio" class="autocompare" type="button">  </button>        
                                    <label for="buttonBaleares">Baleares:</label>
                                    <button id="buttonBaleares" class="autocompare" type="button"></button>     
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <table border="0" id="tableChart">
                    
                    <tbody>
                        <tr>
                            <td class="celltable">
                                <div id="containerArea"></div>
                                <div id="botonesArea">
                                    <label for="buttonMall1">Mallorca:</label>
                                    <button id="buttonMall1" name="areaIsla" title="hide" class="autocompare"> </button>
                                    <label for="buttonMen1" >Menorca:
                                    <button id="buttonMen1" name="areaIsla" title="hide" class="autocompare"></button></label>
                                    <label for="buttonIb1" >Ibiza:</label>
                                    <button id="buttonIb1" name="areaIsla" title="hide" class="autocompare"></button>
                                    <label for="buttonFor1" >Formentera:</label>            
                                    <button id="buttonFor1" name="areaOcio" title="hide" class="autocompare"></button>
                                    <label for="buttonBal1" >Baleares:</label>
                                    <button id="buttonBal1" name="areaIsla" title="hide" class="autocompare"></button>
                                    <br>
                                    <label for="buttonCine1" >Cine:</label>
                                    <button id="buttonCine1" title="areaOcio" class="autocompare"></button>
                                    <label for="buttonPlaya1" > Playa:</label>
                                    <button id="buttonPlaya1" title="areaOcio" class="autocompare"></button>
                                    <label for="buttonBaile1" >Baile:</label>
                                    <button id="buttonBaile1" title="areaOcio" class="autocompare"></button>
                                    <label for="buttonTeatro1" >Teatro:</label>
                                    <button id="buttonTeatro1" title="areaOcio" class="autocompare"></button>
                                    <label for="buttonMusic1" >Musica:</label>
                                    <button id="buttonMusic1" title="areaOcio" class="autocompare"></button>
                                    <label for="buttonConc1" >Conciertos:</label>
                                    <button id="buttonConc1" title="areaOcio" class="autocompare"></button>
                                    <label for="buttonRest1" >Rest.:</label>
                                    <button id="buttonRest1" title="areaOcio" class="autocompare"></button>
                                    <label for="buttonArte1" >Arte:</label>
                                    <button id="buttonArte1" title="areaOcio" class="autocompare"></button>
                                    <label for="buttonHotel1" >Hotel:</label>
                                    <button id="buttonHotel1" title="areaOcio" class="autocompare"></button>
                                    <br>
                                    <label for="buttonIslas1">Islas:</label>
                                    <button id="buttonIslas1" name="groupIslas" title="hide" class="autocompare"></button>
                                    <label for="buttonOcio1">Ocio:</label>
                                    <button id="buttonOcio1" title="point" class="autocompare"></button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                

                
                
                
            </div>
        </div>
            
    </body>
</html>
