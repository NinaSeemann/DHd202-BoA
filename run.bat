::!/bin/bash

call config/config.bat

java -jar %sax_jar% %init_xml% %tei_xsl% > %final_xml%
java -jar %sax_jar% %final_xml% %xslfo_xsl% > %fo_obj%
set FOP_OPTS=%fop_opts% %fop_bin% -c %fop_conf% %fo_obj% %pdf_obj%

IF %cleanup%==true (
DEL %fo_obj%
DEL %final_xml%
)

%fop_bin% -c %fop_conf% %fo_obj% %pdf_obj%

cmd /k

