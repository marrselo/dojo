<?php
class Application_Model_Articulo  extends Zend_Db_Table {
    protected  $_name = "articulo";
    
    public function listaArticulos($buscar= null) {
      
        $fla = 1;
        if($buscar=='') {
            return $this->getAdapter()
                    ->select()
                    ->from('articulo')
                    ->where('fla = ?', $fla)
                    ->query()->fetchAll();
        }else{
            $where  =  $this->getAdapter()->quoteInto('codigo like ?', '%'.$buscar.'%');
            $where .= $this->getAdapter()->quoteInto(' or  nombre like ?', '%'.$buscar.'%');
            $where .= $this->getAdapter()->quoteInto(' or  descripcion like ?', '%'.$buscar.'%');
        return $this->getAdapter()
                    ->select()
                    ->from('articulo')
                    ->where('fla = ?', $fla)
                    ->where($where)
                    ->query()->fetchAll();
        }
    }
    public function crearArticulo($data){
        $this->insert($data);
    }  
    public function eliminarArticulo($idArticulo){
        $where = $this->getAdapter()->quoteInto('idarticulo = ?', $idArticulo);
        $data = array('fla'=>'0');
        $this->update($data, $where);
    }
    public function  actualizarArticulo($idArticulo,$data){
        $where = $this->getAdapter()->quoteInto('idarticulo = ?', $idArticulo);
        $this->update($data, $where);
    }
    public function listarUnArticulo($idArticulo) {
        return  $this->getAdapter()
                ->select()->from('articulo')
                ->where('idarticulo = ?', $idArticulo)
                ->query()
                ->fetch();
    }
    
    public function listarArticulosDeUnaCategoria($idCategoria) {
        return  $this->getAdapter()
                ->select()->from('articulo')
                ->where('idcategoria = ?', $idCategoria)
                ->query()
                ->fetchAll();
    }
    
    public function buscarArticulos($like,$idCategoria=null) {
        
        $where  =  $this->getAdapter()->quoteInto(' articulo.codigo like ?', '%'.$like.'%');
        $where .=  $this->getAdapter()->quoteInto(' or  articulo.nombre like ?', '%'.$like.'%');
        $where .=  $this->getAdapter()->quoteInto(' or  articulo.descripcion like ?', '%'.$like.'%');
        $result = $this->getAdapter()
                ->select()
                ->from('articulo',
                        array('nomArticulo' => 'articulo.nombre',
                              'descArticulo' => 'articulo.descripcion',
                              'articulo.precioventa',
                              'articulo.preciocompra',
                              'articulo.cantidad',
                              'articulo.codigo',
                              'articulo.idarticulo',
                              'categoria.idcategoria',
                              'nomCategoria' => 'categoria.nombre',
                            ))
                ->join('categoria', ' categoria.idcategoria = articulo.idcategoria','')
                ->where($where)
                ->where('categoria.estado = ?','1');
        //echo $result;
        if($idCategoria!=''){
            $result->where($this->getAdapter()->quoteInto(' idcategoria = ?', $idCategoria));
        }
      
        return $result->query()->fetchAll();

}
}
