<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml">

    <xsl:output encoding="UTF-8" method="xml" omit-xml-declaration="yes" media-type="text/html"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" indent="no"/>

    <xsl:template match="/document">
        <html xmlns="http://www.w3.org/1999/xhtml">
          <head>
            <title>Error</title>
            <style type="text/css">
                @import "default.css";
            </style>
          </head>
        
          <body>
            <p>An error occured.</p>
            <xsl:if test="error_message != ''">
              <p id="error_message">
                <xsl:value-of select="error_message"/>
              </p>
            </xsl:if>
          </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
