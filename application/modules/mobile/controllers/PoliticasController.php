<?php

class Default_PoliticasController extends ZExtraLib_Controller_Action
{
    public function init() {
        parent::init();
    }
    public function indexAction() {
        $this->view->headTitle('Politicas');
    }
}

