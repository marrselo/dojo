<?php
class Application_Model_TipoDocumento  extends Zend_Db_Table {
    
    protected  $_name = "tip_doc";    

    public function getTipoDocumento() {
        $db = $this->getAdapter();
        return $db->fetchPairs($this->select());
        
    }
}