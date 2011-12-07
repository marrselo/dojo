<?php
class Application_Model_Comprobante  extends Zend_Db_Table {
    
    protected  $_name = "numserie";    
    function listarComprobante(){
        $db = $this->getAdapter();
        $resul = $db->select()
            ->from($this->_name)
            ->join(
                'tipo_doc',
                'numserie.idtip_doc=.idtip_doc',
                array())           
            ->query();
        return $resul;

        
}

}