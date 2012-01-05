<?php
class Application_Model_Busqueda  extends Zend_Db_Table {

    public function buscar($arraySlug){
       if($arraySlug=='[a]')     
           $arraySlug='';
        $result = $this->getAdapter()
                ->select()
                ->distinct()
                ->from('articulo',array('articulo.idarticulo',
            'articulo.idcategoria',
            'articulo.codigo',
            'articulo.nombre',
            'articulo.imagen',
            'articulo.descripcion',
            'articulo.precioventa',
            'articulo.preciocompra', 
            'articulo.slug', 
            'articulo.cantidad',
            'articulo.stock_min'))
                ->join('detalleslug', 'articulo.idarticulo = detalleslug.idarticulo','')
                ->join('slug', 'slug.idslug = detalleslug.idslug','');
        if($arraySlug!=''){
            $result->where('slug.nombreslug REGEXP ?',array($arraySlug));
        }
        return $result;
        
                
    }
}