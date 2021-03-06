<?xml version='1.0'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml"
                xmlns:exsl="http://exslt.org/common"
                version="1.0"
                exclude-result-prefixes="exsl">

    <xsl:import href="/pressgang-ccms-static/docbook/xhtml/docbook.xsl"/>
    <xsl:import href="/pressgang-ccms-static/docbook/xhtml/titlepage.xsl"/>
    <xsl:include href="defaults.xsl"/>
    <xsl:include href="xhtml-common.xsl"/>

    <xsl:param name="show.comments">0</xsl:param>

    <xsl:param name="html.append"/>
    <xsl:param name="body.only">0</xsl:param>

    <!-- PRESSGANG variables -->
    <xsl:param name="postToParent">false</xsl:param>
    <xsl:param name="initImages">false</xsl:param>
    <xsl:param name="initListeners">false</xsl:param>

    <!--
        PRESSGANG - This is read by <xsl:template name="process.image"> in xhtml-common, and defines whether a placeholder image
        is displayed for all images, or if the original image should be displayed.
    -->
    <xsl:param name="placeholderImg" select="0"/>

    <!--
        PRESSGANG - Remove section and chapter labels
    -->
    <xsl:param name="section.autolabel.max.depth">0</xsl:param>
    <xsl:param name="chapter.autolabel">0</xsl:param>

    <!--
     PRESSGANG - Remove table, figure, example and equation labels
 -->
    <xsl:param name="local.l10n.xml" select="document('')"/>
    <l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
        <l:l10n language="en">
            <l:context name="title">
                <l:template name="table" text="%t"/>
                <l:template name="figure" text="%t"/>
                <l:template name="example" text="%t"/>
                <l:template name="equation" text="%t"/>
                <l:template name="procedure" text="%t"/>
            </l:context>
            <l:context name="xref-number-and-title">
                <l:template name="table" text="%t"/>
                <l:template name="figure" text="%t"/>
                <l:template name="example" text="%t"/>
                <l:template name="equation" text="%t"/>
                <l:template name="procedure" text="%t"/>
            </l:context>
        </l:l10n>
    </l:i18n>

    <xsl:template match="table" mode="label.markup"/>
    <xsl:template match="figure" mode="label.markup"/>
    <xsl:template match="example" mode="label.markup"/>
    <xsl:template match="equation" mode="label.markup"/>
    <xsl:template match="procedure" mode="label.markup"/>


    <!--
    From: xhtml/docbook.xsl
    Reason: add TOC div for web site
    Version:
    -->
    <xsl:template match="*" mode="process.root">
        <xsl:variable name="doc" select="self::*"/>

        <xsl:call-template name="user.preroot"/>
        <xsl:call-template name="root.messages"/>

        <xsl:choose>
            <xsl:when test="$body.only != 0">
                <xsl:apply-templates select="."/>
            </xsl:when>
            <xsl:otherwise>
                <html>
                    <head>
                        <script type="text/javascript" src="/pressgang-ccms-static/javascript/jquery/jquery-2.0.2.min.js">
                            <xsl:text> </xsl:text>
                        </script>
                        <script type="text/javascript" src="/pressgang-ccms-static/javascript/functions.js">
                            <xsl:text> </xsl:text>
                        </script>
                        <script type="text/javascript">
                            var postToParent = <xsl:value-of select="$postToParent"/>;
                            var includeImages = <xsl:value-of select="$initImages"/>;
                            var listeners = <xsl:value-of select="$initListeners"/>;

                            init(postToParent, includeImages, listeners);
                        </script>

                        <xsl:call-template name="system.head.content">
                            <xsl:with-param name="node" select="$doc"/>
                        </xsl:call-template>
                        <xsl:call-template name="head.content">
                            <xsl:with-param name="node" select="$doc"/>
                        </xsl:call-template>
                        <xsl:call-template name="user.head.content">
                            <xsl:with-param name="node" select="$doc"/>
                        </xsl:call-template>
                    </head>
                    <body>
                        <xsl:call-template name="body.attributes"/>
                        <xsl:call-template name="user.header.content">
                            <xsl:with-param name="node" select="$doc"/>
                        </xsl:call-template>
                        <xsl:if test="$embedtoc != 0">
                            <div id="navigation"></div>
                            <div id="floatingtoc" class="hidden"></div>
                        </xsl:if>
                        <!-- PRESSGANG - Remove header images -->
                        <!--<xsl:if test="$embedtoc = 0 or $web.type = ''">
                        <p xmlns="http://www.w3.org/1999/xhtml">
                          <xsl:attribute name="id">
                             <xsl:text>title</xsl:text>
                          </xsl:attribute>
                          <a class="left">
                            <xsl:attribute name="href">
                                <xsl:value-of select="$prod.url"/>
                            </xsl:attribute>
                        <img alt="Product Site">
                          <xsl:attribute name="src">
                              <xsl:value-of select="$admon.graphics.path"/><xsl:text>/image_left.png</xsl:text>
                          </xsl:attribute>
                        </img>
                          </a>
                          <a class="right">
                            <xsl:attribute name="href">
                              <xsl:value-of select="$doc.url"/>
                            </xsl:attribute>
                        <img alt="Documentation Site">
                          <xsl:attribute name="src">
                              <xsl:value-of select="$admon.graphics.path"/><xsl:text>/image_right.png</xsl:text>
                          </xsl:attribute>
                        </img>
                          </a>
                        </p>
                        </xsl:if>   -->
                        <xsl:if test="$embedtoc != 0 and $web.type = ''">
                            <ul class="docnav" xmlns="http://www.w3.org/1999/xhtml">
                                <li class="home"><xsl:value-of select="$clean_title"/></li>
                            </ul>
                        </xsl:if>
                        <xsl:apply-templates select="."/>
                        <xsl:call-template name="user.footer.content">
                            <xsl:with-param name="node" select="$doc"/>
                        </xsl:call-template>
                    </body>
                </html>
                <xsl:value-of select="$html.append"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>