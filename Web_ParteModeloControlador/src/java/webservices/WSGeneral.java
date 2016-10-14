/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package webservices;

import WSBeans.DataChart;
import WSBeans.Mensaje;
import WSBeans.Usuario;
import java.util.ArrayList;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import pruebabd.DBActions;

/**
 *
 * @author katia
 */
@WebService(serviceName = "WSGeneral")
public class WSGeneral {


    /**
     * Web service operation
     */
    @WebMethod(operationName = "getSpider")
    public DataChart getSpider() {
        return DBActions.getSpiderChart();
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "getBars3D")
    public DataChart getBars3D() {
        return DBActions.get3DColumn();
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "getPercArea")
    public DataChart getPercArea() {
        return DBActions.getPercArea();
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "getStock")
    public DataChart getStock() {
        return DBActions.getStock();
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "getDonut")
    public DataChart getDonut() {
        return DBActions.getDonut();
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "getPie")
    public DataChart getPie() {
        return DBActions.getPie();
    }
    
    //****************************************************************
    //****************************************************************
    //****************************************************************
    //****************************************************************
    //-----------------------TOMEU------------------------------------
     /**
     * Web service operation
     */
    @WebMethod(operationName = "login")
    public String login(@WebParam(name = "nombre") String nombre, @WebParam(name = "clave") String clave) {
        return DBActions.getResponseLog(nombre, clave);
    }
    
    @WebMethod(operationName = "getUsuarios")
    public ArrayList<Usuario> getUsuarios() {
        return DBActions.getUsuarios();
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "SetUsuario")
    public int SetUsuario(@WebParam(name = "nombre") String nombre, @WebParam(name = "password") String password, @WebParam(name = "nivel") String nivel) {
        //TODO write your implementation code here:
        return DBActions.setUsuario(nombre, password, nivel);
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "deleteUsuario")
    public int deleteUsuario(@WebParam(name = "nombre") String nombre) {
        //TODO write your implementation code here:
        return DBActions.deleteUsuario(nombre);
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "sendMsg")
    public int sendMsg(@WebParam(name = "nomDest") String nomDest, @WebParam(name = "nomEmisor") String nomEmisor, @WebParam(name = "asunto") String asunto, @WebParam(name = "msg") String msg) {
        //TODO write your implementation code here:
        return DBActions.sendMsg(nomEmisor, nomDest, asunto, msg);
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "getMensajes")
    public ArrayList<Mensaje> getMensajes(@WebParam(name = "nomDest") String nomDest) {
        //TODO write your implementation code here:
        return DBActions.getMensajes(nomDest);
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "delMensaje")
    public int delMensaje(@WebParam(name = "id") String id) {
        //TODO write your implementation code here:
        return DBActions.deleteMsg(id);
    }
    
    

    
}
