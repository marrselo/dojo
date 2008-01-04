<?php
class Application_Model_Kardex  extends Zend_Db_Table {
    protected  $_name = "kardex";
    
    public function listaKardex($idarticulo= null) {
      
        $fla = 1;
        return $this->getAdapter()
                ->select()
                ->from('kardex')
                ->where('idarticulo = ?', $idarticulo)
                ->query()->fetchAll();
        
    }
    
    public function crearKardex($data)
    {
        $this->insert($data);
    }
}