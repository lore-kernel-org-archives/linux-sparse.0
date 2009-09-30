From: Michael Stefaniuc <mstefaniuc@gmail.com>
Subject: [PATCH] Ignore the ms_abi/sysv_abi attributes.
Date: Wed, 30 Sep 2009 22:18:50 +0200
Message-ID: <20090930201850.GA32461@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59089 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001AbZI3USr (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 30 Sep 2009 16:18:47 -0400
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8UKIpKc000479
	for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2009 16:18:51 -0400
Received: from brasov.str.redhat.com (brasov.str.redhat.com [10.32.0.1])
	by int-mx03.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8UKIoHm031797
	for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2009 16:18:51 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This is needed for getting a meaningful sparse run on a Wine 64-bit
compile. Else the basic Win32 headers will produce tons of
error: attribute 'ms_abi': unknown attribute
which end in
error: too many errors.

The sysv_abi attribute was just added for symmetry.

Signed-off-by: Michael Stefaniuc <mstefaniuc@gmail.com>
---
Resend for the chrisl tree.


 parse.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/parse.c b/parse.c
index 34fa562..fa3b45e 100644
--- a/parse.c
+++ b/parse.c
@@ -508,6 +508,8 @@ const char *ignored_attributes[] = {
 	"__malloc__",
 	"model",
 	"__model__",
+	"ms_abi",
+	"__ms_abi__",
 	"no_instrument_function",
 	"__no_instrument_function__",
 	"noinline",
@@ -530,6 +532,8 @@ const char *ignored_attributes[] = {
 	"__stdcall__",
 	"syscall_linkage",
 	"__syscall_linkage__",
+	"sysv_abi",
+	"__sysv_abi__",
 	"unused",
 	"__unused__",
 	"used",
-- 
1.6.5.rc2
