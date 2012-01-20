<?php

class Default_RealizarPedidoController extends ZExtraLib_Controller_Action {

    protected $_modelCategorias;
    protected $_modelArticulos;
    protected $_clienteModel;
    protected $_detalleDocumentoModel;
    protected $_documentoModel;

    public function init() {
        parent::init();
        $this->_clienteModel = new Application_Model_Cliente();
        $this->_modelCategorias = new Application_Model_Categoria();
        $this->_modelArticulos = new Application_Model_Articulo();
        $this->_documentoModel = new Application_Model_Documento();
        $this->_detalleDocumentoModel = new Application_Model_DetalleDocumento();
        $this->view->menuActive3 = 'active';
        $this->view->headTitle('Realizar Pedido');
    }

    public function indexAction() {
        $params = $this->_getAllParams();
        $arrayArticulos = array();
        if (isset($params['producto']) and $params['producto'] != '') {
            $arrayArticulos = $this->_modelArticulos->listarUnArticulo($params['producto']);
            
            $params['cantidad'] = !isset($params['cantidad'])||number_format(abs($params['cantidad']),0) == ''||number_format(abs($params['cantidad']),0) == 0 ? 1 : number_format(abs($params['cantidad']),0);
            if ($arrayArticulos) {
                if (isset($this->session->listaArticulo[$arrayArticulos['idarticulo']])) {
                    $arrayArticulos['cantidadArticulo'] = $params['cantidad'] + $this->session->listaArticulo[$arrayArticulos['idarticulo']]['cantidadArticulo'];
                } else {
                    $arrayArticulos['cantidadArticulo'] = $params['cantidad'];
                }
                $this->session->listaArticulo[$arrayArticulos['idarticulo']] = $arrayArticulos;
            }
        }
        $this->view->listaArticuloCarrito = $this->session->listaArticulo;
        //print_r($this->view->listaArticuloCarrito);
    }

    public function eliminarCarritoAction() {
        $params = $this->_getAllParams();
        unset($this->session->listaArticulo[$params['idArticulo']]);
        $this->_redirect($_SERVER['HTTP_REFERER']);
    }

    public function addCantAction() {
        $params = $this->_getAllParams();
        $cantidadArticulo = $this->session->listaArticulo[$params['idArticulo']]['cantidadArticulo'];
        $this->session->listaArticulo[$params['idArticulo']]['cantidadArticulo'] = $cantidadArticulo + 1;
        $this->_redirect($_SERVER['HTTP_REFERER']);
    }

    public function restarCantAction() {
        $params = $this->_getAllParams();
        $cantidadArticulo = $this->session->listaArticulo[$params['idArticulo']]['cantidadArticulo'];
        if ($cantidadArticulo == 1) {
            unset($this->session->listaArticulo[$params['idArticulo']]);
        } else {
            $this->session->listaArticulo[$params['idArticulo']]['cantidadArticulo'] = $cantidadArticulo - 1;
        }
        $this->_redirect($_SERVER['HTTP_REFERER']);
    }

    public function registrarPedidoAction() {
        if (!isset($this->session->listaArticulo)) {
            $this->_redirect($_SERVER['HTTP_REFERER']);
        }
        $this->view->headLink()->appendStylesheet("/f/css/contacto-form.css");
        $this->view->headLink()->appendStylesheet("/f/css/jquery-ui-1.8.17.custom.css");
        $this->view->headScript()->appendFile('/f/js/jquery-ui-1.8.17.custom.min.js');
        $this->view->headScript()->appendScript('
            $(function() {
            
            $( "#fechaEntrega" ).datepicker( $.datepicker.regional["es"] );            
            
            });
            ');
        $params = $this->_request->getParams();
        $form = $this->formularioCliente();
        $form->getAction('');
        if ($this->_request->isPost()) {
            if ($form->isValid($params)) {
                
            } else {
                
            }
        }

        $this->view->formRegistroCliente = $form;
    }

    function formatocorreoAction() {
        $this->view->listaArticulo = $this->session->listaArticulo;
    }
    
    function formularioCliente() {
        $form = new Application_Form_FormCliente();
        $form->getElement('dni')->removeValidator('ZExtraLib_Validate_DniExist');

        $arrayTipoDocumento = array(1 => 'Boleta', 2 => 'Factura');
        $form->addElement(new Zend_Form_Element_Radio('tipoDocumento',
                        array('requerid' => true,
                            'label' => 'Tipo Documento',
                            'multiOptions' => $arrayTipoDocumento
                )));
        $tiposPago = array(1 => 'Efectivo', 2 => 'Tarjeta');
        $form->addElement(new Zend_Form_Element_Radio('tipoPago', array('requerid' => true, 'label' => 'Tipo de Pago', 'multiOptions' => $tiposPago)));

        $form->addElement(new Zend_Form_Element_Text('fechaEntrega',
                        array('label' => 'Fecha Entrega')));

        foreach (range(0, 23) as $index):
            $value = strlen($index) == 1 ? '0' . $index : $index;
            $arrayHora[$value] = $value;
        endforeach;

        $form->addElement(new Zend_Form_Element_Select('hora',
                        array('requerid' => true,
                            'label' => 'Hora',
                            'multiOptions' => $arrayHora
                )));
        $arrayMinuto = array();
        $arrayMinuto['00'] = '00';
        $arrayMinuto['15'] = '15';
        $arrayMinuto['30'] = '30';
        $arrayMinuto['45'] = '45';
        $form->addElement(new Zend_Form_Element_Select('minuto',
                        array('requerid' => true,
                            'multiOptions' => $arrayMinuto
                )));

        $form->getElement('tipoPago')->setSeparator('');
        $form->getElement('tipoDocumento')->setSeparator('');
        $form->setDecorators(array(array('ViewScript', array('viewScript' => 'form/registrocliente.phtml'))));
        return $form;
    }

    function crearDetalleDocumento($param) {
        $data ['iddocumento'] = $param['iddocumento'];
        $data ['cantidad'] = $param['cantidad'];
        $data ['importe'] = ($param['cantidad'] * $param['precio']);
        $data ['precio'] = $param['precio'];
        $data ['idarticulo'] = $param['idarticulo'];
        $this->_detalleDocumentoModel->crearDetalleDocumento($data);
    }

    function registrarCLiente($params) {
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
        return $idcliente;
    }

    function generarComprobante($param) {
        $date = new Zend_Date();
        $data ['numeroserie'] = $param['numSerie'];
        $data ['numerocomprobante'] = $param['numComprobante'];
        $data ['fechacreacion'] = $date->now()->get('YYYY-mm-dd');
        $data ['idtipodocumento'] = $param['tipoDocumento'];
        $data ['direccion'] = $param['direccion'];
        $data ['idcliente'] = $param['idcliente'];
        $data ['idestado'] = 1;
        $data ['flagactivo'] = 1;
        $data ['IGV'] = 18.00; //$param['igv'];
        $data ['comentario'] = $param['informacionAdicional'];
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
        $data2['total'] = $total;
        $this->_documentoModel->actualizarDocumento($data2, $idDocumento);
    }
}

