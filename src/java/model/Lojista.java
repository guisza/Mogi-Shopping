package model;

public class Lojista {
    private int id;
    private String nmloja;
    private String email;
    private String senha;
    private String contato;

    /**
     * @return the id
     */
    public int getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * @return the nmloja
     */
    public String getNmloja() {
        return nmloja;
    }

    /**
     * @param nmloja the nmloja to set
     */
    public void setNmloja(String nmloja) {
        this.nmloja = nmloja;
    }

    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * @return the senha
     */
    public String getSenha() {
        return senha;
    }

    /**
     * @param senha the senha to set
     */
    public void setSenha(String senha) {
        this.senha = senha;
    }

    /**
     * @return the celular
     */
    public String getContato() {
        return contato;
    }

    /**
     * @param celular the celular to set
     */
    public void setContato(String celular) {
        this.contato = contato;
    }
    
}
