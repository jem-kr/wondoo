package utility;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class Utility {
	public static File getUploadedFileInfo(MultipartFile multi, String realPath) {
		System.out.println(multi);
		System.out.println(realPath);
		String pattern = "yyyyMMddhhmmss" ;
		SimpleDateFormat sdf = new SimpleDateFormat(pattern) ;
		String now = sdf.format( new Date() ) ;
		
		String somefile = multi.getOriginalFilename() ;
		int dot = somefile.indexOf(".") ;
		String filename = somefile.substring(0, dot) ;
		String fileext = somefile.substring(dot) ;
		String newfile = filename + now + fileext ; 
		
		String myfile = realPath + File.separator + newfile  ;
		
		return new File( myfile ); 
	}
}