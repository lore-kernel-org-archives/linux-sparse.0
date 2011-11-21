From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH 3/3] sparse, llvm: Make llc output to stdout in sparsec
Date: Mon, 21 Nov 2011 22:03:30 +0200
Message-ID: <1321905810-2253-3-git-send-email-penberg@kernel.org>
References: <1321905810-2253-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54471 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055Ab1KUUDm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 21 Nov 2011 15:03:42 -0500
Received: by mail-bw0-f46.google.com with SMTP id 11so7013808bke.19
        for <linux-sparse@vger.kernel.org>; Mon, 21 Nov 2011 12:03:41 -0800 (PST)
In-Reply-To: <1321905810-2253-1-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

This patch fixes a bug in 'sparsec' that made it generate empty object files.

Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 sparsec |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sparsec b/sparsec
index 33e1a2b..9c90b30 100755
--- a/sparsec
+++ b/sparsec
@@ -34,7 +34,7 @@ TMPFILE=`mktemp -t tmp.XXXXXX`".o"
 
 $DIRNAME/sparse-llvm $SPARSEOPTS > $TMPLLVM
 
-llc $TMPLLVM | as -o $TMPFILE
+llc -o - $TMPLLVM | as -o $TMPFILE
 
 if [ $NEED_LINK -eq 1 ]; then
 	if [ -z $OUTFILE ]; then
-- 
1.7.6.4

