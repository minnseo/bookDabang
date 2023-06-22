package kr.mypage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.book.vo.BookVO;
import kr.member.vo.MemberVO;
import kr.mypage.vo.BookMarkVO;
import kr.util.DBUtil;

public class MyPageDAO {
	//싱글턴 패턴
	private static MyPageDAO instance = new MyPageDAO();
	public static MyPageDAO getInstance() {
		return instance;
	}
	private MyPageDAO() {}
	
		
		//회원상세정보 
		public MemberVO getMember(int mem_num) throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			MemberVO vo = null;
			String sql = null;
			
			try {
				conn = DBUtil.getConnection();
				sql = "SELECT * FROM member m JOIN member_detail d "
						+ "ON m.mem_num=d.mem_num WHERE m.mem_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, mem_num);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					vo = new MemberVO();
					vo.setMem_num(rs.getInt("mem_num"));
					vo.setName(rs.getString("name"));
					vo.setPasswd(rs.getString("passwd"));
					vo.setSex(rs.getInt("sex"));
					vo.setBirthday(rs.getString("birthday"));
					vo.setPhone(rs.getString("phone"));
					vo.setZipcode(rs.getString("zipcode"));
					vo.setAddress1(rs.getString("address1"));
					vo.setAddress2(rs.getString("address2"));
					vo.setEmail(rs.getString("email"));
				}
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(rs, pstmt, conn);
			}
			
			return vo;
		}
		
		
	//회원정보 수정
	public void updateMember(MemberVO vo) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "UPDATE member_detail "
					+ "SET name=?,passwd=?,phone=?,email=?,address1=?,zipcode=?,address2=? "
					+ "WHERE mem_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getPhone());
			pstmt.setString(3, vo.getEmail());
			pstmt.setString(4, vo.getAddress1());
			pstmt.setString(5, vo.getZipcode());
			pstmt.setString(6, vo.getAddress2());
			pstmt.setInt(7, vo.getMem_num());
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//ID중복체크 및 로그인처리
		public MemberVO checkMember(String id) throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			MemberVO vo = null;
			String sql = null;
			
			try {
				//커넥션 풀로부터 커넥션을 할당받음
				conn = DBUtil.getConnection();
				//SQL문 생성
				sql = "SELECT * FROM member m "
					+ "LEFT OUTER JOIN member_detail d "
					+ "ON m.mem_num = d.mem_num WHERE m.id=?";
				//PreparedStatement 객체 생성
				pstmt = conn.prepareStatement(sql);
				//?에 데이터 바인딩
				pstmt.setString(1, id);
				//SQL문 실행
				rs = pstmt.executeQuery();
				if(rs.next()) {
					vo = new MemberVO();
					vo.setMem_num(rs.getInt("mem_num"));
					vo.setId(rs.getString("id"));
					vo.setAuth(rs.getInt("auth"));
					vo.setPasswd(rs.getString("passwd"));
					vo.setPhoto(rs.getString("photo"));
					vo.setEmail(rs.getString("email"));
				}
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(rs, pstmt, conn);
			}

			return vo;
		}
		
		
	//비밀번호 수정
	public void updatePassword(String passwd, int mem_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			//커넥션 풀로부터 커넥션을 할당 받음
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "UPDATE member_detail SET passwd=? WHERE mem_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setString(1, passwd); //새 비밀번호
			pstmt.setInt(2, mem_num); //회원번호
			//SQL문 실행
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//프로필 사진 수정
	public void updateMyPhoto(String photo, int mem_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			//커넥션 풀로부터 커넥션을 할당 받음
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "UPDATE member_detail SET photo=? WHERE mem_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setString(1, photo);
			pstmt.setInt(2, mem_num);
			//SQL문 실행
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally{
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//프로필 사진 정보 삭제
			public void deletePhoto(int mem_num) throws Exception{
				Connection conn = null;
				PreparedStatement pstmt = null;
				String sql = null;
				try {
					//커넥션 풀로부터 커넥션을 할당
					conn = DBUtil.getConnection();
					//SQL문 작성
					sql = "UPDATE member_detail SET photo='' WHERE mem_num=?";
					//PreparedStatement 객체 생성
					pstmt = conn.prepareStatement(sql);
					//?에 데이터 바인딩
					pstmt.setInt(1, mem_num);
					//SQL문 실행
					pstmt.executeUpdate();
				}catch(Exception e) {
					throw new Exception(e);
				}finally {
					DBUtil.executeClose(null, pstmt, conn);
				}
			}
	
	
	//회원 탈퇴 (회원정보 삭제)
	public void deleteMember(int mem_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		String sql = null;
		try {
			//커넥션 풀로부터 커넥션을 할당받음
			conn = DBUtil.getConnection();
			//auto commit 해제
			conn.setAutoCommit(false);
			
			//member의 auth 변경
			sql = "UPDATE member SET auth=0 WHERE mem_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			pstmt.executeUpdate();
			
			//member_detail의 레코드 삭제
			sql = "DELETE FROM member_detail WHERE mem_num=?";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, mem_num);
			pstmt2.executeUpdate();
			
			//모든 SQL문의 실행이 성공하면 커밋
			conn.commit();
			
		}catch(Exception e) {
			//SQL문이 하나라도 실패하면 롤백
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//북마크 등록
	/*
	public void insertBookMark(BookMarkVO bookmark)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
				
		try {
			conn = DBUtil.getConnection();
			sql = "INSERT INTO book_mark (mark_num,bk_num,mem_num) VALUES (book_mark_seq.nextval,?,?)";
			pstmt.setInt(1, bookmark.getMark_num());
			pstmt.setInt(2, bookmark.getBk_num());
			pstmt.setInt(3, bookmark.getMem_num());
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
		
	}
	*/
	
	//북마크 목록
	public List<BookMarkVO> getListBookMark(int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BookMarkVO> marklist = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			/*sql = "SELECT * FROM book_mark m JOIN book_list b ON m.bk_num=b.bk_num "
					+ "WHERE m.mem_num = ? ORDER BY b.bk_num ASC";*/
			sql = "SELECT * "
				+ "FROM book_mark bm JOIN member m USING(mem_num) JOIN book_list bl USING(bk_num) "
				+ "WHERE m.mem_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			rs = pstmt.executeQuery();
			marklist = new ArrayList<BookMarkVO>(); //ArrayList생성
			while(rs.next()) {
				BookMarkVO bookmark = new BookMarkVO();
				bookmark.setMark_num(rs.getInt("mark_num"));
				bookmark.setBk_num(rs.getInt("bk_num"));
				bookmark.setMem_num(rs.getInt("mem_num"));
				
				//책 정보 담기 위해 BookMarkVO 객체 생성
				BookVO book = new BookVO();
				book.setTitle(rs.getString("title"));
				book.setAuthor(rs.getString("author"));
				book.setTitle(rs.getString("title"));
				book.setReg_date(rs.getDate("reg_date"));
				
				//BookVO -> BookMarkVO 저장
				bookmark.setBookVO(book);
				
				marklist.add(bookmark);
				
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return marklist;
	}
}
