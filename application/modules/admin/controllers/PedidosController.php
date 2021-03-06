<?php

class Admin_PedidosController extends ZExtraLib_Controller_Action {

    protected $_clienteModel;
    protected $_articuloModel;
    protected $_documentoModel;
    protected $_usuarioModel;
    protected $_detalleDocumentoModel; 

    function init() {
        parent::init();
        $this->_clienteModel = new Application_Model_Cliente();
        $this->_articuloModel = new Application_Model_Articulo();
        $this->_documentoModel = new Application_Model_Documento();
        $this->_detalleDocumentoModel = new Application_Model_DetalleDocumento();
        $this->_usuarioModel = new Application_Model_Usuario();
        $this->view->menuTop = $menuTop = array('Nuevo Pedido' => $this->view->baseUrl().'/admin/pedidos/index','Lista Pedidos' => $this->view->baseUrl().'/admin/pedidos/lista-pedidos');
        $this->view->headLink()->appendStylesheet("/f/css/jquery-ui-1.8.17.custom.css");
        $this->view->headLink()->appendStylesheet("/f/css/cheloform.css");
        $this->view->headScript()->appendFile('/f/js/jquery-ui-1.8.17.custom.min.js');
    }
    function ajaxSearchClientesAction() {
        $this->_helper->layout()->disableLayout();
        $params = $this->_getAllParams();
        $cliente = $this->_clienteModel->listaClientes($params['searchCliente']);
        echo $this->_helper->json($cliente);
    }

    function ajaxSearchResponsableAction() {
        $this->_helper->layout()->disableLayout();
        $params = $this->_getAllParams();
        $usuarios = $this->_usuarioModel->listaUsuarios($this->_getParam('buscarResponsable'));
        echo $this->_helper->json($usuarios);
    }

    function ajaxGetResponsableAction() {
        $this->_helper->layout()->disableLayout();
        $params = $this->_getAllParams();
        $usuarios = $this->_usuarioModel->listarUnUsuario($this->_getParam('idusuario'));
        echo $this->_helper->json($usuarios);
    }

    function ajaxGetClienteAction() {
        $this->_helper->layout()->disableLayout();
        $params = $this->_getAllParams();
        $cliente = $this->_clienteModel->listarUnCliente($params['idCliente']);
        echo $this->_helper->json($cliente);
    }

    function ajaxListarNumeroSerieAction() {
        $this->_helper->layout()->disableLayout();
        $params = $this->_getAllParams();
        $comprobante = new Application_Model_Comprobante();
        echo $this->_helper->json($comprobante->listarNumSerieComprobantes($params['idTipoComprobante']));
    }

    function ajaxDeleteArticuloAction() {
        $this->_helper->layout()->disableLayout();
        $params = $this->_getAllParams();
        unset($this->session->articuloEnLista[array_search($params['idArticulo'], $this->session->articuloEnLista)]);
        echo $this->_helper->json(array());
    }

    function ajaxGetArticuloAction() {
        $this->_helper->layout()->disableLayout();
        $params = $this->_getAllParams();
        $this->session->articuloEnLista[] = $params['idArticulo'];
        echo $this->_helper->json($articulo);
    }

    function ajaxSearchArticulosAction() {
        $this->_helper->layout()->disableLayout();
        $params = $this->_getAllParams();
        $notInt = count($this->session->articuloEnLista) > 0 ? implode(',', $this->session->articuloEnLista) : '';
        $articulo = $this->_articuloModel->buscarArticulos(isset($params['searchArticulo']) ? $params['searchArticulo'] : '', isset($params['idCategoria']) ? $params['idCategoria'] : '', $notInt);
        echo $this->_helper->json($articulo);
    }

    function indexAction() {
        $this->session->articuloEnLista = array();
        $date = new Zend_Date();
        $form = new Application_Form_FormCliente();
        $form->setAction('/admin/pedidos/nuevo-cliente-ajax');
        $form->addAttribs(array('id'=>'form_cliente'));
        $form->removeElement('Enviar');        
        $this->view->formularioCliente = $form;
        
        $formComprobantes = $this->getFormGenerarComprobante();
        foreach ($formComprobantes as $elem){            
            $elem->removeDecorator('label')->removeDecorator('HtmlTag');
        }        
        if ($this->_request->isPost()) {
            $params = $this->_getAllParams();
            $comprobante = new Application_Model_Comprobante();
            $serieComprobante = $comprobante->listarNumSerieComprobantes($params['tipoDocumento']);
            foreach ($serieComprobante as $index) {
                $arraySerie[$index['serie']] = $index['serie'];
            }
            $formComprobantes->getElement('numSerie')->setMultiOptions($arraySerie);
            if ($formComprobantes->isValid($params)) {
                $this->generarComprobante($params);
                $this->_redirect('admin/pedidos/lista-pedidos');
            }
        }

        //$formComprobantes->setAction('/admin/pedidos/generar-comprobante');
        $formComprobantes->getElement('fechaEntrega')
                ->setValue($date->now()->getDate()->get('YYYY-mm-dd'));
        $this->view->formGenerarComprobantes = $formComprobantes;
    }

    function ajaxGenerarNumComprobanteAction() {
        $this->_helper->layout()->disableLayout();
        $params = $this->_getAllParams();
        $idTipoDocumento = $params['tipoDocumento'];
        $numSerie = $params['numSerie'];
        $modelComprobante = new Application_Model_Comprobante();
        $arrayResult = $modelComprobante->listarComprobantes($idTipoDocumento, $numSerie);
        echo $this->_helper->json($arrayResult);
    }

    function generarComprobante($param) {
        $date = new Zend_Date();
        $data ['numeroserie']       = $param['numSerie'];
        $data ['numerocomprobante'] = $param['numComprobante'];
        $data ['fechacreacion']     = $date->now()->get('YYYY-mm-dd');
        $data ['idtipodocumento']   = $param['tipoDocumento'];
        $data ['direccion']         = $param['direccion'];
        $data ['idcliente']         = $param['idcliente'];
        $data ['idestado']          = 1;
        $data ['flagactivo']        =  1;
        $data ['flagdespacho']      = 0;
        $data ['idvendedor']        = $this->_identity->idusuario;
        $data ['IGV']               = 18.00; //$param['igv'];
        $data ['comentario']        = $param['informacionAdicional'];
        $data ['hora']              = $param['hora'].':'.$param['minuto'].':00';
        $idDocumento = $this->_documentoModel->crearDocumento($data);
        $arrayProductos = $param['idarticulo'];
        $total = 0;
        foreach ($arrayProductos as $index => $value) {
            $dataDetalle['iddocumento'] = $idDocumento;
            $dataDetalle['idarticulo'] = $value;
            $dataDetalle['precio'] = $param['precio'][$index];
            $dataDetalle['cantidad'] = $param['cantidad'][$index];
            $total = $total + ($dataDetalle['precio'] * $dataDetalle['cantidad']);
            $this->crearDetalleDocumento($dataDetalle);
        }
        $data2 = array();
        $data2['total']=$total;
        $this->_documentoModel->actualizarDocumento($data2,$idDocumento);
    }

    function getFormGenerarComprobante() {
        $form = new Application_Form_FormGeneraComrpobante();
        $form->setDecorators(array(array('ViewScript', array('viewScript' => 'form/generacomrpobante.phtml'))));
        return $form;
    }
    function getFormEditarComprobante() {
        $form = new Application_Form_FormGeneraComrpobante();
        $form->setDecorators(array(array('ViewScript', array('viewScript' => 'form/editarcomprobante.phtml'))));
        return $form;
    }
    function visualizarComprobanteAction(){
        
        
    }
    

    function nuevoClienteAjaxAction() {
        $this->_helper->layout()->disableLayout();
        $form = new Application_Form_FormCliente();
        $params = $this->_getAllParams();
        if ($this->_request->isPost()) {
            if ($form->isValid($params)) {
                $data['nombre'] = $params['nombre'];
                $data['apellidomaterno'] = $params['apellidomaterno'];
                $data['apellidopaterno'] = $params['apellidopaterno'];
                $data['direccion'] = $params['direccion'];
                $data['dni'] = $params['dni'];
                $data['web'] = $params['web'];
                $data['correo'] = $params['correo'];
                $data['telefono1'] = $params['telefono1'];
                $data['telefono2'] = $params['telefono2'];
                $data['movil'] = $params['movil'];
                $data['ruc'] = $params['ruc'];
                $idcliente = $this->_clienteModel->crearCliente($data);
                $data = $this->_clienteModel->listarUnCliente($idcliente);
                $messages = 'Usuario registrado';
                $estado = 1;                
            }else{
                $estado = 0;
                $data = array();
            }
            $messages = $form->getMessages();
            
        }
        echo $this->_helper->json(array('messages' => $messages,
            'estado' => $estado,
            'data2' => $data));
    }

    function crearDetalleDocumento($param) {
        $data ['iddocumento'] = $param['iddocumento'];
        $data ['cantidad'] = $param['cantidad'];
        $data ['importe'] = ($param['cantidad'] * $param['precio']);
        $data ['precio'] = $param['precio'];
        $data ['idarticulo'] = $param['idarticulo'];
        $this->_detalleDocumentoModel->crearDetalleDocumento($data);
    }
    function actualizarDetalleDocumento($param) {
        $data ['iddocumento'] = $param['iddocumento'];
        $data ['cantidad'] = $param['cantidad'];
        $data ['importe'] = ($param['cantidad'] * $param['precio']);
        $data ['precio'] = $param['precio'];
        $data ['idarticulo'] = $param['idarticulo'];
        //$this->_detalleDocumentoModel->crearDetalleDocumento($data);
    }
    

    function listaPedidosAction() 
    {
        $params = $this->_getAllParams();
        if($params['controller']=='pedidos'){
            $this->view->menuTop = $menuTop = array('Nuevo Pedido' => $this->view->baseUrl().'/admin/pedidos','Lista Pedidos' => $this->view->baseUrl().'/admin/pedidos/lista-pedidos');
        }else{
            $this->view->menuTop = $menuTop = array('Lista Productos' => $this->view->baseUrl().'/admin/articulo', 'Nuevo Articulo' => '../articulo/nuevo-articulo', 'Lista Pedidos' => $this->view->baseUrl().'/admin/pedidos/lista-pedidos');        
        }        
       $this->view->listaPedidos = $this->_documentoModel->listarDocumentos();
       
        
    }
    function ingresarSerieAction()
    {
        $params= $this->_getAllParams();
        $this->view->dataDocumento = $dataDocumento = $this->_documentoModel->datosDocumento($params['idDocumento']);
        //print_r($dataDocumento);
    }
    
    
    function borrarPedidosAction()
    {
        //$this->_helper->layout()->disableLayout();
        //$this->_helper->viewRenderer->setNoRender(true);
        $params = $this->_getAllParams();
        $idDocumento = $params['idDocumento'];
        $this->_documentoModel->borrarDocumento($idDocumento);
        $this->_redirect('admin/pedidos/lista-pedidos');
    }
    
    function despacharPedidosAction()
    {
        $this->_helper->layout()->disableLayout();
        $params= $this->_getAllParams();
        if($params['numero']==0){
            $this->_redirect('admin/pedidos/ingresar-serie?idDocumento='.$params['idDocumento']);
        }else{
        
            $detalle = $this->_detalleDocumentoModel;        
            $arrDetalle = $detalle->getDetalleDocumento($params['idDocumento']);
            $kardex = new Application_Model_Kardex();
            $data = array();
            foreach($arrDetalle as $key => $valor){
	         $data['stock']      = $valor['cantidad'];
	         $data['idarticulo'] = $valor['idarticulo'];
	         $data['fla']        = 2;
	         $data['iddoc']      = $idDocumento;
	         $data['motivo']     = 'Despacho ';
	         $kardex->crearKardex($data);
            }
            $dataDoc = array('flagdespacho'=>1);
            if($params['numero']!=''){
                $dataDoc['numerocomprobante'] = $params['numero'];
                $dataDoc['numeroserie']  	      = $params['serie'];
            }        
            $this->_documentoModel->actualizarDocumento($dataDoc,$params['idDocumento']);
            $this->_redirect('admin/pedidos/lista-pedidos');        
        }                   
    }
    
    function imprimirAction()
    {
        $this->_helper->layout()->disableLayout();
        $params = $this->_getAllParams();
        $idDocumento = $params['idDocumento'];
        $this->view->datosDocumento = $this->_documentoModel->datosDocumento($params['idDocumento']);
       
        
    }
    
    function editarPedidosAction()
    {
        $params= $this->_getAllParams();
        $this->view->datosDocumento = $this->_documentoModel->datosDocumento($params['idDocumento']);       
          /*************************/
        $this->session->articuloEnLista = array();
        $date = new Zend_Date();
        
        $formComprobantes = $this->getFormEditarComprobante();
        foreach ($formComprobantes as $elem){            
            $elem->removeDecorator('label')->removeDecorator('HtmlTag');
        }
        $tipoDocumento              = new Application_Model_TipoDocumento();
        $getTipoDocumento           = $tipoDocumento->detalleTipoDocumento($this->view->datosDocumento[0]['idtipodocumento']);
        $this->view->tipoDocumento  = $getTipoDocumento['des'];
        $this->view->numeroSerie    = $this->view->datosDocumento[0]['numeroserie'];
        $this->view->numeroDocumento= $this->view->datosDocumento[0]['numerocomprobante'];
        
//        if ($this->_request->isPost()) {
//            $params = $this->_getAllParams();
//            $comprobante = new Application_Model_Comprobante();
//            $serieComprobante = $comprobante->listarNumSerieComprobantes($params['tipoDocumento']);
//            foreach ($serieComprobante as $index) {
//                $arraySerie[$index['serie']] = $index['serie'];
//            }
//            $formComprobantes->getElement('numSerie')->setMultiOptions($arraySerie);
//            if ($formComprobantes->isValid($params)) {
//                $this->generarComprobante($params);
//                $this->_redirect('admin/pedidos/lista-pedidos');
//            }
//        }

        //$formComprobantes->setAction('/admin/pedidos/generar-comprobante');
        $formComprobantes->getElement('fechaEntrega')
                         ->setValue($this->view->datosDocumento[0]['fechacreacion']);
        $formComprobantes->getElement('direccion')
                         ->setValue($this->view->datosDocumento[0]['direccion']);
        $formComprobantes->getElement('fechaEntrega')
                          ->setValue($this->view->datosDocumento[0]['fechacreacion']);
        $formComprobantes->getElement('hora')
                          ->addMultioption('',substr($this->view->datosDocumento[0]['hora'],0,-6));
        $formComprobantes->getElement('minuto')
                          ->addMultioption('',substr($this->view->datosDocumento[0]['hora'],0,-6));
        //$formComprobantes->getElement('fechaEntrega')
        $this->view->formEditarComprobantes = $formComprobantes;
    }

}
