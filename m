From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Subject: [PATCH] compile sparse with Intel C
Date: Wed, 20 Jun 2012 02:24:15 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1206200221060.7055@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from artax.karlin.mff.cuni.cz ([195.113.26.195]:52814 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab2FTAac (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 19 Jun 2012 20:30:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by artax.karlin.mff.cuni.cz (Postfix) with ESMTP id 066E5980A7
	for <linux-sparse@vger.kernel.org>; Wed, 20 Jun 2012 02:24:15 +0200 (CEST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi

This patch makes sparse compile with Intel C compiler.

Intel C complains that it cannot initialize flexible arrays (defined at 
the end of the structure with []).

Mikulas

--- dissect.h_	2012-06-20 01:31:19.000000000 +0200
+++ dissect.h	2012-06-20 02:19:42.000000000 +0200
@@ -2,6 +2,7 @@
 #define	DISSECT_H
 
 #include <stdio.h>
+#include <string.h>
 #include "parse.h"
 #include "expression.h"
 
@@ -32,8 +33,8 @@
 		char __[sizeof(s)];			\
 	} ident = {{					\
 		.len  = sizeof(s)-1,			\
-		.name = s,				\
 	}};						\
+	strcpy(ident.ident.name, s);			\
 	&ident.ident;					\
 })
 
