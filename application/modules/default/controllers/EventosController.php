<?php

class Default_EventosController extends ZExtraLib_Controller_Action
{

    public function init() {
        parent::init();
    }
    public function indexAction()
    {
        $this->view->headTitle('Eventos');
        $this->view->menuActive4='active';
    }
}