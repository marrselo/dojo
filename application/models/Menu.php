<?php
class Application_Model_Menu  extends Zend_Db_Table {
    protected  $_name = "menu";
    
    public function listaMenu() 
    {
        $idIndex = 8;
       
        return $this->getAdapter()->fetchPairs($this->getAdapter()
                ->select()
                ->from('menu',array('menu.idmenu','menu.nombre'))
                ->where('idmenu != ?',$idIndex)
                ->order('orden')
                );
    }
    
    
    public function listaMenuSuperUsuario() {
        return $this->getAdapter()->fetchAll($this->getAdapter()
                ->select()
                ->from('menu')
                ->order('orden'));
    }
     
   

}