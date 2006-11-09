From: =?iso-8859-1?Q?Lo=EFc?= Minier <lool+kernel@via.ecp.fr>
Subject: Debian package; trivial fixes
Date: Thu, 9 Nov 2006 16:19:12 +0100
Message-ID: <20061109151912.GC8508@bee.dooz.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="St7VIuEGZ6dlpu13"
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx0.bpl-group.org ([195.115.71.69]:4363 "EHLO mx0.bpl-group.org")
	by vger.kernel.org with ESMTP id S1423986AbWKIPTO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 9 Nov 2006 10:19:14 -0500
Received: from bee.dooz.org (lan-34.int.bpl-group.org [192.168.16.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lminier.people.bpl-group.org", Issuer "BPL Group People Certification Authority" (verified OK))
	by mx0.bpl-group.org (Postfix) with ESMTP id C6704C4BE
	for <linux-sparse@vger.kernel.org>; Thu,  9 Nov 2006 16:19:12 +0100 (CET)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

        Hi,

 I've prepared and uploaded a Debian package for sparse 0.1:
    <http://people.dooz.org/~lool/debian/sparse/0.1-1/sid-pbuilder/>

 FYI, It is currently targetted at Debian "non-free" due to the choice
 of venue clause in the license.  I think the patent clause is slightly
 problematic but might be acceptable for Debian "main".


 Please find attached a trivial fix for .gitignore where "check" wasn't
 renamed to "sparse".

 It would also be more convenient to create BINDIR automatically on make
 install.

   Bye,
-- 
Loïc Minier <lool@dooz.org>

--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rename-sparse-in-dot-gitignore.patch"

diff --git a/.gitignore b/.gitignore
index 3e12ce7..665ad03 100644
--- a/.gitignore
+++ b/.gitignore
@@ -11,9 +11,9 @@ pre-process.h
 test-lexing
 test-parsing
 obfuscate
-check
 compile
 graph
+sparse
 test-dissect
 test-linearize
 example

--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="create-bindir.patch"

diff --git a/Makefile b/Makefile
index 2dcd514..920fe67 100644
--- a/Makefile
+++ b/Makefile
@@ -40,18 +40,12 @@ LIBS=$(LIB_FILE)
 
 all: $(PROGRAMS)
 
-install: $(INST_PROGRAMS) bin-dir
+install: $(INST_PROGRAMS)
+	install -d $(BINDIR)
 	for f in $(INST_PROGRAMS); do \
 		install -v $$f $(BINDIR)/$$f || exit 1; \
 	done
 
-bin-dir:
-	@if ! test -d $(BINDIR); then \
-		echo "No '$(BINDIR)' directory to install in"; \
-		echo "Please create it and add it to your PATH"; \
-		exit 1; \
-	fi
-
 .PHONY: bin-dir
 
 test-lexing: test-lexing.o $(LIBS)

--St7VIuEGZ6dlpu13--
