<!--
  It was hard to find an example online, but one was just enough!
  https://www.supermemo.com/en/archives1990-2015/beta/xml/xml-core
-->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs">

  <xsl:output encoding="us-ascii"/>

  <!-- Default to "full-text"; other choices are "shorthand" and "hybrid" -->
  <xsl:param name="card-format" select="'full-text'"/>

  <xsl:variable name="content-to-group" select="//div[@class eq 'passage-text']/div/div/*"/>

  <xsl:template match="/">
    <SuperMemoCollection>
      <!-- This was in the original example; it is apparently not needed
      <Count>1329</Count>
      -->
      <xsl:for-each-group group-starting-with="h3" select="$content-to-group">
        <xsl:if test="not(starts-with(., 'BOOK'))">
          <xsl:variable name="psalm-title" as="xs:string">
            <xsl:value-of>
              <xsl:apply-templates mode="pre-process" select="."/>
            </xsl:value-of>
          </xsl:variable>
          <xsl:variable name="full-text-content">
            <xsl:variable name="raw-content">
              <xsl:copy-of select="current-group()" copy-namespaces="no"/>
            </xsl:variable>
            <xsl:apply-templates mode="pre-process" select="$raw-content/node()"/>
          </xsl:variable>
          <xsl:variable name="shorthand-content">
            <xsl:apply-templates mode="shorthand" select="$full-text-content/node()"/>
          </xsl:variable>
          <SuperMemoElement>
            <!-- This was in the original example; it is apparently not needed
            <ID>78345</ID>
            -->
            <Content>
              <Question>
                <xsl:choose>
                  <xsl:when test="$card-format eq 'hybrid'">
                    <xsl:apply-templates mode="format-html" select="$shorthand-content"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="$psalm-title"/>
                  </xsl:otherwise>
                </xsl:choose>
              </Question>
              <Answer>
                <xsl:choose>
                  <xsl:when test="$card-format eq 'shorthand'">
                    <xsl:apply-templates mode="format-html" select="$shorthand-content"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:apply-templates mode="format-html" select="$full-text-content"/>
                  </xsl:otherwise>
                </xsl:choose>
              </Answer>
            </Content>
            <LearningData>
              <Interval>0</Interval>
              <Repetitions>0</Repetitions>
              <Lapses>0</Lapses>
            </LearningData>
            <!-- Original example had these elements & values:
            <LearningData>
              <Interval>323</Interval>
              <Repetitions>3</Repetitions>
              <Lapses>1</Lapses>
              <LastRepetition>23.11.2000</LastRepetition>
              <AFactor>1.456</AFactor>
              <UFactor>1.121</UFactor>
            </LearningData>
            -->
          </SuperMemoElement>
        </xsl:if>
      </xsl:for-each-group>
    </SuperMemoCollection>
  </xsl:template>

  <xsl:template mode="format-html" match="/">
    <xsl:text>&lt;div style="text-align: left; font-family: Times New Roman"></xsl:text>
    <xsl:value-of select="serialize(.)"/> <!-- Escape the HTML for use in Anki -->
    <xsl:text>&lt;/div></xsl:text>
  </xsl:template>

  <!-- Copy everything by default (in both passes) -->
  <xsl:template mode="pre-process shorthand" match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates mode="#current" select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Strip out footnotes and cross-references (both inline and at the bottom of each page) -->
  <xsl:template mode="pre-process" match="sup[not(@class eq 'versenum')]"/>
  <xsl:template mode="pre-process" match="div[@class eq 'footnotes']"/>
  <xsl:template mode="pre-process" match="div[contains(@class, 'crossrefs')]"/>

  <!--
    Replace every word with just its initial letter and remove the spaces between words
    (except when the space follows a punctuation mark)
  -->
  <xsl:template mode="shorthand" match="text()[not(ancestor::h3) and not(ancestor::h4) and not(ancestor::sup)]" priority="1">
    <xsl:variable name="words-reduced" as="xs:string">
      <xsl:value-of>
        <!-- Strip a leading space, e.g. the space before "King" here: The <span class="small-caps">LORD</span> is King... -->
        <xsl:analyze-string select="replace(., '^\s', '')" regex="\w+">
          <!-- Replace full words with their initial letter -->
          <xsl:matching-substring>
            <xsl:value-of select="substring(., 1, 1)"/>
          </xsl:matching-substring>
          <xsl:non-matching-substring>
            <xsl:value-of select="."/>
          </xsl:non-matching-substring>
        </xsl:analyze-string>
      </xsl:value-of>
    </xsl:variable>
    <!-- Strip each space that follows a letter -->
    <xsl:analyze-string select="$words-reduced" regex="\w ">
      <xsl:matching-substring>
        <xsl:value-of select="substring(., 1, 1)"/>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:value-of select="."/>
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </xsl:template>

</xsl:stylesheet>
