<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml">

    <xsl:output encoding="UTF-8" method="xml" omit-xml-declaration="yes" media-type="text/html"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" indent="no"/>

    <xsl:param name="origin_website"/>

    <xsl:template match="/document">
        <html xmlns="http://www.w3.org/1999/xhtml">
          <head>
            <title>Sign in with OpenID</title>
            <style type="text/css">
                @import "default.css";
            </style>
          </head>
        
          <body>
            <p>The website '<xsl:value-of select="$origin_website"/>' wants to verify your PAUSE identity.</p>
            <form method="post" action="signin" id="login_form">
              <div>
                <label for="username"><abbr title="Perl Authors Upload Server">PAUSE</abbr> ID:</label>
                <input name="username" id="username" type="text" />
                <label for="password">Password:</label>
        
                <input name="password" id="password" type="password" />
                <input type="submit" />
              </div>
            </form>
          </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
