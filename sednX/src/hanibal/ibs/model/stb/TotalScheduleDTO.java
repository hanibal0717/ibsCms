package hanibal.ibs.model.stb;

public class TotalScheduleDTO {
	int id;
	String name;
	String start;
	String end;
	String source_type;
	String caption;
	String caption_size;
	String caption_speed;
	String caption_text_color;
	String caption_bg_color;
	String live_stream_url;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	public String getSource_type() {
		return source_type;
	}
	public void setSource_type(String source_type) {
		this.source_type = source_type;
	}
	public String getCaption() {
		return caption;
	}
	public void setCaption(String caption) {
		this.caption = caption;
	}
	public String getCaption_size() {
		return caption_size;
	}
	public void setCaption_size(String caption_size) {
		this.caption_size = caption_size;
	}
	public String getCaption_speed() {
		return caption_speed;
	}
	public void setCaption_speed(String caption_speed) {
		this.caption_speed = caption_speed;
	}
	public String getCaption_text_color() {
		return caption_text_color;
	}
	public void setCaption_text_color(String caption_text_color) {
		this.caption_text_color = caption_text_color;
	}
	public String getCaption_bg_color() {
		return caption_bg_color;
	}
	public void setCaption_bg_color(String caption_bg_color) {
		this.caption_bg_color = caption_bg_color;
	}
	public String getLive_stream_url() {
		return live_stream_url;
	}
	public void setLive_stream_url(String live_stream_url) {
		this.live_stream_url = live_stream_url;
	}
	
}
