<?xml version='1.0'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="1.0">

    <xsl:import href="html-single-common.xsl"/>

    <xsl:output method="xml" encoding="UTF-8" indent="no" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" omit-xml-declaration="no" />

    <!--
        PRESSGANG - This is read by <xsl:template name="process.image"> in xhtml-common, and defines whether a placeholder image
        is displayed for all images, or if the original image should be displayed.
    -->
    <xsl:param name="placeholderImg" select="1"/>
    <xsl:param name="initListeners">true</xsl:param>
</xsl:stylesheet>
