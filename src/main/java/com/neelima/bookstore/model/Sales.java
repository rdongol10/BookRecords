package com.neelima.bookstore.model;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.neelima.bookstore.dto.SalesDto;

@Entity
public class Sales {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;

	@ManyToOne
	@JoinColumn(name = "sold_by", nullable = false, updatable = true, insertable = true)
	@JsonIgnore
	private User user;

	@OneToMany(mappedBy = "sales", cascade = CascadeType.ALL)
	private List<SalesDetail> salesDetail;

	private Date soldDate;

	private double grandTotal;

	private double tax;

	private double vat;

	private double netTotal;

	public Sales() {

	}

	public Sales(SalesDto salesDto) {
		this.soldDate = new Date();
		this.grandTotal = salesDto.getGrandTotal();
		this.tax = salesDto.getTax();
		this.vat = salesDto.getVat();
		this.netTotal = salesDto.getNetTotal();

	}

	public Sales(long id, User user, List<SalesDetail> salesDetail, Date soldDate, double grandTotal, double tax,
			double vat, double netTotal) {
		super();
		this.id = id;
		this.user = user;
		this.salesDetail = salesDetail;
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

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<SalesDetail> getSalesDetail() {
		return salesDetail;
	}

	public void setSalesDetail(List<SalesDetail> salesDetail) {
		this.salesDetail = salesDetail;
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
