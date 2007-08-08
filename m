From: Kovarththanan Rajaratnam <krj@rajaratnam.dk>
Subject: [PATCH] libxml compile fix on Cygwin
Date: Wed, 08 Aug 2007 22:34:39 +0200
Message-ID: <f9d9d1$m7o$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010405000209000009060906"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:47783 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754362AbXHHUkL (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 8 Aug 2007 16:40:11 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IIsK2-0004IY-2j
	for linux-sparse@vger.kernel.org; Wed, 08 Aug 2007 22:40:02 +0200
Received: from 0x5551d1e2.adsl.cybercity.dk ([85.81.209.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-sparse@vger.kernel.org>; Wed, 08 Aug 2007 22:40:02 +0200
Received: from krj by 0x5551d1e2.adsl.cybercity.dk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-sparse@vger.kernel.org>; Wed, 08 Aug 2007 22:40:02 +0200
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This is a multi-part message in MIME format.
--------------010405000209000009060906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I needed to re-arrange the libxml-2.0 library order to make sparse 
compile on Cygwin. Patch attached.

Signed-off-by: Kovarththanan Rajaratnam <krj@rajaratnam.dk>


--------------010405000209000009060906
Content-Type: text/x-patch;
 name="libxml_cygwin_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libxml_cygwin_fix.patch"

diff --git a/Makefile b/Makefile
index 1e06794..f07290e 100644
--- a/Makefile
+++ b/Makefile
@@ -124,7 +124,7 @@ ctags: ctags.o $(LIBS)
 	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
 
 c2xml: c2xml.o $(LIBS)
-	$(QUIET_LINK)$(CC) $(LDFLAGS) `pkg-config --libs libxml-2.0` -o $@ $< $(LIBS)
+	$(QUIET_LINK)$(CC) $(LDFLAGS)  -o $@ $< $(LIBS) `pkg-config --libs libxml-2.0`
 
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(AR) rcs $@ $(LIB_OBJS)

--------------010405000209000009060906--
