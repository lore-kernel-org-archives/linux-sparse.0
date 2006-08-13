From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Recognize and ignore __alias__ and __visibility__
Date: Sun, 13 Aug 2006 01:51:58 -0400
Message-ID: <20060813055158.28706.93407.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:39866
	"EHLO smtp.roinet.com") by vger.kernel.org with ESMTP
	id S1750701AbWHMFwB (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 13 Aug 2006 01:52:01 -0400
Received: from dv.roinet.com (192.168.1.21 [192.168.1.21])
    by smtp.roinet.com with SMTP;
    for linux-sparse@vger.kernel.org;
    Sun, 13 Aug 2006 01:55:57 -0400 (EDT)
    (envelope-from proski@gnu.org)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

From: Pavel Roskin <proski@gnu.org>

They are equivalent to "alias" and "visibility" except that gcc won't
complain about them in ANSI programs.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 ident-list.h |    4 ++--
 parse.c      |    4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

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
index c536ec2..1c9aab8 100644
--- a/parse.c
+++ b/parse.c
@@ -530,6 +530,8 @@ static const char * handle_attribute(str
 		return NULL;
 	if (attribute == &alias_ident)
 		return NULL;
+	if (attribute == &__alias___ident)
+		return NULL;
 	if (attribute == &pure_ident ||
 	    attribute == &__pure___ident)
 		return NULL;
@@ -539,6 +541,8 @@ static const char * handle_attribute(str
 		return NULL;
 	if (attribute == &visibility_ident)
 		return NULL;
+	if (attribute == &__visibility___ident)
+		return NULL;
 	if (attribute == &deprecated_ident ||
 	    attribute == &__deprecated___ident)
 		return NULL;
