<?php
class Application_Model_DetalleDocumento  extends Zend_Db_Table {
    protected  $_name = "detalledocumentopago";
    function crearDetalleDocumento($data){
        $this->insert($data);
        return $this->getAdapter()->lastInsertId();
    }
    function obtenerDetalleDocumeto($idComprobante){
        return $this->getAdapter()->select()
                ->from('detalledocumentopago')
                ->join('articulo', 'articulo.idarticulo = detalledocumentopago.idarticulo','')
                ->where('detalledocumentopago.iddocumento = ?',$idComprobante)
                ->query()
                ->fetchAll();
    }
    
}

    