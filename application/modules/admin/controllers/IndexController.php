<?php

class Admin_IndexController
        extends ZExtraLib_Controller_Action
{
    function init() {
        parent::init();
        
        
    }
    function indexAction()
    {
        print_r($this->_identity);
    }


}

//class Admin_IndexController