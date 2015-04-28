From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH] sparse/parse.c: ignore hotpatch attribute
Date: Tue, 28 Apr 2015 12:48:39 +0200
Message-ID: <1430218119-58354-1-git-send-email-heiko.carstens@de.ibm.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107]:48186 "EHLO
	e06smtp11.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933028AbbD1Ksq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 28 Apr 2015 06:48:46 -0400
Received: from /spool/local
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-sparse@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Tue, 28 Apr 2015 11:48:44 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id D6F521B08067
	for <linux-sparse@vger.kernel.org>; Tue, 28 Apr 2015 11:49:21 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com [9.149.37.213])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t3SAmgOD7995736
	for <linux-sparse@vger.kernel.org>; Tue, 28 Apr 2015 10:48:42 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t3SAmfAQ022382
	for <linux-sparse@vger.kernel.org>; Tue, 28 Apr 2015 04:48:42 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>

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
 parse.c | 2 ++
 1 file changed, 2 insertions(+)

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
-- 
2.1.4

