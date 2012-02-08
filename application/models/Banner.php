<?php
class Application_Model_Banner  extends Zend_Db_Table {
    
    protected  $_name = "banner"; 
    
    
    public function listarBanner()
    {
        $cache = Zend_Registry::get('cache');
        if (!($result = $cache->load('listarBanner'))) {
        $result = $this->getAdapter()->fetchAll($this->getAdapter()
                ->select()
                ->from('banner',array('idbanner','nombre','descripcion','imagen','url'))
                ->order('orden')
                );
        $cache->save($result, 'listarBanner');
        }
        return $result;

    }
    public function getBanner($idBanner)
    {        
        return  $this->getAdapter()
                ->select()->from('banner')
                ->where('idbanner = ?', $idBanner)
                ->query()
                ->fetch();
    }
    
    public function crearBanner($data){
        $this->insert($data);
        return $this->getAdapter()->lastInsertId();
    } 
    
    public function  actualizarBanner($idBanner,$data){
        $where = $this->getAdapter()->quoteInto('idbanner = ?', $idBanner);
        $this->update($data, $where);
    }
    public function eliminarBanner($idBanner){
        $frontController = Zend_Controller_Front::getInstance();
        $file = $frontController->getParam('bootstrap')->getOption('file2');

        $arrImagen = $this->getBanner($idBanner);
        if(file_exists($file.'/'.$arrImagen['imagen'])){
            unlink($file.'/'.$arrImagen['imagen']);
        }   
        $where = $this->getAdapter()->quoteInto('idbanner = ?', $idBanner);
        $this->delete($where);        
    }
}