<?xml version='1.0'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="1.0">

    <xsl:import href="html-single-common.xsl"/>

    <xsl:output method="xml" encoding="UTF-8" indent="no" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" omit-xml-declaration="no" />

    <!-- PRESSGANG enable loading images and posting the transformed html to the parent window -->
    <xsl:param name="postToParent">true</xsl:param>
    <xsl:param name="initImages">true</xsl:param>
</xsl:stylesheet>
