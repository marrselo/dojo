<?php

class Default_LoginController extends ZExtraLib_Controller_Action {
    protected $_usuarioModel;
    protected $_perfilModel;
    function init() {
        parent::init();
        $this->_usuarioModel = new Application_Model_Usuario();
        $this->_perfilModel = new Application_Model_Perfil();
        $this->view->headLink()->appendStylesheet("/f/css/contacto-form.css");
    }
        public function auth($usuario =NULL ,$password =NULL){
        if($usuario== NULL || $password == NULL){
         return false;   
        } else {
        $auth = Zend_Auth::getInstance();
        $adapter = new Zend_Auth_Adapter_DbTable($this->_usuarioModel->getAdapter(),
                    'cliente', 'correo', 'password');
        $adapter->setIdentity($usuario);
        $adapter->setCredential($password);
        $resultAut = $auth->authenticate($adapter); 
        if($resultAut->isValid()){
            $userInfo = $adapter->getResultRowObject(null, 'password');
            $authStorage = $auth->getStorage();
            $authStorage->write($userInfo);
        }
            return $resultAut->isValid();
            }
        }
        public function indexAction(){
            
            $this->view->messages = $this->_flashMessenger->getMessages();
            $params =  $this->_request->getParams();
            $this->view->form = $form = $this->formLogin();
            if ($this->_request->isPost()) {
                if ($form->isValid($params)) {
                    if ($this->auth($params['login'], $params['password'],1)) {
                    $this->_redirect($_SERVER['HTTP_REFERER']);
                    } else {
                    $this->_flashMessenger->addMessage('Correo y/o contraseña incorrectos.');
                    $this->_redirect('/login/error');
                    }
                }else{
                    $this->_flashMessenger->addMessage($form->getMessages());
                    $this->_redirect($_SERVER['HTTP_REFERER']);
                }
            }else{
                $this->_redirect($_SERVER['HTTP_REFERER']);
            }
        }
        public function errorAction() {
            $this->view->error = 'Correo y/o contraseña incorrectos.';
        }
        
        public function loginAction(){
            $params =  $this->_request->getParams();
            $this->auth($params['login'], $params['password'],1);
            $this->_redirect($_SERVER['HTTP_REFERER']);
            
        }
        public function loginUpdateAction(){
            $params =  $this->_request->getParams();
            $this->auth($params['login'], $params['password'],1);
            //$this->_redirect($_SERVER['HTTP_REFERER']);
            
        }
        public function formLogin(){
            $form = new Zend_Form();
            $form->setMethod('Post');
            $form->addElement(new Zend_Form_Element_Text('login',array('required'=> true,'label'=>'Correo')));
            $form->addElement(new Zend_Form_Element_Password('password',array('required'=> true,'label'=>'Password')));
            $form->addElement(new Zend_Form_Element_Submit('Enviar'));
            return $form;
            
   }
   
   public function logoutAction(){
        Zend_Auth::getInstance()->clearIdentity();
        $this->_redirect('/');
    }

}
?>
