/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WSBeans;

import java.io.Serializable;

/**
 *
 * @author van
 */
public class Usuario implements Serializable{
    private String nombre;
    private String nivel;

    public Usuario() {
        this.nombre = "";
        this.nivel = "";
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getNivel() {
        return nivel;
    }

    public void setNivel(String nivel) {
        this.nivel = nivel;
    }
    
    
    
    
    
}
