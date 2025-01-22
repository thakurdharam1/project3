
package in.co.rays.project_3.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import in.co.rays.project_3.dto.BaseDTO;
import in.co.rays.project_3.dto.SupplierDTO;
import in.co.rays.project_3.exception.ApplicationException;
import in.co.rays.project_3.exception.DuplicateRecordException;
import in.co.rays.project_3.model.ModelFactory;
import in.co.rays.project_3.model.SupplierModelInt;
import in.co.rays.project_3.util.DataUtility;
import in.co.rays.project_3.util.DataValidator;
import in.co.rays.project_3.util.PropertyReader;
import in.co.rays.project_3.util.ServletUtility;

@WebServlet(urlPatterns = { "/ctl/SupplierCtl" })
public class SupplierCtl extends BaseCtl {

	private static final long serialVersionUID = 1L;
	private static Logger log = Logger.getLogger(CollegeCtl.class);

	protected boolean validate(HttpServletRequest request) {
		boolean pass = true;
		if (DataValidator.isNull(request.getParameter("name"))) {
			request.setAttribute("name", PropertyReader.getValue("error.require", "name"));
			pass = false;
		} else if (!DataValidator.isLetter(request.getParameter("name"))) {
			request.setAttribute("name", "Only letters are allowed");
			pass = false;
		}else if (DataValidator.isTooLong(request.getParameter("name"),20)) {
			request.setAttribute("name", "Only 20 Characters are allowed ");
			pass = false;
		}
		if (DataValidator.isNull(request.getParameter("paymentTerm"))) {
			request.setAttribute("paymentTerm", PropertyReader.getValue("error.require", "paymentTerm"));
			pass = false;
		}else if (!DataValidator.isInteger(request.getParameter("paymentTerm"))) {
			request.setAttribute("paymentTerm", "Only numbers are allowed ");
			pass = false;
		}else if (DataValidator.isTooLong(request.getParameter("paymentTerm"),7)) {
			request.setAttribute("paymentTerm", "Only 7 digits are allowed ");
			pass = false;
		}
		if (DataValidator.isNull(request.getParameter("date"))) {
			request.setAttribute("date", PropertyReader.getValue("error.require", "date"));
			pass = false;
		}else if (!DataValidator.isDate(request.getParameter("date"))) {
			request.setAttribute("date", PropertyReader.getValue("error.date", "date"));
			pass = false;
		}
		if (DataValidator.isNull(request.getParameter("category"))) {
			request.setAttribute("category", PropertyReader.getValue("error.require", "category"));
			pass = false;
		} 
		return pass;
	}
	@Override
	protected void preload(HttpServletRequest request) {
	
		


		
		Map<Integer, String> map = new HashMap<Integer, String>();

		map.put(1, "Raw Material");
		map.put(2, "Final Material");
		request.setAttribute("dharam", map);
		
	}

	protected BaseDTO populateDTO(HttpServletRequest request) {
		SupplierDTO dto = new SupplierDTO();
		dto.setName(DataUtility.getString(request.getParameter("name")));
		dto.setPaymentTerm(DataUtility.getString(request.getParameter("paymentTerm")));
		dto.setDate(DataUtility.getDate(request.getParameter("date")));
		dto.setCategory(DataUtility.getString(request.getParameter("category")));

		populateBean(dto, request);
		return dto;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String op = request.getParameter("operation");
		long id = DataUtility.getLong(request.getParameter("id"));
		SupplierModelInt model = ModelFactory.getInstance().getSupplierModel();
		if (id > 0 || op != null) {
			SupplierDTO dto;
			try {
				dto = model.findByPK(id);
				ServletUtility.setDto(dto, request);

			} catch (ApplicationException e) {
				log.error(e);
				ServletUtility.handleException(e, request, response);
				return;
			}

		}
		ServletUtility.forward(getView(), request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		System.out.println("in product post method");

		String op = request.getParameter("operation");
		long id = DataUtility.getLong(request.getParameter("id"));

		SupplierModelInt model = ModelFactory.getInstance().getSupplierModel();

		if (OP_SAVE.equalsIgnoreCase(op) || OP_UPDATE.equalsIgnoreCase(op)) {

			SupplierDTO dto = (SupplierDTO) populateDTO(request);

			try {
				if (id > 0) {
					dto.setId(id);
					model.update(dto);
					ServletUtility.setDto(dto, request);

					ServletUtility.setSuccessMessage("Record Successfully Updated", request);

				} else {
					System.out.println("college add" + dto + "id...." + id);
					// long pk
					model.add(dto);
					ServletUtility.setSuccessMessage("Record Successfully Saved", request);
				}
				ServletUtility.setDto(dto, request);
			} catch (ApplicationException e) {
				e.printStackTrace();
				log.error(e);
				ServletUtility.handleException(e, request, response);
				return;
			} catch (DuplicateRecordException e) {
				ServletUtility.setDto(dto, request);
				ServletUtility.setErrorMessage("name Already Exists", request);
			}
		} else if (OP_RESET.equalsIgnoreCase(op)) {
			ServletUtility.redirect(ORSView.SUPPLIER_CTL, request, response);
			return;
		} else if (OP_CANCEL.equalsIgnoreCase(op)) {

			ServletUtility.redirect(ORSView.SUPPLIER_LIST_CTL, request, response);
			return;

		}
		ServletUtility.forward(getView(), request, response);
	}

	@Override
	protected String getView() {
		// TODO Auto-generated method stub
		return ORSView.SUPPLIER_VIEW;
	}

}
