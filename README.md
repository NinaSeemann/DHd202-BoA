# DHd2020-BoA
This repository contains the set of scripts that will take TEI encoded XML files and process them into a PDF.
Furthermore, it contains the files used to prepare the Book of Abstracts of the DHd 2020 conference. Please be aware that the texts are under the standard copyright of the authors, if not stated explicitly otherwise.

Changes to previous year
===============================================

lib/tei2pdf/xsl-fo-producer.xsl
---------------------------
* lines 146-149: new template calling the 'DejaVu Sans' font for correct display of Ogham
* line 228: decreased spacing before "publisher_info"-template
* line 261: decreased spacing before  "intro_head_large_center"-template
* line 306: decreased spacing before "partner_logo_container_intro"-template
* line 369: changed color for "head"
* line 431: changed color for "section_head"
* line 557: template "smallcaps" does not produce smallcaps; changed font to "monospace_font" to produce highlighting
* lines 618-619: includes spacing before and after "code"-template
* lines 625-629: new template "table_container" with spacing
* lines 631-638: new template "table_head"
* lines 647-648: removed spacing in "table"-template
* lines 671/679: changed year in "page_header"-template
* lines 709-711: new match for 'Doctoral Consortium'-template in TOC Headers
* line 838: changed path to front cover
* line 946: new if-clause for 'Doctoral Consortium' in Table of Contents
* lines 950-959: re-used the (commented) code block for reviewers to change the layout of Panels in TOC (no author(s), hence title, dots, and page number on one line)
* lines 1471-1546: generation of title page and content for 'Doctoral Consortium'
* (lines 1666-1691: empty pages for printing of book)
* line 1697: changed path to back cover
* lines 1847-1849: new when-clause for "head" of a table
* lines 1918/1921/1925/1927/1946/1950: removed unnecessary spaces before and after URLs and emails in "ref"- and "ptr"-template  (especially annoying when URL/email in brackets)
* lines 2068-2070: new when-clause in "hi"-template calling Ogham
* lines 2100/2112: changed path to graphic in "figure_container_intro"- and "partner_logos"-template
* lines 2165-2168: changed "code"-template from 'inline' to 'block'
* lines 2176-2179: modified match for "table"-template (now calling "table_container"-template)
