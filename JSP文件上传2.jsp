<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.io.*,java.util.*,org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.*"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>上传处理页面</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String uploadFileName = ""; //上传的文件名
	String fieldName = "";  //表单字段元素的name属性值
	//请求信息中的内容是否是multipart类型
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	//上传文件的存储路径（服务器文件系统上的绝对文件路径）
	String uploadFilePath = request.getSession().getServletContext().getRealPath("upload/" );
	//创建临时文件目录路径
	File tempPatchFile=new File("d:\\temp\\buffer\\");
	if(!tempPatchFile.exists())  //判断文件或目录是否存在
		tempPatchFile.mkdirs();   //创建指定的目录，包括所有必需但不存在的父目录
	if (isMultipart) {
		DiskFileItemFactory factory=new DiskFileItemFactory();
		//设置缓冲区大小4kb
		factory.setSizeThreshold(4096);   
		//设置上传文件用到临时文件存放路径
		factory.setRepository(tempPatchFile);   
		ServletFileUpload upload = new ServletFileUpload(factory);
		//设置单个文件的最大限制
		upload.setSizeMax(1024*30);   
		try {
			//解析form表单中所有文件
			List<FileItem> items = upload.parseRequest(request);
			Iterator<FileItem> iter = items.iterator();
			while (iter.hasNext()) {   //依次处理每个文件
				FileItem item = (FileItem) iter.next();
				if (!item.isFormField()){  //文件表单字段
					String fileName = item.getName();
					//通过Arrays类的asList()方法创建固定长度的集合
					List<String> filType=Arrays.asList("gif","bmp","jpg");
					String ext=fileName.substring(fileName.lastIndexOf(".")+1);
					if(!filType.contains(ext))  //判断文件类型是否在允许范围内
							out.print("上传失败，文件类型只能是gif、bmp、jpg");
					else{
						if (fileName != null && !fileName.equals("")) {
							File fullFile = new File(item.getName());
							File saveFile = new File(uploadFilePath, fullFile.getName());
							item.write(saveFile);
							uploadFileName = fullFile.getName();
							out.print("上传成功后的文件名是："+uploadFileName+
							"，文件大小是："+item.getSize()+"bytes!");
	
						}		
					}
				}
			}
		}catch(FileUploadBase.SizeLimitExceededException ex){
			out.print("上传失败，文件太大，单个文件的最大限制是："+upload.getSizeMax()+"bytes!");	
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
%>
</body>
</html>