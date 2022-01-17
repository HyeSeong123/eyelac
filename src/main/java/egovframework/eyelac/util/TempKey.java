package egovframework.eyelac.util;

import java.util.Random;

public class TempKey {
	private int size;
	
	public String getKey(int size) {
		this.size = size;
		return init();
	}
	
	public String init() {
		Random random = new Random();
		StringBuffer buffer = new StringBuffer();
		int num = 0;
		
		while(buffer.length() < size) {
			num = random.nextInt(10);
			buffer.append(num);
		}
		return buffer.toString();
	}
}
