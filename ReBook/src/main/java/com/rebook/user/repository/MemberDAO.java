package com.rebook.user.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import com.rebook.user.model.MemberDTO;
import com.rebook.user.model.MemberInfoDTO;
import com.test.util.DBUtil;

public class MemberDAO {

	public static MemberDAO dao;
	
	private Connection conn;
	private Statement stat;
	private PreparedStatement pstat;
	private ResultSet rs;
	
	private MemberDAO() {
		this.conn = DBUtil.open("localhost", "rebook", "java1234");
	}
	
	public static MemberDAO getInstance() {
		
		
		if (dao == null) {
			dao = new MemberDAO();
		}
		
		return dao;
		
	}
	
	private String seq;
	private String member_seq;
	private String name;
	private String tel;
	private String email;
	private String pic;
	private String address;
	private String addrDetail;
	private String zipcode;
	private String regDate;
	
	public MemberDTO login(MemberDTO dto) {
		
		try {
			
			String sql = "select m.seq as memberSeq, id, password, ing, lv, "
					   + "memberInfoSeq, name, tel, email, pic, address, addrDetail, zipcode, regDate "
					   + "from tblMember m where id = ? password = ?"
					   + "inner join tblMemberInfo i on i.member_seq = m.seq";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, dto.getId());
			pstat.setString(2, dto.getPassword());
			
			rs = pstat.executeQuery();
			
			while (rs.next()) {
				
				MemberDTO mdto = new MemberDTO();
				
				mdto.setSeq(rs.getString("memberSeq"));
				mdto.setId(rs.getString("id"));
				mdto.setPassword(rs.getString("password"));
				mdto.setIng(rs.getString("ing"));
				mdto.setLv(rs.getString("lv"));
				
				MemberInfoDTO idto = new MemberInfoDTO();
				idto.setSeq(rs.getString("memberInfoSeq"));
				idto.setName(rs.getString("Name"));
				idto.setTel(rs.getString("tel"));
				idto.setEmail(rs.getString("email"));
				idto.setPic(rs.getString("pic"));
				idto.setAddress(rs.getString("address"));
				idto.setAddrDetail(rs.getString("addrDetail"));
				idto.setZipcode(rs.getString("zipcode"));
				idto.setRegDate(rs.getString("regDate"));
				
				return mdto;
				
			}
			
		} catch (Exception e) {

		}
		
		return null;
	}
	
}
