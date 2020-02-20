# DHd2020-BoA
This repository contains the set of scripts that will take TEI encoded XML files and process them into a PDF.
Furthermore, it contains the files used to prepare the Book of Abstracts of the DHd 2020 conference. Please be aware that the texts are under the standard copyright of the authors, if not stated explicitly otherwise.

#### Code was tested on MacBook Pro running MacOs 10.14.6 with 16GB of memory.

# How to BoA
For an informal overview see
[Karin Dalziels introduction](https://github.com/karindalziel/TEI-to-PDF).

Step 0: Check out or download files from github
===============================================

You'll get a folder with a name like "DHd2020-BoA". All other instructions refer to this folder as the starting place.

Step 1: Set up your environment
=======================

1a: Download Saxon
-------------------------

Download Saxon HE from
[The Saxon Sourceforge page](http://saxon.sourceforge.net/) and place
it in the "lib" folder or change the code below to match your download. Code has been tested with Saxon 9.5 HE. 

1b: Download and configure the FO processor
----------------------------------------

Download the FOP Binary files from
[The Apache FOP Page](http://xmlgraphics.apache.org/fop/) and place inside the "lib" folder, or change the commands below to reference where you keep the FO processor. Scripts have been tested with FOP 2.1.

#### Change the conf file

The conf file can be found in /lib/fop/conf/fop.xconf

You can use <auto-detect/> to register all fonts on your system. If
some fonts are not in the standard directory, you can tell FOP where
to look for them. Place the following inside the &lt;renderer
mime="application/pdf">/&lt;fonts> tags:

	<directory recursive="true">/Non-Standard_Path/Fonts</directory>
		<auto-detect/>

For further information on font embedding, visit the
[ Apache FOP Font page](https://xmlgraphics.apache.org/fop/2.0/fonts.html).

#### Increase memory

If you are creating a large book, you may need to increase the memory
FOP uses to process the book. This is done in the config.sh in the
config folder. Currently, java_exec_args is set to 'd64 -Xmx3000m'
which was sufficient to generate this years BoA (283 pages). 

1c: File structure
--------------------

There have been some minor changes over the years. The final file structure should look like this:

* config (folder)
  * config.sh
* input (folder)
  * images (folder)
  * xml (folder)
* lib (folder)
  * fop (folder)
  * saxon (folder)
  * tei2pdf (folder)
	* empty.xml
	* TEIcorpus_producer.xsl
	* xsl-fo-producer.xsl
* output (folder)
* README.md
* run.sh

1d: Prepare your Files
--------------------------

#### TEI

All the TEI must be P5 and categorized into 'Workshop', 'Panel',
'Vortrag', 'Doctoral Consortium' or 'Posterpräsentation' so the book
can generate the proper headings. The categorization is already present when
files are downloaded from the ConfTool. For example code see [Karin Dalziels README](https://github.com/karindalziel/TEI-to-PDF).

Make sure the xml:id matches the document name and is unique
(otherwise, the code will crash when one author is listed as author in
multiple papers). 
E.G. ab-002.xml must have an xml:id of ab-002:

	<TEI xml:id="ab-002" xmlns="http://www.tei-c.org/ns/1.0">

TEI Filenames are not used for categorization, the code uses the category in the header file (as above) to place the content in the correct category.

Furthermore, make sure that every <graphic> is included in a <figure>
element. Otherwise, those images will not be displayed in the final
pdf (and there is no warning!!!).

#### Images

Change all file paths to local.

E.G. "path/to/image/image001.jpg" should be simply "image001.jpg"

1e: Set your configuration options
-----------------------------------------

In the lib/tei2pdf/xsl-fo-producer.xsl file are several options for
setting up how you would like your book to look.
These options haven't changed over time, so see [Karin Dalziels explanation](https://github.com/karindalziel/TEI-to-PDF).

Step 2: Run Files
============

Command line instructions are below. 

1: Place all files and images in input/xml and input/images, respectively

1b. Open a terminal and change directory (cd command) to the root folder. 

2: Create the Book_Corpus.xml corpus file with the TEIcorpus_producer.xsl XSL with this command:

	 java -jar lib//SaxonHE9-8-0-7J/saxon9he.jar lib/tei2pdf/empty.xml
     > output/Book_Corpus.xml

This uses the saxon engine to transform all the XML in the final_xml folder into a TEI Corpus file called "Book_Corpus.xml"

3: Create the .fo file

	java -jar lib/SaxonHE9-8-0-7J/saxon9he.jar output/Book_Corpus.xml
	lib/tei2pdf/xsl-fo-producer.xsl > output/pdf.fo

This creates a file called pdf.fo. Any errors (missing images, etc) will be exported to the screen. You may get a notice about missing fonts - this means either your font name is incorrect, or you have not set FOP to use your system fonts in the conf file (detailed above).

4: Create PDF

	lib/fop-2.1/fop -d64 -Xmx3000m -c lib/fop-2.1/conf/fop.xconf output/pdf.fo output/pdf.pdf

If you get an out of memory error, see section on configuring FOP above.

You will likely get a bunch of font errors, but these may or may not matter. Check your final file to make sure all characters display correctly. 

This will create the final PDF. 

#### Script

For your convenience, there is a script to run everything at once, you can run this by typing ./run.sh. If this fails, running each step individually will give better error reporting.


Changes in code compared to previous year
===============================================

lib/tei2pdf/xsl-fo-producer.xsl
---------------------------
* lines 146-149: new template "ogham" calling the 'DejaVu Sans' font for correct display of Ogham
* line 228: decreased spacing before "publisher_info"-template
* line 261: decreased spacing before  "intro_head_large_center"-template
* line 306: decreased spacing before "partner_logo_container_intro"-template
* line 369: changed color for "head"
* line 431: changed color for "section_head"
* line 557: template "smallcaps" not producing smallcaps; changed font to "monospace_font" to highlight
* lines 618-619: included spacing before and after "code"-template
* lines 625-629: new template "table_container" with spacing
* lines 631-638: new template "table_head"
* lines 647-648: removed spacing in "table"-template
* lines 671/679: changed year in "page_header"-template
* lines 709-711: new match for 'Doctoral Consortium'-template in TOC Headers
* line 838: changed path to front cover image
* line 946: new if-clause for 'Doctoral Consortium' in Table of Contents
* lines 950-959: re-used the (commented) code block for reviewers to change the layout of Panels in TOC (Panels have no authors anymore, hence title, dots, and page number on one line)
* lines 1471-1546: generation of title page and content for 'Doctoral Consortium'
* (lines 1666-1691: necessary empty pages for printing of book)
* line 1697: changed path to back cover image
* lines 1847-1849: new when-clause for "head" of a table
* lines 1918/1921/1925/1927/1946/1950: removed unnecessary spaces before and after URLs and emails in "ref"- and "ptr"-template  (especially annoying when URL/email in brackets)
* lines 2068-2070: new when-clause in "hi"-template calling "ogham"-template
* lines 2100/2112: changed path to graphic in "figure_container_intro"- and "partner_logos"-template
* lines 2165-2168: changed "code"-template from 'inline' to 'block'
* lines 2176-2179: modified match for "table"-template (now calling "table_container"-template)

lib/fop-2.1/conf/fop.xconf
-----------------------

