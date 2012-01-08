<?php

class Default_RealizarPedidoController extends ZExtraLib_Controller_Action {

    protected $_modelCategorias;
    protected $_modelArticulos;

    public function init() {
        parent::init();
        $this->_modelCategorias = new Application_Model_Categoria();
        $this->_modelArticulos = new Application_Model_Articulo();
        $this->view->menuActive3 = 'active';
    }

    public function indexAction() {
        $params = $this->_getAllParams();
        $arrayArticulos = array();
        if (isset($params['producto']) and $params['producto'] != '') {
            $arrayArticulos = $this->_modelArticulos->listarUnArticulo($params['producto']);
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
        $this->view->headLink()->appendStylesheet("/f/css/contacto-form.css");
        $params = $this->_request->getParams();
        $form = $this->formularioCliente();
        $form->getAction('');
        if ($this->_request->isPost()) {
            if ($form->isValid($params)) {
                echo '<div>asdassadasd <a href="#">asd</a></div>';
            }else{
                
            }
        }
        
        $this->view->formRegistroCliente = $form;
    }
    function formatocorreoAction(){
       $this->view->listaArticulo=$this->session->listaArticulo;
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
        $form->setDecorators(array(array('ViewScript', array('viewScript' => 'form/registrocliente.phtml'))));

        return $form;
    }

}

