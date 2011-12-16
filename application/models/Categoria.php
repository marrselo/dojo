<?php
class Application_Model_Categoria  extends Zend_Db_Table {
    protected  $_name = "categoria";
    
    public function listaCategorias() {
        
        return $this->getAdapter()
                ->select()
                ->from('categoria')
                ->where('idpadre is null')
                ->order('estado desc')
                ->query()->fetchAll();
    }
    public function crearCategoria($data){
        $this->insert($data);
    }
    public function eliminarCategorias($idCategoria){
        $where = $this->getAdapter()->quoteInto('idcategoria = ?', $idCategoria);
        $data = array('estado'=>'0');
        $this->update($data, $where);
    }
    public function  actualizarCategoria($idCategoria,$data){
        $where = $this->getAdapter()->quoteInto('idcategoria = ?', $idCategoria);
        $this->update($data, $where);
    }
    public function listarUnaCategoria($idCategoria) {
        return  $this->getAdapter()
                ->select()->from('categoria')
                ->where('idcategoria = ?', $idCategoria)
                ->query()
                ->fetch();
    }
    
    public function getCategoria(){
        $db = $this->getAdapter();
        return $db->fetchPairs($this->select()->from('categoria',array(
            'idcategoria','descripcion','codigo','nombre','estado','idpadre'))
                ->where('idpadre is null')
                ->where('estado = 1'));
    }    

    public function getSubcategoria(){
        $db = $this->getAdapter();        
        return $db->fetchAll($this->select()->where('idpadre is not null')->where('estado = 1'));
    }
    
    public function getPadre(){
        $db = $this->getAdapter();        
        return $db->fetchAll($this->select()->where('idpadre is null')->where('estado = 1'));
    }    
    
    public function getPadreaa($idpadre){
        $db = $this->getAdapter();        
        return $db->fetchAll($this->select()->where('idcategoria = ?', $idpadre));
    }    
    
    
    
}

?>