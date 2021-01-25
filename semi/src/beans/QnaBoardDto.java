package beans;

import java.sql.Date;

public class QnaBoardDto {
	private int board_no;
	private String board_writer;
	private String board_title;
	private String board_content;
	private Date regist_time;
	private int vote;
	private String member_nick;
	
	public QnaBoardDto() {
		super();
	}

	public int getBoard_no() {
		return board_no;
	}

	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}

	public String getBoard_writer() {
		return board_writer;
	}

	public void setBoard_writer(String board_writer) {
		this.board_writer = board_writer;
	}

	public String getBoard_title() {
		return board_title;
	}

	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}

	public String getBoard_content() {
		return board_content;
	}

	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}

	public Date getRegist_time() {
		return regist_time;
	}

	public void setRegist_time(Date regist_time) {
		this.regist_time = regist_time;
	}

	public int getVote() {
		return vote;
	}

	public void setVote(int vote) {
		this.vote = vote;
	}
	
	public String getMember_nick() {
		return member_nick;
	}


	public void setMember_nick(String member_nick) {
		this.member_nick = member_nick;
	}
	
}