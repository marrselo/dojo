<?php

class Application_Model_Documento extends Zend_Db_Table {

    protected $_name = "documentopago";

    function crearDocumento($data) {

        $this->insert($data);

        return $this->getAdapter()->lastInsertId();
    }

    function obtenerComprobante($idComprobante) {

        return $this->getAdapter()
                        ->select()
                        ->from('documentopago')
                        ->where('iddocumento', $idComprobante)
                        ->query()
                        ->fetch();
    }

    function listarDocumentos() {

        return $this->getAdapter()
                        ->select()
                        ->from(array('D' => 'documentopago'))
                        ->join('cliente', 'cliente.idcliente=D.idcliente', array('nombre', 'apellidomaterno', 'apellidopaterno'))
                        ->join('estado', 'estado.idestado=D.idestado', array('nombreEstado' => 'des'))
                        ->where('D.flagdespacho=0')
                        ->order('iddocumento DESC')
                        ->query()
                        ->fetchAll();
    }

    function listarComprobantes() {

        return $this->getAdapter()
                        ->select()
                        ->from(array('D' => 'documentopago'))
                        ->join('cliente', 'cliente.idcliente=D.idcliente', array('nombre', 'apellidomaterno', 'apellidopaterno'))
                        ->join('estado', 'estado.idestado=D.idestado', array('nombreEstado' => 'des'))
                        ->join('tip_doc', 'tip_doc.idtip_doc=D.idtipodocumento', array('tipodocumento' => 'des'))
                        ->where('D.flagdespacho=1')
                        ->query()
                        ->fetchAll();
    }

    function actualizarDocumento($data, $idDocumento) {

        $where = $this->getAdapter()->quoteInto('iddocumento = ?', $idDocumento);

        $this->update($data, $where);
    }

    function borrarDocumento($idDocumento) {

        $where = $this->getAdapter()->quoteInto('iddocumento = ?', $idDocumento);

        $this->delete($where);
    }

    function datosDocumento($idDocumento) {


        return $this->getAdapter()
                        ->select()
                        ->from('documentopago')
                        ->join('cliente', 'cliente.idcliente=documentopago.idcliente', array('nombre', 'apellidomaterno', 'apellidopaterno', 'ruc'))
                        ->join('estado', 'estado.idestado=documentopago.idestado', array('nombreEstado' => 'des'))
                        ->join('detalledocumentopago', 'detalledocumentopago.iddocumento=documentopago.iddocumento')
                        ->join('articulo', 'articulo.idarticulo=detalledocumentopago.idarticulo', array('nombreArticulo' => 'nombre'))
                        ->join('tip_doc', 'tip_doc.idtip_doc=documentopago.idtipodocumento', array('tipodocumento' => 'des'))
                        ->where('documentopago.iddocumento = ?', array($idDocumento))
                        ->query()
                        ->fetchAll();
    }

}

