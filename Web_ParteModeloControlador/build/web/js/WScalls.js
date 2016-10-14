/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var webServiceURL = 'http://localhost:8080/WSPractica1/WSGeneral';
var soapMessagegetfrutas = '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"><SOAP-ENV:Header/><S:Body><ns2:getfrutas xmlns:ns2="http://ltimws/"/></S:Body></S:Envelope>';
var soapMessageKilos = '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"><SOAP-ENV:Header/><S:Body><ns2:getkilos xmlns:ns2="http://ltimws/"/></S:Body></S:Envelope>';
var soapMessagePorc = '<?xml version="1.0" encoding="UTF-8"?><S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"><SOAP-ENV:Header/><S:Body><ns2:getporc xmlns:ns2="http://ltimws/"><indice>3</indice></ns2:getporc></S:Body></S:Envelope>';
var usuario;
var password;

function logIn(usr, pass)
{
    usuario = usr;
    password = pass;
    var soapMessageLogIn = 
    '<?xml version="1.0" encoding="UTF-8"?><S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"> \
     <SOAP-ENV:Header/> \
     <S:Body> \
        <ns2:login xmlns:ns2="http://webservices/"> \
            <nombre>' + usr + '</nombre> \
            <clave>' + pass + '</clave> \
        </ns2:login> \
     </S:Body>\
     </S:Envelope>';
    $.ajax({
        url: webServiceURL,
        type: "POST",
        dataType: "text",
        data: soapMessageLogIn,
        contentType: "text/xml; charset=\"utf-8\"",
        success: OnSuccess,
        error: OnError
    });
    return false;
}
function getUserNames(select)
{
    var soapMessageLogIn = 
    '<?xml version="1.0" encoding="UTF-8"?><S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"> \
        <SOAP-ENV:Header/> \
        <S:Body> \
            <ns2:getUsuarios xmlns:ns2="http://webservices/"/> \
        </S:Body> \
    </S:Envelope>';
    $.ajax({
        url: webServiceURL,
        type: "POST",
        dataType: "xml",
        data: soapMessageLogIn,
        contentType: "text/xml; charset=\"utf-8\"",
        success: function (data,status) {
                if (data.body !== "") {
                    $(data).find("return").each( function() {
                        $("#"+select+"").append(new Option($(this).find("nombre").text(), $(this).find("nombre").text()));
                    });                    
                }
            },
        error: OnError
    });
    return false;
}
function getUser()
{
    var soapMessageLogIn = 
    '<?xml version="1.0" encoding="UTF-8"?><S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"> \
        <SOAP-ENV:Header/> \
        <S:Body> \
            <ns2:getUsuarios xmlns:ns2="http://webservices/"/> \
        </S:Body> \
    </S:Envelope>';
    $.ajax({
        url: webServiceURL,
        type: "POST",
        dataType: "xml",
        data: soapMessageLogIn,
        contentType: "text/xml; charset=\"utf-8\"",
        success: function (data,status) {
                if (data.body !== "") {
                    $(data).find("return").each( function() {
                        
                        var newRow = "<tr class=\"listUsr\"><td class=\"listUsr\">" + $(this).find("nombre").text() + "</td><td class=\"listUsr\">" + $(this).find("nivel").text() + "</td></tr>";
                        $("#userHeader").after(newRow);
                    });                    
                }
            },
        error: OnError
    });
    return false;
}
function AddUser(usr, pass, lvl)
{
    usuario = usr;
    password = pass;
    var soapMessageLogIn = 
    '<?xml version="1.0" encoding="UTF-8"?><S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"> \
    <SOAP-ENV:Header/> \
    <S:Body> \
        <ns2:SetUsuario xmlns:ns2="http://webservices/"> \
            <nombre>' + usr + '</nombre> \
            <password>' + pass + '</password> \\n\
            <nivel>' + lvl + '</nivel> \
            </ns2:SetUsuario> \
        </S:Body> \
    </S:Envelope>';
    $.ajax({
        url: webServiceURL,
        type: "POST",
        dataType: "xml",
        data: soapMessageLogIn,
        contentType: "text/xml; charset=\"utf-8\"",
        success: function (data) {
                if (parseInt($(data).find("return").text()) > 0) {
                    alert('Usuario creado correctamente');
                    var newRow = "<tr class=\"listUsr\"><td class=\"listUsr\">" + usr + "</td><td class=\"listUsr\">" + lvl + "</td></tr>";
                    $("#userHeader").after(newRow);
                    
                }else{
                     alert('La datos no son validos');
                }
            },
        error: OnLogError
    });
    return false;
}
function DeleteUser(usr)
{
    var soapMessageLogIn = 
    '<?xml version="1.0" encoding="UTF-8"?><S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"> \
    <SOAP-ENV:Header/> \
    <S:Body> \
        <ns2:deleteUsuario xmlns:ns2="http://webservices/"> \
            <nombre>' + usr + '</nombre> \
        </ns2:deleteUsuario> \
    </S:Body> \
</S:Envelope>';
    $.ajax({
        url: webServiceURL,
        type: "POST",
        dataType: "xml",
        data: soapMessageLogIn,
        contentType: "text/xml; charset=\"utf-8\"",
        success: function (data) {
                if (parseInt($(data).find("return").text()) > 0) {
                    alert('Usuario eliminado correctamente');
                    //var newRow = "<tr class=\"listUsr\"><td class=\"listUsr\">" + usr + "</td><td class=\"listUsr\">" + lvl + "</td></tr>";
                    //$("#userHeader").after(newRow);
                    $("#userDelBox option[value='"+usr+"']").remove();
                }else{
                     alert('La datos no son validos');
                }
            },
        error: OnLogError
    });
    return false;
}

function OnLogError()
{
    alert('La datos no son validos');
}

function OnSuccess(data, status)
{
    var auxstr = data.toString() + "";
    var ini = auxstr.search("<return>") + 8;
    var fin = auxstr.search("</return>");
    auxstr = auxstr.substring(ini,fin);
    if( auxstr < 0 ){
        alert("El usuario o la contraseña son incorrectos");
    }else{
        $('#insert_form').html( 
       '<form action=\"url\" name=\"form\" method=\"post\" style=\"display:none;\"> \
        <input type=\"text\" name=\"user\" value=\"' + usuario + '\" /></form> \
        <input type=\"text\" name=\"pass\" value=\"' + password + '\" /></form> \
        <input type=\"text\" name=\"lvl\" value=\"' + auxstr + '\" /></form>');
        document.forms['insert_form'].submit();
    }
}

function OnError(request, status, error)
{
    alert('error');
}

//$(document).ready(function () {
//    jQuery.support.cors = true;
//});
function sendMsg(emisor, destino, asunto, msg)
{
    var soapMessageLogIn = 
    '<?xml version="1.0" encoding="UTF-8"?><S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"> \
    <SOAP-ENV:Header/> \
    <S:Body> \
        <ns2:sendMsg xmlns:ns2="http://webservices/"> \
            <nomDest>' + destino + '</nomDest> \
            <nomEmisor>' + emisor + '</nomEmisor> \
            <asunto>' + asunto + '</asunto> \
            <msg>' + msg + '</msg> \
        </ns2:sendMsg> \
    </S:Body> \
    </S:Envelope>';
    $.ajax({
        url: webServiceURL,
        type: "POST",
        dataType: "xml",
        data: soapMessageLogIn,
        contentType: "text/xml; charset=\"utf-8\"",
        success: function (data) {
                if (parseInt($(data).find("return").text()) > 0) {
                    alert('Mensaje enviado!');
                    
                }else{
                     alert('La datos no son validos');
                }
            },
        error: OnLogError
    });
    return false;
}
function DeleteMsg(id)
{
    var soapMessageLogIn = 
    '<?xml version="1.0" encoding="UTF-8"?><S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"> \
    <SOAP-ENV:Header/> \
    <S:Body> \
        <ns2:delMensaje xmlns:ns2="http://webservices/"> \
            <id>' + id + '</id> \
        </ns2:delMensaje> \
    </S:Body> \
    </S:Envelope>';
    $.ajax({
        url: webServiceURL,
        type: "POST",
        dataType: "xml",
        data: soapMessageLogIn,
        contentType: "text/xml; charset=\"utf-8\"",
        success: function (data) {
                if (parseInt($(data).find("return").text()) > 0) {
                    alert('Mensaje eliminado');
                    //var newRow = "<tr class=\"listUsr\"><td class=\"listUsr\">" + usr + "</td><td class=\"listUsr\">" + lvl + "</td></tr>";
                    //$("#userHeader").after(newRow);
                    $("#userDelBox option[value='"+id+"']").remove();
                }else{
                     alert('La datos no son validos');
                }
            },
        error: OnLogError
    });
    return false;
}
function getMsg(nomDestinatario)
{
    var soapMessageLogIn = 
    '<?xml version="1.0" encoding="UTF-8"?><S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"> \
    <SOAP-ENV:Header/> \
    <S:Body> \
        <ns2:getMensajes xmlns:ns2="http://webservices/"> \
            <nomDest>' + nomDestinatario + '</nomDest> \
        </ns2:getMensajes> \
    </S:Body> \
    </S:Envelope>';
    $.ajax({
        url: webServiceURL,
        type: "POST",
        dataType: "xml",
        data: soapMessageLogIn,
        contentType: "text/xml; charset=\"utf-8\"",
        success: function (data,status) {
                if (data.body !== "") {
                    $(data).find("return").each( function() {
                        
                        var newRow = "<tr class=\"listUsr\"><td class=\"listUsr\">"+$(this).find("id").text() +" </td><td class=\"listUsr\">" + $(this).find("emisor").text() + "</td><td class=\"listUsr\">" + $(this).find("asunto").text() + "</td><td class=\"listUsr\">" + $(this).find("msg").text() + "</td></tr>";
                        $("#userHeader").after(newRow);
                    });                    
                }
            },
        error: OnError
    });
    return false;
}
function getMsgId(nomDestinatario)
{
    var soapMessageLogIn = 
    '<?xml version="1.0" encoding="UTF-8"?><S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"> \
    <SOAP-ENV:Header/> \
    <S:Body> \
        <ns2:getMensajes xmlns:ns2="http://webservices/"> \
            <nomDest>' + nomDestinatario + '</nomDest> \
        </ns2:getMensajes> \
    </S:Body> \
    </S:Envelope>';
    $.ajax({
        url: webServiceURL,
        type: "POST",
        dataType: "xml",
        data: soapMessageLogIn,
        contentType: "text/xml; charset=\"utf-8\"",
        success: function (data,status) {
                if (data.body !== "") {
                    $(data).find("return").each( function() {
                        $("#userDelBox").append(new Option($(this).find("id").text(), $(this).find("id").text()));
                    });                    
                }
            },
        error: OnError
    });
    return false;
}

/////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////
function getSeries(data)
{
    var series = new Array();
    $(data).find("series").each( function() {
        series.push($(this).text());
    });
    var datos = new Array();
    $(data).find("datos").each( function() {
        datos.push($(this).text());
    });
    var serie;
    for (i = 0; i < series.length; i++) { 
        serie=serie + "{\n name: "+ series[i]+",\n"
              +"data: "+datos[i]+"\n},\n";
    }
    return serie;
}
function getCategorias(data)
{
    var salida = "[";
    $(data).find("categorias").each( function() {
        salida = salida + $(this).text()+"'";
    });
    salida = salida.substring(0, str.length - 1);
    salida = salida + "]";
    return salida;
}
function getSpiderChart()
{
    var soapMessageLogIn = 
    '<?xml version="1.0" encoding="UTF-8"?><S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"> \
    <SOAP-ENV:Header/> \
    <S:Body> \
        <ns2:getSpider xmlns:ns2="http://webservices/"/>\
    </S:Body> \
    </S:Envelope>';
    $.ajax({
        url: webServiceURL,
        type: "POST",
        dataType: "xml",
        data: soapMessageLogIn,
        contentType: "text/xml; charset=\"utf-8\"",
        success: function () {
                $('#containerSpider').highcharts({

                chart: {
                    polar: true,
                    type: 'line'
                },

                title: {
                    text: 'Budget vs spending',
                    x: -80
                },

                pane: {
                    size: '80%'
                },

                xAxis: {
                    categories: getCategorias(data),
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

                series: [getSeries(data)]
                });
            },
        error: OnError
    });
    return false;
}
