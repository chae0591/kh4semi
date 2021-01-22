package beans;

import java.sql.Date;

//게시글(BoardDto)에 댓글개수가 포함된 VO
public class TipBoardOpinionCountVO {

	private int board_no;
	private String board_writer;
	private String board_title;
	private String board_content;
	private Date regist_time;
	private int vote;
	private Date start_date;
	private Date end_date;
	private int opinion_count;
	

	public TipBoardOpinionCountVO() {
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


	public Date getStart_date() {
		return start_date;
	}


	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}


	public Date getEnd_date() {
		return end_date;
	}


	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}


	public int getOpinion_count() {
		return opinion_count;
	}


	public void setOpinion_count(int opinion_count) {
		this.opinion_count = opinion_count;
	}


	
	
	
}