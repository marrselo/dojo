<?php
class Default_MisDatosController extends ZExtraLib_Controller_Action 
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
        $this->session->idCliente = $this->_identity->idcliente;
            if ($form->isValid($params)) {
                $this->updateCLiente($params);
                $this->updateUsuarioAction($params);
                $this->_redirect('/login/login?login='.$params['correo'].'&'.'password='.$params['password']);
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
        $form->getElement('password')->setRequired();
        $form->getElement('confirmPassword')->setRequired();
        $form->getElement('dni')->setRequired()->setValue($this->_identity->dni);
        $form->getElement('nombre')->setRequired()->setValue($this->_identity->nombre);
        $form->getElement('apellidopaterno')->setRequired()->setValue($this->_identity->apellidopaterno);
        $form->getElement('apellidomaterno')->setRequired()->setValue($this->_identity->apellidomaterno);
        $form->getElement('telefono1')->setRequired()->setValue($this->_identity->telefono);
        $form->getElement('direccion')->setRequired()->setValue($this->_identity->direccion);
        $form->setDecorators(
                array(
                    array('ViewScript',
                        array('viewScript' => 'form/registrocliente2.phtml'))));
        return $form;
    }
        function updateCLiente($params) {
        $data['nombre'] = $params['nombre'];
        $data['apellidomaterno'] = $params['apellidomaterno'];
        $data['apellidopaterno'] = $params['apellidopaterno'];
        $data['direccion'] = $params['direccion'];
        $data['dni'] = $params['dni'];
        $data['correo'] = $params['correo'];
        $data['telefono1'] = $params['telefono1'];
        $this->_clienteModel->actualizarCliente($this->_identity->idcliente,$data);
        }
    
    function updateUsuarioAction($params) {
            $data['nombre']=$params['nombre'];
            $data['apellidomaterno']=$params['apellidomaterno'];
            $data['apellidopaterno']=$params['apellidopaterno'];
            $data['login']=$params['correo'];
            $data['password']=$params['password'];
            $data['correo']=$params['correo'];
            $data['telefono']=$params['telefono1'];
            $data['direccion']=$params['direccion'];
            $model= new Application_Model_Usuario();
            $model->actualizarUsuario2($this->_identity->idusuario,$data);
    }


}