<?php
class Application_Model_Cliente  extends Zend_Db_Table {
    protected  $_name = "cliente";
    
    public function listaClientes($buscar = null) {
        $estado = 1;
        if($buscar == ''){
        return $this->getAdapter()
                ->select()
                ->from('cliente')
                ->where('estado = ?', $estado)
                ->query()->fetchAll();
        } else{
            
            $where  =  $this->getAdapter()->quoteInto('apellidomaterno like ?', '%'.$buscar.'%');
            $where .= $this->getAdapter()->quoteInto(' or  apellidopaterno like ?', '%'.$buscar.'%');
            $where .= $this->getAdapter()->quoteInto(' or dni like ?', '%'.$buscar.'%');
            $where .= $this->getAdapter()->quoteInto(' or nombre like ?', '%'.$buscar.'%');
            $where .= $this->getAdapter()->quoteInto(' or direccion like ?', '%'.$buscar.'%');
            return $this->getAdapter()
                    ->select()
                    ->from('cliente')
                    ->where('estado = ?', $estado)
                    ->where($where)
                    ->query()->fetchAll();
        }
    }
    public function crearCliente($data){
        $this->insert($data);
        return $this->getAdapter()->lastInsertId();
    }
    
    public function eliminarCliente($idCliente){
        $where = $this->getAdapter()->quoteInto('idcliente = ?', $idCliente);
        $data = array('estado'=>'0');
        $this->update($data, $where);
    }
    public function  actualizarCliente($idCliente,$data){
        $where = $this->getAdapter()->quoteInto('idcliente = ?', $idCliente);
        $this->update($data, $where);
        return $idCliente;
    }
    public function listarUnCliente($idCliente) {
        return  $this->getAdapter()
                ->select()->from('cliente')
                ->where('idcliente = ?', $idCliente)
                ->query()
                ->fetch();
    }
    public function verificarEmailCliente($correo,$idCliente = null) {
        $response = $this->select()
                ->from('cliente')
                ->where('correo = ?', $correo);
        if ($idCliente!='')
            $response->where('idcliente != ?', $idCliente);
        return $this->getAdapter()->fetchAll($response);
        
    }
    
    public function verificarDniCliente($dni,$idCliente = null) {
        $response = $this->select()
                ->from('cliente')
                ->where('dni = ?', $dni);
        if ($idCliente!='')
            $response->where('idcliente != ?', $idCliente);
        return $this->getAdapter()->fetchAll($response);
        
    }
    public function verificarCLienteWeb($correo,$dni){
        return $this->select()
                ->from('cliente')
                ->where('dni = ?', $dni)
                ->where('correo = ?', $correo)
                ->query()
                ->fetch();
    }
}

?>