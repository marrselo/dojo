<?php

class Admin_PedidosController
        extends ZExtraLib_Controller_Action
{
       protected $_clienteModel;
       protected $_articuloModel;
       protected $_documentoModel;
       protected $_usuarioModel;

    function init() {
        parent::init();
        $this->_clienteModel = new Application_Model_Cliente();
        $this->_articuloModel = new Application_Model_Articulo();
        $this->_documentoModel = new Application_Model_Documento();
        $this->_detalleDocumentoModel = new Application_Model_DetalleDocumento();
        $this->_usuarioModel = new Application_Model_Usuario();
    }
    function ajaxSearchClientesAction(){
        $this->_helper->layout()->disableLayout();
        $params = $this->_getAllParams();
        $cliente = $this->_clienteModel->listaClientes($params['searchCliente']);
        echo $this->_helper->json($cliente);
    }
    
    function ajaxSearchResponsableAction(){
        $this->_helper->layout()->disableLayout();
        $params = $this->_getAllParams();
        $usuarios = $this->_usuarioModel->listaUsuarios($this->_getParam('buscarResponsable'));
        echo $this->_helper->json($usuarios);
    }
    
    function ajaxGetResponsableAction(){
        $this->_helper->layout()->disableLayout();
        $params = $this->_getAllParams();
        $usuarios = $this->_usuarioModel->listarUnUsuario($this->_getParam('idusuario'));
        echo $this->_helper->json($usuarios);
    }
    function ajaxGetClienteAction(){
        $this->_helper->layout()->disableLayout();
        $params = $this->_getAllParams();
        $cliente = $this->_clienteModel->listarUnCliente($params['idCliente']);
        echo $this->_helper->json($cliente);
    }
    
    function ajaxListarNumeroSerieAction(){
        $this->_helper->layout()->disableLayout();
        $params = $this->_getAllParams();
        
        echo $this->_helper->json(array());
    }
    
    function ajaxDeleteArticuloAction(){
        $this->_helper->layout()->disableLayout();
        $params = $this->_getAllParams();
        unset($this->session->articuloEnLista[array_search($params['idArticulo'],$this->session->articuloEnLista)]); 
        echo $this->_helper->json(array());
    }
    
    function ajaxGetArticuloAction(){
        $this->_helper->layout()->disableLayout();
        $params = $this->_getAllParams();
        $this->session->articuloEnLista[] = $params['idArticulo'];
        echo $this->_helper->json($articulo);
    }
    
    function ajaxSearchArticulosAction(){
        $this->_helper->layout()->disableLayout();
        $params = $this->_getAllParams();
        $notInt = count($this->session->articuloEnLista)>0?implode(',',$this->session->articuloEnLista):'';
        $articulo = $this->_articuloModel->buscarArticulos(isset($params['searchArticulo'])?$params['searchArticulo']:'',
                                                           isset($params['idCategoria'])?$params['idCategoria']:'',$notInt);
        echo $this->_helper->json($articulo);
    }
    
    function indexAction(){
        $this->session->articuloEnLista=array();
        $date = new Zend_Date();
        echo $date->now()->get('YY-mm-dd');
        $form = new Application_Form_FormCliente();
        $form->setAction('/admin/pedidos/nuevo-cliente-ajax');
        $form->setDecorators(array(array('ViewScript',array('viewScript'=>'form/cliente.phtml'))));
        $this->view->formularioCliente = $form;
    }
    
    function nuevoClienteAjaxAction(){
        $this->_helper->layout()->disableLayout();
        $form = new Application_Form_FormCliente();
        $params = $this->_getAllParams();
        if ($this->_request->isPost()) {
            if($form->isValid($params)){
                $data['nombre']=$params['nombre'];
                $data['apellidomaterno']=$params['apellidomaterno'];
                $data['apellidopaterno']=$params['apellidopaterno'];
                $data['direccion']=$params['direccion'];
                $data['dni']=$params['dni'];
                $data['web']=$params['web'];
                $data['correo']=$params['correo'];
                $data['telefono1']=$params['telefono1'];
                $data['telefono2']=$params['telefono2'];
                $data['movil']=$params['movil'];
                $data['ruc']=$params['ruc'];
                $idcliente = $this->_clienteModel->crearCliente($data);
                $data = $this->_clienteModel->listarUnCliente($idcliente);
                $messages = 'Usuario registrado';
                $estado = 1;
            }
            $messages = $form->getMessages();
            $estado = 0;
            $data = array();
        }
        echo $this->_helper->json(array('messages'=> $messages,
                                     'estado' => $estado,
                                     'data' => $data ));
    }
    
    function crearDocumentoAction(){
        $date = new Zend_Date();
        $param = $this->_getAllParams();
        $data ['numeroserie'] = $param['numeroserie'];
        $data ['numerocomprobante']= $param['numerocomprobante'];
        $data ['fechacreacion']= $date->now()->get('YY-mm-dd');
        $data ['fecvencimiento']= $date->set($param['fecvencimiento'])->get('YY-mm-dd');
        $data ['total']= $param['total'];
        $data ['idtipodocumento'] = $param['idtipodocumento'];
        $data ['idcliente'] = $param['idcliente'];
        $data ['idestado'] = $param['idestado'];
        $data ['flagactivo'] = 1;
        $data ['idvendedor']= $param['idvendedor'];
        $data ['IGV']= $param['igv'];
        $data ['comentario']= $param['comentarioPedido'];
        $idDocumento = $this->_documentoModel->crearDocumento($data);
        $arrayProductos = explode($param['idproductos'],',');/*12-23-23,1-23-23,2-23-23,idproducto-cantidad-importe */
        foreach ($arrayProductos as $index){
            $paramDetalle = explode($index,'-');
            $dataDetalle['iddocumento']= $idDocumento;
            $dataDetalle['idarticulo']= $paramDetalle[0];
            $dataDetalle['importe']= $paramDetalle[1];
            $dataDetalle['precio']= $paramDetalle[2];
            $this->crearDetalleDocumento($dataDetalle);
        }
    }
    
    function crearDetalleDocumento($param){
        $data ['iddocumento'] = $param['iddocumento'];
        $data ['cantidad'] = $param['cantidad'];
        $data ['importe'] = ($param['cantidad']*$param['precio']) ;
        $data ['precio'] = $param['precio'];
        $data ['idarticulo'] = $param['idarticulo'];
        $this->_detalleDocumentoModel->crearDetalleDocumento($data);
    }
    
    function listarPedidosAction(){
        
    }
    
    
    
    
   
    
}
