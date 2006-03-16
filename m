From: terra@gnome.org (Morten Welinder)
Subject: attribute sentinel
Date: Thu, 16 Mar 2006 14:26:50 -0500 (EST)
Message-ID: <20060316192650.3922CC000E2@dunnock.rentec.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from unicorn.rentec.com ([216.223.240.10]:47585 "EHLO
	unicorn.rentec.com") by vger.kernel.org with ESMTP id S932692AbWCPT1C
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 16 Mar 2006 14:27:02 -0500
Received: from wren.rentec.com (wren [192.5.35.106])
	by unicorn.rentec.com (8.13.1/8.12.1) with ESMTP id k2GJR2XO018889
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Thu, 16 Mar 2006 14:27:02 -0500 (EST)
Received: from dunnock.rentec.com (dunnock.rentec.com [172.26.132.207])
	by wren.rentec.com (8.13.1/8.12.1) with ESMTP id k2GJQogk028320
	for <linux-sparse@vger.kernel.org>; Thu, 16 Mar 2006 14:26:50 -0500 (EST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


I have no idea what __sentinel__ does, but this patch shuts up
sparse.


Morten


Signed-off-by: Morten Welinder <terra@gnome.org>


diff --git a/ident-list.h b/ident-list.h
index f5812de..3051e56 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -53,6 +53,7 @@ IDENT(noinline);
 IDENT(deprecated);
 IDENT(__const); IDENT(__const__); IDENT(noreturn);
 IDENT(__noreturn__); IDENT(regparm); IDENT(weak); IDENT(__weak__);
+IDENT(__sentinel__); IDENT(sentinel);
 IDENT(alias); IDENT(pure); IDENT(always_inline);
 IDENT(syscall_linkage); IDENT(visibility);
 IDENT(bitwise); IDENT(__bitwise__);
diff --git a/parse.c b/parse.c
index d871afd..4339657 100644
--- a/parse.c
+++ b/parse.c
@@ -517,6 +517,9 @@ static const char * handle_attribute(str
 	if (attribute == &noreturn_ident ||
 	    attribute == &__noreturn___ident)
 		return NULL;
+	if (attribute == &sentinel_ident ||
+	    attribute == &__sentinel___ident)
+		return NULL;
 	if (attribute == &regparm_ident)
 		return NULL;
 	if (attribute == &weak_ident ||
