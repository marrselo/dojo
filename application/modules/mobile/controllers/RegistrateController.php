<?php

class Mobile_RegistrateController extends ZExtraLib_Controller_Action {

    protected $_clienteModel;

    public function init() {
        parent::init();
		if ($this->_identity || $this->_identity->idtipousuario == 2) {
            $this->_redirect('/mis-datos');
        }
        $this->_clienteModel = new Application_Model_Cliente();
    }

    public function indexAction() {
        $this->view->headLink()->appendStylesheet("/f/css/contacto-form.css");
        $this->view->headTitle('Registrate');
        $this->view->menuActive4 = 'active';
        $form = $this->formularioCliente();
        $params = $this->_request->getParams();

        if ($this->_request->isPost()) {
            $form->getElement('password')->addValidator(new Zend_Validate_Identical($params['confirmPassword']));
            if ($form->isValid($params)) {
                $params['idcliente'] = $this->registrarCLiente($params);
                $this->_redirect('/registrate/confirmacion-registro');
            } else {
                $this->_flashMessenger->addMessage('No se pudo realizar la Operacion');
                $this->view->formRegistroCliente = $form;
            }
        } else {
            $this->view->formRegistroCliente = $form;
        }
        $this->view->messages = $this->_flashMessenger->getMessages();
    }

    public function confirmacionRegistroAction() {
        
    }
    public function errorAction() {
        $this->view->errorRegistro = $this->_flashMessenger->getMessages();
    }

    public function confirmarRegistroUsuarioAction() {
        $this->view->headLink()->appendStylesheet("/f/css/contacto-form.css");
        $modelCliente = new Application_Model_Cliente();
        $params = $this->_getAllParams();
        $form = $this->formularioCliente();
        $dataClient = $modelCliente->consultarItemUsuario($params['id']);
        if (!$dataClient) {
            $this->_flashMessenger->addMessage('Hubo un error, comuniquese con <a href="mailto:admin@deliverypremiumsac.com">admin@deliverypremiumsac.com</a>');
            //$this->_redirect('/registrate/error');
        }
        $this->session->idCliente = $dataClient['idcliente'];
        $form->addElement(new Zend_Form_Element_Hidden('idcliente'));
        $form->getElement('idcliente')->setValue($dataClient['idcliente']);
        $params = $this->_request->getParams();
        $form = $this->llenarFormulario($form, $dataClient);
        
        if ($this->_request->isPost()) {
            if ($form->isValid($params)) {
                $data['nombre'] = $params['nombre'];
                $data['apellidomaterno'] = $params['apellidomaterno'];
                $data['apellidopaterno'] = $params['apellidopaterno'];
                $data['direccion'] = $params['direccion'];
                $data['idconfirm'] = '';
                $data['dni'] = $params['dni'];
                $data['password'] = $params['password'];
                $data['correo'] = $params['correo'];
                $data['telefono1'] = $params['telefono1'];
                $modelCliente->actualizarCliente($dataClient['idcliente'], $data);
                $this->_flashMessenger->addMessage('Sus datos se registrados correctamente');
                $this->_redirect('/registrate/confirmacion-registro');
            }
        }
        $this->view->formRegistroCliente = $form;
    }

    public function llenarFormulario($form, $data) {
        $form->getElement('nombre')->setValue($data['nombre']);
        $form->getElement('apellidopaterno')->setValue($data['apellidopaterno']);
        $form->getElement('apellidomaterno')->setValue($data['apellidomaterno']);
        $form->getElement('dni')->setValue($data['dni']);
        $form->getElement('correo')->setValue($data['correo']);
        $form->getElement('password')->setValue($data['password']);
        $form->getElement('direccion')->setValue($data['direccion']);
        $form->getElement('telefono1')->setValue($data['telefono1']);
        return $form;
    }

    public function formularioCliente() {
        $date = new Zend_Date();
        $form = new Application_Form_FormCliente();
        $form->addElement(new Zend_Form_Element_Password('password', array('label' => 'Password')));
        $form->addElement(new Zend_Form_Element_Password('confirmPassword', array('label' => 'Confirmar Password')));
        $form->getElement('password')->setRequired();
        $form->getElement('confirmPassword')->setRequired();
        $form->setDecorators(
                array(
                    array('ViewScript',
                        array('viewScript' => 'form/registrocliente2.phtml'))));
        return $form;
    }

    function registrarCLiente($params) {
        $data['nombre'] = $params['nombre'];
        $data['apellidomaterno'] = $params['apellidomaterno'];
        $data['apellidopaterno'] = $params['apellidopaterno'];
        $data['direccion'] = $params['direccion'];
        $data['dni'] = $params['dni'];
        $data['password'] = $params['password'];
        $data['correo'] = $params['correo'];
        $data['telefono1'] = $params['telefono1'];
        $idcliente = $this->_clienteModel->crearCliente($data);
        return $idcliente;
    }

}