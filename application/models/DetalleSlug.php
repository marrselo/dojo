<?php
class Application_Model_DetalleSlug  extends Zend_Db_Table {
    protected  $_name = "detalleslug";    
    
    function registrarDetalleSlug($idSlug,$idArticulo){
        $data=array('idarticulo' => $idArticulo,
                    'idslug' => $idSlug);
        $this->insert($data);
    }
    function buscarDeralleSlug($idSlug,$idArticulo){
           return $this->select()
                ->where('idarticulo = ?',array($idArticulo))
                ->where('idslug = ?',array($idSlug))
                ->query()
                ->fetch();
    }
    function eliminarDetalleSlugPorArticulo($idArticulo){
        $where = $this->getAdapter()->quoteInto('idarticulo = ?', $idArticulo);
        $this->delete($where);
    }

}
