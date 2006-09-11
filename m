From: Josh Triplett <josht@us.ibm.com>
Subject: [PATCH RESEND] Recognize and ignore __alias__ and __visibility__
Date: Mon, 11 Sep 2006 14:09:36 -0700
Message-ID: <1158008976.4373.47.camel@josh-work.beaverton.ibm.com>
References: <20060813055158.28706.93407.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:29380 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965027AbWIKVJR
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 11 Sep 2006 17:09:17 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8BL9GqF004684
	for <linux-sparse@vger.kernel.org>; Mon, 11 Sep 2006 17:09:16 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8BL9GiL235836
	for <linux-sparse@vger.kernel.org>; Mon, 11 Sep 2006 15:09:16 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8BL9GwM019735
	for <linux-sparse@vger.kernel.org>; Mon, 11 Sep 2006 15:09:16 -0600
In-Reply-To: <20060813055158.28706.93407.stgit@dv.roinet.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pavel Roskin <proski@gnu.org>, Linus Torvalds <torvalds@osdl.org>

Sparse currently parses and ignores the alias and visibility attributes,
but not the variants __alias__ and __visibility__, which GCC permits
even in ANSI C to allow for use in headers.  Add support for these
variants.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
Signed-off-by: Pavel Roskin <proski@gnu.org>
---
Original patch by Pavel Roskin; modified version with consolidated if
statements by me, with signoff from Pavel.

 parse.c      |    6 ++++--
 ident-list.h |    4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/ident-list.h b/ident-list.h
index 95bb96a..ecdce6d 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -56,8 +56,8 @@ IDENT(__const); IDENT(__const__); IDENT(
 IDENT(__noreturn__); IDENT(regparm); IDENT(weak); IDENT(__weak__);
 IDENT(__no_instrument_function__); IDENT(no_instrument_function);
 IDENT(__sentinel__); IDENT(sentinel);
-IDENT(alias); IDENT(pure); IDENT(always_inline);
-IDENT(syscall_linkage); IDENT(visibility);
+IDENT(alias); IDENT(__alias__); IDENT(pure); IDENT(always_inline);
+IDENT(syscall_linkage); IDENT(visibility); IDENT(__visibility__);
 IDENT(bitwise); IDENT(__bitwise__);
 IDENT(model); IDENT(__model__);
 IDENT(__format_arg__);
diff --git a/parse.c b/parse.c
index c536ec2..6857541 100644
--- a/parse.c
+++ b/parse.c
@@ -528,7 +528,8 @@ static const char * handle_attribute(str
 	if (attribute == &weak_ident ||
 	    attribute == &__weak___ident)
 		return NULL;
-	if (attribute == &alias_ident)
+	if (attribute == &alias_ident ||
+	    attribute == &__alias___ident)
 		return NULL;
 	if (attribute == &pure_ident ||
 	    attribute == &__pure___ident)
@@ -537,7 +538,8 @@ static const char * handle_attribute(str
 		return NULL;
 	if (attribute == &syscall_linkage_ident)
 		return NULL;
-	if (attribute == &visibility_ident)
+	if (attribute == &visibility_ident ||
+	    attribute == &__visibility___ident)
 		return NULL;
 	if (attribute == &deprecated_ident ||
 	    attribute == &__deprecated___ident)
