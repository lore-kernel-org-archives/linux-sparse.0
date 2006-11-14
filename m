From: Nicolas Kaiser <nikai@nikai.net>
Subject: [TRIVIAL][PATCH] double inclusions
Date: Tue, 14 Nov 2006 10:00:26 +0100
Message-ID: <20061114100026.1f00f29b@lucky.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ensim03.ffm.m2soft.com ([195.38.20.12]:61324 "EHLO
	ensim03.ffm.m2soft.com") by vger.kernel.org with ESMTP
	id S933244AbWKNJCg (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 14 Nov 2006 04:02:36 -0500
Received: from lucky.kitzblitz ([85.127.135.138])
	(authenticated bits=0)
	by ensim03.ffm.m2soft.com (8.12.11.20060308/8.12.10) with ESMTP id kAE92VZ6017560
	for <linux-sparse@vger.kernel.org>; Tue, 14 Nov 2006 10:02:33 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Remove two double inclusions.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---

 expression.c |    1 -
 symbol.c     |    1 -
 2 files changed, 2 deletions(-)

diff -uprN sparse-0.1.orig/expression.c sparse-0.1/expression.c
--- sparse-0.1.orig/expression.c	2006-11-06 20:26:11.000000000 +0100
+++ sparse-0.1/expression.c	2006-11-14 09:34:22.000000000 +0100
@@ -20,7 +20,6 @@
 
 #include "lib.h"
 #include "allocate.h"
-#include "allocate.h"
 #include "token.h"
 #include "parse.h"
 #include "symbol.h"
diff -uprN sparse-0.1.orig/symbol.c sparse-0.1/symbol.c
--- sparse-0.1.orig/symbol.c	2006-11-06 20:26:11.000000000 +0100
+++ sparse-0.1/symbol.c	2006-11-14 09:35:16.000000000 +0100
@@ -8,7 +8,6 @@
  */
 #include <stdlib.h>
 #include <stdio.h>
-#include <stdlib.h>
 #include <string.h>
 
 #include "lib.h"
