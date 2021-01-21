package beans;

import java.sql.Date;


public class TipOpinionDto {
	private int opinion_no;
	private String opinion_text;
	private Date regist_time;
	private int board_no;
	private String opinion_writer;

	
	public TipOpinionDto() {
		super();
	}


	public int getOpinion_no() {
		return opinion_no;
	}


	public void setOpinion_no(int opinion_no) {
		this.opinion_no = opinion_no;
	}


	public String getOpinion_text() {
		return opinion_text;
	}


	public void setOpinion_text(String opinion_text) {
		this.opinion_text = opinion_text;
	}


	public Date getRegist_time() {
		return regist_time;
	}


	public void setRegist_time(Date regist_time) {
		this.regist_time = regist_time;
	}


	public int getBoard_no() {
		return board_no;
	}


	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}


	public String getOpinion_writer() {
		return opinion_writer;
	}


	public void setOpinion_writer(String opinion_writer) {
		this.opinion_writer = opinion_writer;
	}
	
}
