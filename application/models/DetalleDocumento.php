<?php
class Application_Model_DetalleDocumento  extends Zend_Db_Table {
    protected  $_name = "detalledocumentopago";
    function DetalleDocumento($data){
        $this->insert($data);
        return $this->getAdapter()->lastInsertId();
    }
    
}

    