<?php
class Application_Model_RelacionarArticulo  extends Zend_Db_Table {
    protected  $_name = "relacionararticulo";
    public function relacionarArticulo($idArticulo,$arrayArticulo) {
        $data = array();
        $where =$this->getAdapter()->quoteInto('idarticulo = ?',$idArticulo);
        $this->delete($where);
        foreach($arrayArticulo as $index){
            $data = array('idarticulo'=>$idArticulo,'idarticulorelacionado'=>$index);
            //print_r($data);
            $this->insert($data);
        }
    }
    
    public function listarRelacionArticulo($idArticulo){
        return $this->getAdapter()
                ->select()
                ->from(array('ra'=>'relacionararticulo'))
                ->join(array('ar'=>'articulo'),'ra.idarticulorelacionado=ar.idarticulo')
                ->where('ra.idarticulo =?',$idArticulo)
                ->where('ar.fla=?',1)
                ->query()
                ->fetchAll();
    }
}
