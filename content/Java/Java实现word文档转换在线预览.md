---
title: word转图片
date: 2016-6-23 13:27:05
collection: JavaSE
---

[TOC]

这几天做项目碰到一个需求，需要实现word的在线预览功能，在网上百度了好多资料。发现很多的实现方式都是通过 openoffice + swftools + flexpaper来完成。 基本思路是先用openoffice将word转成pdf，然后再用swftools将pdf转成swf，最后通过flexpaper将swf展示在页面上。

刚开始我也是想通过这种方法来实现在线预览的功能。后面一边在网上找资料一边实现，最后到了用flexpaper将swf展示在页面的阶段，尝试了一下发现flexpaper的效果不怎么好（有卡顿，不流畅）。

于是寻思着另辟蹊径，后面有了第二种实现方案，将word转化成的pdf直接在浏览器上展示，因为现在的谷歌已经内置了pdf的展示插件，只需要要页面中引用embed标签既可。可是这样做的话会出现一个问题。pdf打开的时候默认不是铺满屏幕的，而需要用户再去点击一下自适应宽度按钮才行，而且百度了很久也没有找到应该如何控制默认缩放，所以第二种方案也被我放弃了。

最后我是通过将pdf文件在线转成图片，然后再将图片展示在页面上来解决的。当然这样做的话，效率会很低，解决方法是将word文档先进行预处理。

#### word转成pdf
首先需要安装openoffice，这个东东会提供我们word转pdf的服务。这个自行在网上百度找一个4点多的版本下载就可以了，大概100多m左右。
安装完成后，需要启动openoffice的服务。
``` java
//进入安装openoffice的progra路径
cd C:\Program Files (x86)\OpenOffice 4\program  
//启动服务
soffice -headless -accept="socket,host=127.0.0.1,port=8100;urp;" -nofirststartwizard
```
当然，如果每次开机都要去启动服务那简直就是太麻烦了，所以可以将这个服务注册为一开机就启动，由于这个服务开启的话，消耗的内存感人，所以我没有把他注册成开机启动。

word转换成pdf的代码实现：
``` java
/**
* office转pdf
* @param sourceFile pdf的文件目录
* @param destFile   pdf输出的目标目录
* @return
*/
public static int office2PDF(String sourceFile, String destFile) {
  try {
    File inputFile = new File(sourceFile);
    if (!inputFile.exists()) {
      return -1;// 找不到源文件, 则返回-1
    }

    // 如果目标路径不存在, 则新建该路径
    File outputFile = new File(destFile);
    if (!outputFile.getParentFile().exists()) {
      outputFile.getParentFile().mkdirs();
    }

    // connect to an OpenOffice.org instance running on port 8100
    OpenOfficeConnection connection = new SocketOpenOfficeConnection("127.0.0.1", 8100);
    connection.connect();

    // convert
    DocumentConverter converter = new OpenOfficeDocumentConverter(
    connection);
    converter.convert(inputFile, outputFile);

    // close the connection
    connection.disconnect();

    System.out.println("word转pdf成功");
    return 0;
  } catch (ConnectException e) {
  	e.printStackTrace();
  } catch (IOException e) {
    e.printStackTrace();
  }
  return 1;
}
```

---

#### pdf转图片
然后就是要处理将pdf转换成图片了。这里需要下载一个PDFRenderer.jar 的jar包

以下是PDF转图片的核心代码。
``` java
	public static void changePdfToImg(String pafPath, String imgPath) {
		try {
			File file = new File(pafPath);
			RandomAccessFile raf = new RandomAccessFile(file, "r");
			FileChannel channel = raf.getChannel();
			MappedByteBuffer buf = channel.map(FileChannel.MapMode.READ_ONLY,
					0, channel.size());
			PDFFile pdffile = new PDFFile(buf);
			for (int i = 1; i <= pdffile.getNumPages(); i++) {
				PDFPage page = pdffile.getPage(i);
				Rectangle rect = new Rectangle(0, 0, ((int) page.getBBox()
						.getWidth()), ((int) page.getBBox().getHeight()));
				int n = 6;
				/** 图片清晰度（n>0且n<7）【pdf放大参数】 */
				Image img = page.getImage(rect.width * n, rect.height * n,
						rect, /** 放大pdf到n倍，创建图片。 */
						null, /** null for the ImageObserver */
						true, /** fill background with white */
						true /** block until drawing is done */
				);
				BufferedImage tag = new BufferedImage(rect.width * n,
						rect.height * n, BufferedImage.TYPE_INT_RGB);
				tag.getGraphics().drawImage(img, 0, 0, rect.width * n,
						rect.height * n, null);
				FileOutputStream out = new FileOutputStream(imgPath + "\\"+ i
						+ ".jpg");
				/** 输出到文件流 */
				JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
				JPEGEncodeParam param2 = encoder.getDefaultJPEGEncodeParam(tag);
				param2.setQuality(1f, true);
				/** 1f~0.01f是提高生成的图片质量 */
				encoder.setJPEGEncodeParam(param2);
				encoder.encode(tag);
				/** JPEG编码 */
				out.close();
			}
			channel.close();
			raf.close();
			unmap(buf);
			/** 如果要在转图片之后删除pdf，就必须要这个关闭流和清空缓冲的方法 */
			System.out.println("生成图片成功");
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@SuppressWarnings("unchecked")
	private static void unmap(final Object buffer) {
		AccessController.doPrivileged(new PrivilegedAction() {
			public Object run() {
				try {
					Method getCleanerMethod = buffer.getClass().getMethod(
							"cleaner", new Class[0]);
					getCleanerMethod.setAccessible(true);
					sun.misc.Cleaner cleaner = (sun.misc.Cleaner) getCleanerMethod
							.invoke(buffer, new Object[0]);
					cleaner.clean();
				} catch (Exception e) {
					e.printStackTrace();
				}
				return null;
			}
		});
	}
```
将pdf转换成图片之后，程序再去将图片读出来然后展示在网页上就可以了。