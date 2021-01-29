package beans;

public class QnaTmpFileDto {
	private int file_no;
	private String upload_name;
	private String save_name;
	private Long file_size;
	private String file_type;
	private int board_no;
	public QnaTmpFileDto() {
		super();
	}
	public int getFile_no() {
		return file_no;
	}
	public void setFile_no(int file_no) {
		this.file_no = file_no;
	}
	public String getUpload_name() {
		return upload_name;
	}
	public void setUpload_name(String upload_name) {
		this.upload_name = upload_name;
	}
	public String getSave_name() {
		return save_name;
	}
	public void setSave_name(String save_name) {
		this.save_name = save_name;
	}
	public Long getFile_size() {
		return file_size;
	}
	public void setFile_size(Long file_size) {
		this.file_size = file_size;
	}
	public String getFile_type() {
		return file_type;
	}
	public void setFile_type(String file_type) {
		this.file_type = file_type;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	
}
