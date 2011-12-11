<?php
class Application_Model_Slug  extends Zend_Db_Table {
    protected  $_name = "slug";    
    
    function registrarSlug($nombreSlug){
        $data=array('nombreslug' => $nombreSlug);
        $this->insert($data);
        return $this->getAdapter()->lastInsertId();
    }
    function buscarSlugPorNombre($nombreSlug){
        return $this->select()
                ->where('nombreslug = ?',array($nombreSlug))
                ->query()
                ->fetch();
    }
}
