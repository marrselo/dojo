<?php
class Application_Model_Config  extends Zend_Db_Table {
    protected  $_name = "config";
    function insertConfig($data){
        $this->insert($data);
        $this->clearCache();
        return $this->getAdapter()->lastInsertId();
    }
    function listarConfig(){
        $cache = Zend_Registry::get('cache');
        if (!($result = $cache->load('listarConfig'))) {
        $result = $this->select()
                ->order('idconfig DESC')
                ->limit(1)
                ->query()
                ->fetch();
        $cache->save($result, 'listarConfig');
        }
        return $result;
    }
    function clearCache(){
        $cache = Zend_Registry::get('cache');
        $cache->remove('listarConfig');
        $result = $this->listarFullCategorias();
    }
    
    function actualizarConfig($data)

    {
        $this->update($data);
    }
    
}
