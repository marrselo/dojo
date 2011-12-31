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
            $where  =  $this->getAdapter()->quoteInto(' idarticulo = ?', $buscar);
            $where .= $this->getAdapter()->quoteInto(' or  nombre like ?', '%'.$buscar.'%');
            $where .= $this->getAdapter()->quoteInto(' or  descripcion like ?', '%'.$buscar.'%');
            echo $this->getAdapter()
                    ->select()
                    ->from('articulo')
                    ->where('fla = ?', $fla)
                    ->where($where);
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
        return $this->getAdapter()->lastInsertId();
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
        $response = $this->getAdapter()
                ->select()->from('articulo')
                ->where('idarticulo = ?', $idArticulo);
        return $response->query()->fetch();
    }
    
    public function listarArticulosDeUnaCategoria($idCategoria) {
        
        return  $this->getAdapter()
                ->select()->from('articulo')
                ->orWhere('idcategoria = ?', $idCategoria)
                ->orWhere('idsubcategoria = ?', $idCategoria);
    }
    
    public function registroSlugArticulo($texto,$idArticulo){
        $slugModel = new Application_Model_Slug();
        $detalleSlugModel = new Application_Model_DetalleSlug();
        $filter = new ZExtraLib_SeoUrl();
        $texto = $filter->filter(trim($texto),'-',0);
        $texto = explode('-', $texto);
        $detalleSlugModel->eliminarDetalleSlugPorArticulo($idArticulo);
        foreach($texto as $index){
            //echo $index;
            if($dataSlug=$slugModel->buscarSlugPorNombre($index)){
                //echo 'el registro '.$index.' existe<p>';
                $idSlug = $dataSlug['idslug'];
                if(!$detalleSlugModel->buscarDeralleSlug($idSlug, $idArticulo)){
                    $detalleSlugModel->registrarDetalleSlug($idSlug, $idArticulo);
                }
            }else{
                $idSlug = $slugModel->registrarSlug($index);
                $detalleSlugModel->registrarDetalleSlug($idSlug, $idArticulo);
            }    
        }
        
        
    }

    public function listarEnPortada(){
                return $this->getAdapter()
                        ->select()
                        ->distinct()
                        ->from('articulo')
                        ->where('fla = ?',1)
                        ->where('flagportada = ?',1);
    }

    public function buscarArticulos($like,$idCategoria=null,$notInt=null) {
        $fla=1;
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
                ->where('articulo.fla = ?', $fla)
                ->where($where)
                ->where('categoria.estado = ?','1');
        //echo $result;
        if($idCategoria!=''){
            $result->where($this->getAdapter()->quoteInto(' idcategoria = ?', $idCategoria));
        }
        
        if($notInt!=''){
        $result->where('articulo.idarticulo not in ('.$notInt.')');    
        }
        //echo $result;
      
        return $result->query()->fetchAll();

}
}
