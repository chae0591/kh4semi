package beans;

import java.sql.Date;

public class TipVoteDto {
	private int vote_no;
	private int board_no;
	private int member_no;
	
	public TipVoteDto() {
		super();
	}


	public int getVote_no() {
		return vote_no;
	}


	public void setVote_no(int vote_no) {
		this.vote_no = vote_no;
	}


	public int getBoard_no() {
		return board_no;
	}


	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}


	public int getMember_no() {
		return member_no;
	}


	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	
}
