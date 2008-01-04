<?php
class Application_Model_Perfil  extends Zend_Db_Table {
    protected  $_name = "perfil";
    
    public function crearPerfil($data,$idUsuario) {
        $this->eliminarPerfilUsuario($idUsuario);
        if($data!=''){
        $data = is_array($data)?implode($data,','):$data;
        $sqlSelectMenu = "SELECT `idmenu`, $idUsuario AS `idusuario` FROM `menu` WHERE ( idmenu IN (".$data."))";
        $sqlInsertPerfil = 'INSERT INTO perfil (idMenu,idusuario) '.$sqlSelectMenu;
        $this->getAdapter()->query($sqlInsertPerfil);
        $datausr['idusuario'] = $idUsuario;
        $datausr['idmenu'] = 8;
        $this->insert($datausr);
        
        }
    }
    public function listarPerfilUsuario($idUsuario){
        return $this->getAdapter()->fetchAll($this->getAdapter()
                ->select()
                ->from('perfil')
            ->where('idusuario = ?',$idUsuario));
    }
    public function eliminarPerfilUsuario($idUsuario){
        $where = $this->getAdapter()->quoteInto('idusuario = ?', $idUsuario);    
        $this->delete($where);    

    }
    public function listarPerfilUsuarioLogeado($idUsuario){
        return $this->getAdapter()->fetchAll(
                $this->getAdapter()
                ->select()
                ->from('menu')
                ->join('perfil', 'perfil.idmenu = menu.idmenu')
                ->where('perfil.idusuario = ?',$idUsuario));
    }
    

}