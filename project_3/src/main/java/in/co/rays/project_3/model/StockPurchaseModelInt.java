
package in.co.rays.project_3.model;

import java.util.List;

import in.co.rays.project_3.dto.StockPurchaseDateDTO;
import in.co.rays.project_3.exception.ApplicationException;
import in.co.rays.project_3.exception.DuplicateRecordException;

public interface StockPurchaseModelInt {
	
	public long add(StockPurchaseDateDTO dto)throws ApplicationException,DuplicateRecordException;
	public void delete(StockPurchaseDateDTO dto)throws ApplicationException;
	public void update(StockPurchaseDateDTO dto)throws ApplicationException,DuplicateRecordException;
	public List list()throws ApplicationException;
	public List list(int pageNo,int pageSize)throws ApplicationException;
	public List search(StockPurchaseDateDTO dto)throws ApplicationException;
	public List search(StockPurchaseDateDTO dto,int pageNo,int pageSize)throws ApplicationException;
	public StockPurchaseDateDTO findByPK(long pk)throws ApplicationException;
	public StockPurchaseDateDTO fingByName(String name)throws ApplicationException;

}
