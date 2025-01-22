
package in.co.rays.project_3.model;

import java.util.List;

import in.co.rays.project_3.dto.SupplierDTO;
import in.co.rays.project_3.exception.ApplicationException;
import in.co.rays.project_3.exception.DuplicateRecordException;

public interface SupplierModelInt {
	
	public long add(SupplierDTO dto)throws ApplicationException,DuplicateRecordException;
	public void delete(SupplierDTO dto)throws ApplicationException;
	public void update(SupplierDTO dto)throws ApplicationException,DuplicateRecordException;
	public List list()throws ApplicationException;
	public List list(int pageNo,int pageSize)throws ApplicationException;
	public List search(SupplierDTO dto)throws ApplicationException;
	public List search(SupplierDTO dto,int pageNo,int pageSize)throws ApplicationException;
	public SupplierDTO findByPK(long pk)throws ApplicationException;
	public SupplierDTO fingByName(String name)throws ApplicationException;

}
