<?php

class Default_RegistrateController extends ZExtraLib_Controller_Action
{
protected $_clienteModel;

    public function init() {
        parent::init();
        $this->_clienteModel = new Application_Model_Cliente();
    }
    public function indexAction()
    {
        $this->view->headLink()->appendStylesheet("/f/css/contacto-form.css");
        $this->view->headTitle('Registrate');
        $this->view->menuActive4='active';
        $form = $this->formularioCliente();
        $params = $this->_request->getParams();
        if ($this->_request->isPost()) {
        $form->getElement('password')->addValidator(new Zend_Validate_Identical($params['confirmPassword']));
            if ($form->isValid($params)) {
                $this->registrarCLiente($params);
  //              $this->generarComprobante($params);
                $this->_redirect('/registrate');
            } else {
                $this->_flashMessenger->addMessage('No se pudo realizar la Operacion');
                $this->view->formRegistroCliente = $form;
            }
        }else{
            $this->view->formRegistroCliente = $form;
        }
        $this->view->messages = $this->_flashMessenger->getMessages();

    }
    
    public function formularioCliente() {
        $date = new Zend_Date();
        
        $form = new Application_Form_FormCliente();
        $form->addElement(new Zend_Form_Element_Password('password',array('label'=>'Password')));
        $form->addElement(new Zend_Form_Element_Password('confirmPassword',array('label'=>'Confirmar Password')));
    //        $form->getElement('dni')->removeValidator('ZExtraLib_Validate_DniExist');
        $form->getElement('password')->setRequired();
        $form->getElement('confirmPassword')->setRequired();
        $form->getElement('dni')->setRequired();
    //      $form->getElement('correo')->removeValidator('ZExtraLib_Validate_MailExist');
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
        $data['correo'] = $params['correo'];
        $data['telefono1'] = $params['telefono1'];
        $idcliente = $this->_clienteModel->crearCliente($data);
        return $idcliente;
    }
    
    function nuevoUsuarioAction($params) {
            $data['nombre']=$params['nombre'];
            $data['apellidomaterno']=$params['apellidomaterno'];
            $data['apellidopaterno']=$params['apellidopaterno'];
            $data['login']=$params['correo'];
            $data['password']=$params['password'];
            $data['correo']=$params['correo'];
            $data['telefono']=$params['telefono'];
            $model= new Application_Model_Usuario();
            $model->crearUsuarioCliente($data);
    }


}