<?php

class ZExtraLib_Controller_Action extends Zend_Controller_Action {

    protected $_layout;
    protected $_config;
    protected $_hostFileStatic;
    protected $_arrayAclAnunciante;
    protected $_identity;

    //public $identity;
    public function init() {
        parent::init();
                $this->view->doctype(Zend_View_Helper_Doctype::XHTML1_RDFA);
        $this->view->headMeta()->setProperty('og:title', 'Delivery Premium');
        $this->view->headMeta()->setProperty('og:type', 'author');
        $this->view->headMeta()->setProperty('og:description', 'Bienvenido a Delivery Premium, Entrar');
        $this->view->headMeta()->setProperty('og:url', $this->view->baseUrl().$_SERVER['REQUEST_URI']);
        $this->view->headMeta()->setProperty('og:image', 'http://deliverypremiumsac.com/f/img/logo.png');
        $this->view->headMeta()->setProperty('og:site_name', 'Delivery Premium');
        $this->view->headMeta()->setProperty('og:admins', '698823485');
        /*
        <meta property="og:title" content="delivery premium" />
        <meta property="og:type" content="author" />
        <meta property="og:url" content="http://deliverypremiumsac.com" />
        <meta property="og:image" content="http://deliverypremiumsac.com/f/img/logo.png" />
        <meta property="og:site_name" content="delivery premium" />
        <meta property="fb:admins" content="698823485" />
        */
        $this->session = (!isset($this->session)) ? new Zend_Session_Namespace('dojo') : null;
        $this->_identity = Zend_Auth::getInstance()->getIdentity();
        $this->_layout = Zend_Layout::getMvcInstance();
        $this->_flashMessenger = $this->_helper->getHelper('FlashMessenger');
        $this->initView();
        
        
        if ($this->getRequest()->getModuleName() == 'default') {
            $modelCategoria = new Application_Model_Categoria();
            $modelArticulo = new Application_Model_Articulo();
            $this->view->listaCategoria=$modelCategoria->listarFullCategorias();
            $this->view->listaDeUnArticulosEnOferta = $modelArticulo->listarUnArticulosEnOferta();
            if(isset($this->session->listaArticulo)){
            $this->view->listaArticuloCarrito = $this->session->listaArticulo;
            }
            
        } else {
            if ($this->getRequest()->getModuleName() == 'admin' && $this->getRequest()->getControllerName() != 'login') {
                if (!isset($this->_identity))
                    $this->_redirect('/admin/login');
                if ($this->_identity->FlagSuperUsuario != 1) {
                    $modelPerfil = new Application_Model_Perfil();
                    $this->view->perfilUsuario = $modelPerfil->listarPerfilUsuarioLogeado($this->_identity->idusuario);
                } else {
                    $modelMenu = new Application_Model_Menu();
                    $this->view->perfilUsuario = $modelMenu->listaMenuSuperUsuario();
                }
                $rutaActual = '/' . $this->getRequest()->getModuleName() . '/' . $this->getRequest()->getControllerName();
                $ruta = array();
                foreach ($this->view->perfilUsuario as $index) {
                    $ruta[] = $index['url'];
                }

                if (!in_array($rutaActual, $ruta)) {
                    $this->_redirect('/admin');
                }

                $this->_layout->setLayout('layoutadmin');
                $this->view->headLink()->appendStylesheet("/css/style.css")
                        ->appendStylesheet("/css/custom.css")
                        ->appendStylesheet("/css/defaults.css")
                        ->appendStylesheet("/css/print.css", array("media" => "print"));
                $this->view->headScript()
                        ->setIndent('      ')
                        ->prependFile("/css/fix-ie.css", 'text/css', array("media" => "screen", "conditional" => "lt IE 7"));
            } else {

                if ($this->getRequest()->getModuleName() == 'admin' && $this->getRequest()->getControllerName() == 'login') {
                    $this->_layout->setLayout('layoutlogin');
                    $this->view->headLink()->appendStylesheet("/css/style.css")
                            ->appendStylesheet("/css/defaults.css")
                            ->appendStylesheet("/css/print.css", array("media" => "print"));
                    $this->view->headScript()
                            ->setIndent('      ')
                            ->prependFile("/css/fix-ie.css", 'text/css', array("media" => "screen", "conditional" => "lt IE 7"));
                }

                $this->view->perfilUsuario = array();
            }
        }
        $config = new Application_Model_Config();
        $this->_config = $config->listarConfig();
        $this->view->config = $this->_config;
        
    }

}