From: Josh Triplett <josht@us.ibm.com>
Subject: [PATCH RESEND] Use $(BINDIR) consistently in Makefile rather than
	$(PREFIX)/bin
Date: Tue, 29 Aug 2006 17:41:46 -0700
Message-ID: <1156898507.5203.7.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:61672 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751468AbWH3Alk
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 29 Aug 2006 20:41:40 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7U0fel9022306
	for <linux-sparse@vger.kernel.org>; Tue, 29 Aug 2006 20:41:40 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k7U0fePP338512
	for <linux-sparse@vger.kernel.org>; Tue, 29 Aug 2006 18:41:40 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k7U0fdKw008148
	for <linux-sparse@vger.kernel.org>; Tue, 29 Aug 2006 18:41:40 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>

The Makefile has variables for both PREFIX (default $(HOME)) and BINDIR
(default $(PREFIX)/bin); however, it then uses $(PREFIX)/bin in several other
places, making it difficult to install to an alternate BINDIR.  Fix this by
using $(BINDIR) consistently throughout the Makefile.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 378ee72..6755e07 100644
--- a/Makefile
+++ b/Makefile
@@ -45,11 +45,11 @@ #
 #		"The better to keep you on your toes, my dear".
 #
 install: check $(SLIB_FILE) bin-dir
-	if test $< -nt $(PREFIX)/bin/sparse ; then install -v $< $(BINDIR)/sparse ; install -v $(SLIB_FILE) $(BINDIR) ; fi
+	if test $< -nt $(BINDIR)/sparse ; then install -v $< $(BINDIR)/sparse ; install -v $(SLIB_FILE) $(BINDIR) ; fi
 
 bin-dir:
-	@if ! test -d $(PREFIX)/bin; then \
-		echo "No '$(PREFIX)/bin' directory to install in"; \
+	@if ! test -d $(BINDIR); then \
+		echo "No '$(BINDIR)' directory to install in"; \
 		echo "Please create it and add it to your PATH"; \
 		exit 1; \
 	fi
-- 
1.4.1.1
