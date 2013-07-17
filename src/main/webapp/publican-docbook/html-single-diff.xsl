<?xml version='1.0'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml"
                xmlns:exsl="http://exslt.org/common"
                version="1.0"
                exclude-result-prefixes="exsl">

    <xsl:import href="/pressgang-ccms-static/docbook/xhtml/docbook.xsl"/>
    <xsl:import href="/pressgang-ccms-static/docbook/xhtml/titlepage.xsl"/>
    <xsl:include href="defaults.xsl"/>
    <xsl:include href="xhtml-common.xsl"/>

    <xsl:output method="xml" encoding="UTF-8" indent="no" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" omit-xml-declaration="no" />

    <!--
        PRESSGANG - This is read by <xsl:template name="process.image"> in xhtml-common, and defines whether a placeholder image
        is displayed for all images, or if the original image should be displayed.
    -->
    <xsl:param name="placeholderImg" select="0"/>

    <xsl:param name="html.append"/>
    <xsl:param name="body.only">0</xsl:param>

    <!--
        PRESSGANG - Remove section labels
    -->
    <xsl:param name="section.autolabel.max.depth">0</xsl:param>

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

                        <script src="http://code.jquery.com/jquery-2.0.2.min.js"></script>
                        <script>
                            $(window).ready(function() {

                                var localUrl = window.location.protocol + "//" + window.location.hostname + ":" + window.location.port;
                                var parentLocation = matches == null ? localUrl : matches[1];

                                var imageTags = $('img');
                                for (var i = 0, imageTagsLength = imageTags.length; i &lt; imageTagsLength; ++i) {
                                    var imageTag = $(imageTags[i]);
                                    var fileref = imageTag.attr('src');
                                    if (fileref.substr(0,6) === 'images') {
                                        imageTag.attr('src', localUrl + '/pressgang-ccms/rest/1/image/get/raw/' + fileref.substr(7, fileref.length - 11));
                                    }
                                }

                                var parentDomainRegex = /parentDomain=(.*?)(&amp;|$)/;
                                var matches = parentDomainRegex.exec(window.location.search);

                                // post the rendered html back to the parent
                                window.parent.postMessage("{\"html\":\"" + $("html").html().replace(/\\/g,"\\\\").replace(/\t/g,"\\t").replace(/\n/g,"\\n").replace(/"/g,"\\\"") + "\",\"href\":\"" + document.location.href + "\"}", parentLocation);
                            });
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
