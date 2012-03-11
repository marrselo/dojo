<?php

class Default_TestController extends ZExtraLib_Controller_Action {


    public function init() {
        parent::init();
    }

    public function indexAction() {
        $this->view->headLink()->appendStylesheet("/f/css/jquery-ui-1.8.17.custom.css");
        $this->view->headScript()->appendFile('/f/js/jquery-ui-1.8.17.custom.min.js');
    }
}

