From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 52/52] llvm: fix creation of sparsec's tmp files
Date: Mon, 27 Mar 2017 23:24:16 +0200
Message-ID: <20170327212416.18536-53-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35419 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751962AbdC0V1c (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:27:32 -0400
Received: by mail-wr0-f195.google.com with SMTP id p52so14122999wrc.2
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:27:20 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

It seems the intention was to create the tmp files with
the suffixes but the files are create without the suffixes
(while the filename that is used later is with the suffixes).

In all case the non-suffixed file that is created by the
mktemp command is never removed and after a while these
files begin to pile-up. Better to remove them.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparsec | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sparsec b/sparsec
index 9dc96c956..e421776e2 100755
--- a/sparsec
+++ b/sparsec
@@ -29,8 +29,8 @@ while [ $# -gt 0 ]; do
 	shift
 done
 
-TMPLLVM=`mktemp -t tmp.XXXXXX`".llvm"
-TMPFILE=`mktemp -t tmp.XXXXXX`".o"
+TMPLLVM=`mktemp -t tmp.XXXXXX.llvm`
+TMPFILE=`mktemp -t tmp.XXXXXX.o`
 
 $DIRNAME/sparse-llvm $SPARSEOPTS > $TMPLLVM
 
-- 
2.12.0

