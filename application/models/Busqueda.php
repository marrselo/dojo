<?php
class Application_Model_Busqueda  extends Zend_Db_Table {

    public function buscar($arraySlug){
        return $this->getAdapter()
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
            'articulo.cantidad',
            'articulo.stock_min'))
                ->join('detalleslug', 'articulo.idarticulo = detalleslug.idarticulo','')
                ->join('slug', 'slug.idslug = detalleslug.idslug','')
                ->where('slug.nombreslug REGEXP ?',array($arraySlug));
    }
}