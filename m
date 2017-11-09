From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] Makefile: use locally built sparse in the selfcheck target
Date: Thu, 9 Nov 2017 16:30:48 +0000
Message-ID: <10d6a020-ebe8-6a31-e4cb-ff67c1a1009c@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout04.plus.net ([212.159.14.19]:48355 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750909AbdKIQav (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 11:30:51 -0500
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Chris,

I was recently setting up a new system and didn't have sparse
installed. The 'make selfcheck' target failed ...

ATB,
Ramsay Jones

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d034176..d1a303e 100644
--- a/Makefile
+++ b/Makefile
@@ -18,7 +18,7 @@ LDFLAGS += -g
 LD = gcc
 AR = ar
 PKG_CONFIG = pkg-config
-CHECKER = ./cgcc -no-compile
+CHECKER = CHECK=./sparse ./cgcc -no-compile
 CHECKER_FLAGS =
 
 ALL_CFLAGS = $(CFLAGS) $(BASIC_CFLAGS)
-- 
2.15.0
