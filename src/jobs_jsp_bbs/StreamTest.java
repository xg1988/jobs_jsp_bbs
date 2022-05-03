package jobs_jsp_bbs;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;

class Person implements Serializable{
	String id;
	String name;
	
	transient String test; // 직렬화가 불가능할 경우에 추가 키워드 
	
	public Person(String id, String name) {
		super();
		this.id = id;
		this.name = name;
	}
	@Override
	public String toString() {
		return "Person [id=" + id + ", name=" + name + "]";
	}
}

/**
 * Stream test
 * @author joseong-ug
 *
 */
public class StreamTest {
	public static void main(String[] args) {
		
		try {
			FileOutputStream fos = new FileOutputStream("test.txt");
			ObjectOutputStream oos = new ObjectOutputStream(fos);
			
			oos.writeObject(new Person("test", "조성욱"));
			oos.writeObject(new Person("test2", "양지영"));
		} catch (Exception e) {
			System.out.println(e);
		}
		
		try {
			FileInputStream fis = new FileInputStream("test.txt");
			ObjectInputStream ois  = new ObjectInputStream(fis);
			
			Person ptest =  (Person)ois.readObject();
			Person ptest2 =  (Person)ois.readObject();
			
			System.out.println(ptest);
			System.out.println(ptest2);
		} catch (Exception e) {
			System.out.println(e);
		}
		
		
		
		
	}
}
