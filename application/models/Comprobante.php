<?php
class Application_Model_Comprobante  extends Zend_Db_Table {
    
    protected  $_name = "numeroserie";    
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
    function existeTipo($tipo,$serie){
        $num = $this->fetchRow(
                $this->select()->where('idtip_doc = ? ',$tipo)
                ->where('serie = ? ',$serie));
        return $num;
    }
    function existeComprobante($tipo, $serie, $des){
        $num = $this->fetchRow(
                $this->select()->where('idtip_doc = ? ',$tipo)
                ->where('serie = ? ',$serie)
                ->where('num = ?', $des)
                );
        return $num;        
    }
    function maxComprobante($tipo, $serie){
        $result=$this->fetchRow($this->select()
                ->from($this, array(new Zend_Db_Expr('max(num) as max')))
                ->where('idtip_doc = ? ',$tipo)
                ->where('serie = ? ',$serie)
                );
        $max=$result['max'];
        
        return $max;

        
        
    }    


}