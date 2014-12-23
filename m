From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH] sparse: Use memmove in sort.c
Date: Tue, 23 Dec 2014 14:38:53 +0100
Message-ID: <1419341933-17244-1-git-send-email-rv@rasmusvillemoes.dk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:55638 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186AbaLWNjE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Dec 2014 08:39:04 -0500
Received: by mail-lb0-f181.google.com with SMTP id l4so5242096lbv.40
        for <linux-sparse@vger.kernel.org>; Tue, 23 Dec 2014 05:39:02 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>
Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>

Using valgrind on the example ctags program I get

==16863== Source and destination overlap in memcpy(0x7ff000100, 0x7ff000108, 192)
==16863==    at 0x4C2A690: memcpy (mc_replace_strmem.c:838)
==16863==    by 0x412D86: merge_block_seqs (sort.c:207)
==16863==    by 0x41303C: sort_list (sort.c:275)
==16863==    by 0x401225: main (ctags.c:224)

Fix it by using memmove instead of memcpy.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
I'm not familiar with the code; maybe memcpy should be ok and there's
a bug elsewhere. Using memmove shouldn't hurt, though, except for a
small performance hit.

 sort.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sort.c b/sort.c
index afd7184..603f06c 100644
--- a/sort.c
+++ b/sort.c
@@ -97,9 +97,9 @@ static void verify_seq_sorted (struct ptr_list *l, int n,
   do {								\
 	int nr = (b)->nr;					\
 	assert (nbuf >= nr);					\
-	memcpy ((b)->list, buffer, nr * sizeof (void *));	\
+	memmove ((b)->list, buffer, nr * sizeof (void *));	\
 	nbuf -= nr;						\
-	memcpy (buffer, buffer + nr, nbuf * sizeof (void *));	\
+	memmove (buffer, buffer + nr, nbuf * sizeof (void *));	\
   } while (0)
 
 #define DUMP_TO(b)						\
-- 
2.1.3

