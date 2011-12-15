<?php
class Application_Model_Comprobante  extends Zend_Db_Table {
    
    protected  $_name = "numeroserie";    
    function listarComprobante(){
        $db = $this->getAdapter();
        $resul = $db->select()
            ->from(array('N' => 'numeroserie' ), array(
                'N.idnumeroserie', 'tipo' => 'N.idtip_doc', 'N.serie', 'max' => 'max(num)' ,
                'min' => 'min(num)'))
            ->join(array('T' => 'tip_doc'), 'N.idtip_doc = T.idtip_doc' )
            ->group('idtip_doc')
            ->group('serie')
                ->query()->fetchAll();
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
    function listarNumSerieComprobantes($idTipoComprobante){
        return $this->getAdapter()
                ->select()
                ->from('numeroserie')
                ->where('idtip_doc = ?',
                        array($idTipoComprobante))
               // ->where('flag = ?',array(1))
                ->query()
                ->fetchAll();
               ;
    }
    function listarComprobantes($idTipoDocumento,$numSerie){
        return $this->getAdapter()
                ->select()
                ->from('documentopago')
                ->where('idtipodocumento = ?',array($idTipoDocumento))
                ->where('numeroserie = ?',array($numSerie))
                ->limit(1,1)
                ->order('iddocumento')
                ->query()
                ->fetch();
                
    }
    function listarCabezeraComrpobante($idComprobante){
        return $this->getAdapter()
                ->select()
                ->from(array('dp' => 'documentoPago'),array())
                ->join(array('td' => 'tipo_doc'), 'td.idtip_doc = dp.idtipodocumento','')
                ->join(array('cl' => 'cliente'), 'cl.idcliente = cl.idcliente','');
        
    }
    function ListarDetalleComprobante($idComprobante){
        
    }


}