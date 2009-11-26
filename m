From: Michael Buesch <mb@bu3sch.de>
Subject: [PATCH] sparse: Add more ignored attributes
Date: Thu, 26 Nov 2009 12:03:26 +0100
Message-ID: <200911261203.27745.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from bu3sch.de ([62.75.166.246]:52117 "EHLO vs166246.vserver.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944AbZKZLET (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 26 Nov 2009 06:04:19 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@kernel.org>, linux-sparse@vger.kernel.org

This adds more ignored gcc-style attributes.

externally_visible is a standard gcc attribute.
signal is an AVR8 attribute used to define interrupt service routines.

Ignore these attributes, as they are currently not useful for sparse checking.

Signed-off-by: Michael Buesch <mb@bu3sch.de>

---

Index: sparse-dev/parse.c
===================================================================
--- sparse-dev.orig/parse.c	2009-11-26 12:02:13.000000000 +0100
+++ sparse-dev/parse.c	2009-11-26 12:02:18.000000000 +0100
@@ -505,6 +505,8 @@ const char *ignored_attributes[] = {
 	"__dllexport__",
 	"dllimport",
 	"__dllimport__",
+	"externally_visible",
+	"__externally_visible__",
 	"fastcall",
 	"__fastcall__",
 	"format",
@@ -537,6 +539,8 @@ const char *ignored_attributes[] = {
 	"__section__",
 	"sentinel",
 	"__sentinel__",
+	"signal",
+	"__signal__",
 	"stdcall",
 	"__stdcall__",
 	"syscall_linkage",


-- 
Greetings, Michael.
