::!/bin\bash

:: locate saxon jar file
set sax_jar=lib\SaxonHE9-8-0-7J\saxon9he.jar

:: locate FOP base directory
set fop_lib=lib\fop-2.1

:: for hyphenation, you will also need 'offo hyphenation binaries': 
:: simply place 'fop-hyph.jar' in 'fop\lib' 

:: additional options for FOP processing (sen to the java process)
::   -d64: optimization for 64 bit processor
::   -Xmx3000m: sets the maximum available memory allocation pool to 3000 MB
:: Note: It's safe to leave this variable blank
set fop_opts="-d64 -Xmx3000m"

:: these variables shouldn't need to be changed, they are relative to fop_lib
set fop_bin=%fop_lib%\fop
set fop_conf=%fop_lib%\conf\fop.xconf

set fo_obj=output\pdf.fo
set pdf_obj=output\pdf.pdf

set tei_xsl=lib\tei2pdf\TEIcorpus_producer.xsl
set xslfo_xsl=lib\tei2pdf\xsl-fo-producer.xsl
set init_xml=lib\tei2pdf\empty.xml
set final_xml=output\Book_Corpus.xml

:: further options that may be useful

:: cleanup transitional files when finshed
set cleanup=false