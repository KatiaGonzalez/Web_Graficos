<%-- 
    Document   : index
    Created on : 11-ene-2016, 23:48:29
    Author     : van
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/style.css"/>
        <script src="js-jquery/jquery-1.11.3.js" type="text/javascript"></script>
        <script src="js/WScalls.js" type="text/javascript"></script>
        <script>
            function onBlur(el) {
                if (el.value === '') {
                    el.value = el.defaultValue;
                }
            }
            function onFocus(el) {
                if (el.value === el.defaultValue) {
                    el.value = '';
                }
            }
        </script>
    </head>
    <body id="loginBody">
            <div id="loginBox">
                <div id="loginOrange"></div>
                <div id="loginBoxMain">
                    <table border="0" class="loginCell">
                        <tbody>
                            <tr class="loginCell">
                                <td id="logInTitle">Iniciar sesión</td>
                            </tr>
                            <tr class="loginCell">
                                <td>
                                    <input type="text" name="userBox" id="userBox" value="Username" onblur="onBlur(this)" onfocus="onFocus(this)" />
                                </td>
                            </tr>
                            <tr class="loginCell">
                                <td>
                                    <input type="password" name="passBox" id="passBox" value="password" onblur="onBlur(this)" onfocus="onFocus(this)" />
                                </td>
                            </tr>
                            <tr class="loginCell">
                                <td>
                                    <input type="submit" value="Iniciar Sesion" name="loginButton" id="loginButton" onclick="logIn(document.getElementById('userBox').value,document.getElementById('passBox').value); return false;"/>                                </td>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <form method="post" action='private/home.jsp' id="insert_form"></form>
            </div>
    </body>
</html>
