From: terra@gnome.org (Morten Welinder)
Subject: [PATCH] Attribute "sentinel"
Date: Tue, 28 Mar 2006 15:07:14 -0500 (EST)
Message-ID: <20060328200714.D9B03C000E2@dunnock.rentec.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from centaur.rentec.com ([216.223.240.8]:65475 "EHLO
	centaur.rentec.com") by vger.kernel.org with ESMTP id S932125AbWC1UH1
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 28 Mar 2006 15:07:27 -0500
Received: from ram.rentec.com (ram [192.5.35.66])
	by centaur.rentec.com (8.13.6/8.12.1) with ESMTP id k2SK7QSA002192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2006 15:07:26 -0500 (EST)
Received: from dunnock.rentec.com (dunnock.rentec.com [172.26.132.207])
	by ram.rentec.com (8.13.1/8.12.1) with ESMTP id k2SK7E9M029175
	for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2006 15:07:15 -0500 (EST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


[This is a resend.]

This makes sparse ignore the "sentinel" attribute.




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
