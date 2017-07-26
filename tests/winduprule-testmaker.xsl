<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://windup.jboss.org/schema/jboss-ruleset" xmlns="http://windup.jboss.org/schema/jboss-ruleset">

    <!-- use a command for this testmaker generator  -->
    <!--  http://xslttest.appspot.com/ working fine -->
    <!-- xsltproc has got some issues to match templates - ?namespace issues? -->
    
    <!-- set the output -->
    <xsl:output method="xml" indent="yes" encoding="UTF-8" omit-xml-declaration="no"/>

    <!-- root template -->
    <xsl:template match="/">
        <ruletest xmlns="http://windup.jboss.org/schema/jboss-ruleset" id="hsearch" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://windup.jboss.org/schema/jboss-ruleset http://windup.jboss.org/schema/jboss-ruleset/windup-jboss-ruleset.xsd">
            <testDataPath>data</testDataPath>
            <ruleset>
                <rules>
                    <xsl:apply-templates />
                </rules>
            </ruleset>
        </ruletest>
    </xsl:template>

    <xsl:template match="metadata"/><!-- there is no operation over metadata -->
    <xsl:template match="javaclass"/><!-- there is no operation over javaclass -->
    
    <!-- create test rule from the rule -->
    <xsl:template match="rule">
        <xsl:variable name="ruleid" select="./@id" />
        <xsl:element name="rule">
            <xsl:attribute name="id"><xsl:value-of select="$ruleid" />-test</xsl:attribute>
            <when>
                <not>
                    <xsl:apply-templates />
                </not>
                <xsl:apply-templates select="(hint | classification | lineitem)"/>
            </when>
            <perform>
                <fail>
                    <xsl:attribute name="message"><xsl:value-of select="$ruleid" /> hint not found!</xsl:attribute>
                </fail>
            </perform>
        </xsl:element>
    </xsl:template>

    <xsl:template match="hint">
        <hint-exists>
            <xsl:attribute name="message"><xsl:value-of select="./message" /></xsl:attribute>
        </hint-exists>
    </xsl:template>
    
    <xsl:template match="classification">
        <classification-exists>
            <xsl:attribute name="classification">
                <xsl:value-of select="./@title" />
            </xsl:attribute>
        </classification-exists>
    </xsl:template>

    <xsl:template match="lineitem">
        <lineitem-exists message="Generated">
            <xsl:attribute name="message">
                <xsl:value-of select="./@message" />
            </xsl:attribute>
        </lineitem-exists>
    </xsl:template>

</xsl:stylesheet> 