<?php
class Application_Model_Categoria  extends Zend_Db_Table {
    protected  $_name = "categoria";
    
    public function listaCategorias() {
        $estado = 1;
        return $this->getAdapter()
                ->select()
                ->from('categoria')
                ->where('estado = ?', $estado)
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
}

?>