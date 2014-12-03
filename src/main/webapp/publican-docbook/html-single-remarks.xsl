<?xml version='1.0'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="1.0">

    <xsl:import href="/pressgang-ccms-static/publican-docbook/html-single-common.xsl"/>

    <xsl:output method="xml" encoding="UTF-8" indent="no" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" omit-xml-declaration="no" />

    <!--
        PRESSGANG - enable remarks
    -->
    <xsl:param name="show.comments">1</xsl:param>

    <!-- PRESSGANG enable loading images and the scroll listener -->
    <xsl:param name="initListeners">true</xsl:param>
    <xsl:param name="initImages">true</xsl:param>
</xsl:stylesheet>
