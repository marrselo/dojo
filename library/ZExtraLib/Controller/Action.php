<?php
class ZExtraLib_Controller_Action
    extends Zend_Controller_Action {
    
    protected $_layout;
    protected $_hostFileStatic;
    protected $_arrayAclAnunciante;
    protected $_identity;

    //public $identity;
    public function init() 
    {
        parent::init();
        //$this->view->headScript()->appendFile('/js/jquery-1.7.min.js', $type = 'text/javascript') ;
        $this->session = (!isset($this->session))?new Zend_Session_Namespace('dojo'):null;
        $this->_identity = Zend_Auth::getInstance()->getIdentity();
        $this->_layout = Zend_Layout::getMvcInstance();
        $this->_flashMessenger  = $this->_helper->getHelper('FlashMessenger');
        $this->initView();
        
        if ($this->_request->getModuleName() == 'admin' && $this->_request->getControllerName() != 'login' ) {
            if(!isset($this->_identity))
                $this->_redirect ('/admin/login');
            if($this->_identity->FlagSuperUsuario != 1){
            $modelPerfil = new Application_Model_Perfil();
            $this->view->perfilUsuario = $modelPerfil->listarPerfilUsuarioLogeado($this->_identity->idusuario);
        }else{
            $modelMenu = new Application_Model_Menu();
            $this->view->perfilUsuario = $modelMenu->listaMenuSuperUsuario();
            
        }
            $rutaActual = '/'.$this->_request->getModuleName().'/'.$this->_request->getControllerName();
            $ruta= array();
        foreach($this->view->perfilUsuario as $index){
            $ruta[] = $index['url'];
        }
        
        if(!in_array($rutaActual, $ruta))
        {
            $this->_redirect ('/admin');
        }
        
            $this->_layout->setLayout('layoutadmin');
            $this->view->headLink()->appendStylesheet("/css/style.css")
                    ->appendStylesheet("/css/defaults.css")
                    ->appendStylesheet("/css/print.css",array("media"=>"print"));
            $this->view->headScript()
                    ->setIndent('      ')
                    ->prependFile("/css/fix-ie.css",'text/css',array("media"=>"screen","conditional" =>"lt IE 7"));
        }else{
            
            if($this->_request->getModuleName() == 'admin' && $this->_request->getControllerName() == 'login'){
                $this->_layout->setLayout('layoutlogin');
                            $this->view->headLink()->appendStylesheet("/css/style.css")
                    ->appendStylesheet("/css/defaults.css")
                    ->appendStylesheet("/css/print.css",array("media"=>"print"));
                            $this->view->headScript()
                    ->setIndent('      ')
                    ->prependFile("/css/fix-ie.css",'text/css',array("media"=>"screen","conditional" =>"lt IE 7"));

            }
                
            $this->view->perfilUsuario = array();
        }
        
        
        
        
    }

}