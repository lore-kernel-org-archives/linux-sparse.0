From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] sparse/parse.c: ignore hotpatch attribute
Date: Thu, 30 Apr 2015 13:47:45 +0200
Message-ID: <20150430114745.GB4199@osiris>
References: <1430218119-58354-1-git-send-email-heiko.carstens@de.ibm.com>
 <CANeU7QkyX+cPEpBm_rW1JUX64NAZ6YM0KR17r1rfPeDpYC1uGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109]:37903 "EHLO
	e06smtp13.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbbD3Lrx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 30 Apr 2015 07:47:53 -0400
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-sparse@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Thu, 30 Apr 2015 12:47:51 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id B19A217D8063
	for <linux-sparse@vger.kernel.org>; Thu, 30 Apr 2015 12:48:30 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com [9.149.37.213])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t3UBlk8e62455912
	for <linux-sparse@vger.kernel.org>; Thu, 30 Apr 2015 11:47:48 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t3UBlkRE014300
	for <linux-sparse@vger.kernel.org>; Thu, 30 Apr 2015 05:47:46 -0600
Content-Disposition: inline
In-Reply-To: <CANeU7QkyX+cPEpBm_rW1JUX64NAZ6YM0KR17r1rfPeDpYC1uGA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Apr 29, 2015 at 04:22:13PM -0700, Christopher Li wrote:
> That patch looks fine.
> 
> Can you add some test case for the hot patch as well?
> It need to cover the case you run into.
> 
> Preferably cover each of the variation of hot patch.
> 
> It will be useful when we parse these attributes properly.
> 
> Chris

Something like below? I have to admit that I have not much of a clue
of what I'm doing ;)

From 03da0b28318100cc9a1389c81920654b29405d73 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Thu, 30 Apr 2015 12:53:28 +0200
Subject: [PATCH] sparse/parse.c: ignore hotpatch attribute

gcc knows about a new "hotpatch" attribute which sparse can safely ignore,
since it modifies only which code will be generated just like the
"no_instrument_function" attribute.

The gcc hotpatch feature patch:
https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=11762b8363737591bfb9c66093bc2edf289b917f

Currently the Linux kernel makes use of this attribute:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=61f552141c9c0e88b3fdc7046265781ffd8fa68a

Without this patch sparse will emit warnings like
"error: attribute 'hotpatch': unknown attribute"

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 ident-list.h               | 1 +
 parse.c                    | 2 ++
 validation/attr-hotpatch.c | 7 +++++++
 3 files changed, 10 insertions(+)
 create mode 100644 validation/attr-hotpatch.c

diff --git a/ident-list.h b/ident-list.h
index b65b667da720..1849ea613b47 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -81,6 +81,7 @@ IDENT(constructor); IDENT(__constructor__);
 IDENT(destructor); IDENT(__destructor__);
 IDENT(cold); IDENT(__cold__);
 IDENT(hot); IDENT(__hot__);
+IDENT(hotpatch); IDENT(__hotpatch__);
 IDENT(cdecl); IDENT(__cdecl__);
 IDENT(stdcall); IDENT(__stdcall__);
 IDENT(fastcall); IDENT(__fastcall__);
diff --git a/parse.c b/parse.c
index b43d6835528b..8afae73d5325 100644
--- a/parse.c
+++ b/parse.c
@@ -540,6 +540,8 @@ const char *ignored_attributes[] = {
 	"__gnu_inline__",
 	"hot",
 	"__hot__",
+	"hotpatch",
+	"__hotpatch__",
         "leaf",
         "__leaf__",
 	"l1_text",
diff --git a/validation/attr-hotpatch.c b/validation/attr-hotpatch.c
new file mode 100644
index 000000000000..205169389956
--- /dev/null
+++ b/validation/attr-hotpatch.c
@@ -0,0 +1,7 @@
+static void __attribute__((hotpatch(0,3))) bar(void)
+{
+}
+
+/*
+ * check-name: attribute hotpatch
+ */
-- 
2.1.4

