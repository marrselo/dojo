<?php
class Application_Model_Documento  extends Zend_Db_Table {
    protected  $_name = "documentopago";
    function crearDocumento($data){
        $this->insert($data);
        return $this->getAdapter()->lastInsertId();
    }
    
}

    