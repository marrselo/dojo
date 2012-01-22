<?php
class Application_Model_Config  extends Zend_Db_Table {
    protected  $_name = "config";
    function insertConfig($data){
        $this->insert($data);
        $this->listarConfig();
        return $this->getAdapter()->lastInsertId();
    }
    function listarConfig(){
        $cache = Zend_Registry::get('cache');
        if (!($result = $cache->load('listarConfig'))) {
        $result = $this->select()
                ->order('idconfig DES')
                ->limit(1)
                ->query()
                ->fetch();
        }
        return $result;
    }
    
    }
