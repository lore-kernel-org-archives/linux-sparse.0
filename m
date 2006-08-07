From: Josh Triplett <josht@us.ibm.com>
Subject: [PATCH] Use $(BINDIR) consistently in Makefile rather than
	$(PREFIX)/bin
Date: Mon, 07 Aug 2006 09:44:44 -0700
Message-ID: <1154969084.14202.5.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:10161 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932121AbWHGQoq
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 7 Aug 2006 12:44:46 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k77GijmV009101
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Mon, 7 Aug 2006 12:44:45 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k77GiiY3268980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Mon, 7 Aug 2006 10:44:44 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k77GiiIB008206
	for <linux-sparse@vger.kernel.org>; Mon, 7 Aug 2006 10:44:44 -0600
Received: from dyn9047018143.beaverton.ibm.com (dyn9047018143.beaverton.ibm.com [9.47.18.143])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k77GiiQU008184
	for <linux-sparse@vger.kernel.org>; Mon, 7 Aug 2006 10:44:44 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

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
