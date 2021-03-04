package com.neelima.bookstore.dto;

import java.util.Date;
import java.util.List;

public class SalesDto {

	private long id;

	private String user;

	private List<SalesDetailDto> salesDetailDto;

	private Date soldDate;

	private double grandTotal;

	private double tax;

	private double vat;

	private double netTotal;

	public SalesDto() {

	}

	public SalesDto(long id, String user, List<SalesDetailDto> salesDetailDto, Date soldDate, double grandTotal,
			double tax, double vat, double netTotal) {
		super();
		this.id = id;
		this.user = user;
		this.salesDetailDto = salesDetailDto;
		this.soldDate = soldDate;
		this.grandTotal = grandTotal;
		this.tax = tax;
		this.vat = vat;
		this.netTotal = netTotal;
	}

	public SalesDto(List<SalesDetailDto> salesDetailDto, Date soldDate, double grandTotal, double tax, double vat,
			double netTotal) {
		super();
		this.salesDetailDto = salesDetailDto;
		this.soldDate = soldDate;
		this.grandTotal = grandTotal;
		this.tax = tax;
		this.vat = vat;
		this.netTotal = netTotal;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public List<SalesDetailDto> getSalesDetailDto() {
		return salesDetailDto;
	}

	public void setSalesDetailDto(List<SalesDetailDto> salesDetailDto) {
		this.salesDetailDto = salesDetailDto;
	}

	public Date getSoldDate() {
		return soldDate;
	}

	public void setSoldDate(Date soldDate) {
		this.soldDate = soldDate;
	}

	public double getGrandTotal() {
		return grandTotal;
	}

	public void setGrandTotal(double grandTotal) {
		this.grandTotal = grandTotal;
	}

	public double getTax() {
		return tax;
	}

	public void setTax(double tax) {
		this.tax = tax;
	}

	public double getVat() {
		return vat;
	}

	public void setVat(double vat) {
		this.vat = vat;
	}

	public double getNetTotal() {
		return netTotal;
	}

	public void setNetTotal(double netTotal) {
		this.netTotal = netTotal;
	}

}
