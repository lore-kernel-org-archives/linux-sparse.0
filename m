From: Frederic Crozat <fcrozat@suse.com>
Subject: Patch: add __builtin_stpcpy and __sync_synchronize to builtin
 functions
Date: Thu, 15 Mar 2012 15:15:43 +0100
Message-ID: <1331820943.2720.5.camel@par-r81vxc7.par.novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-YC7Er+jOG8IuPYDixjhK"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:50065 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233Ab2COOPp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 15 Mar 2012 10:15:45 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


--=-YC7Er+jOG8IuPYDixjhK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

while working on integrating sparse checks in systemd, I noticed some
builtin functions need to be added to sparse list. See attached patch
for the fix.

I've also noted patch from Pekka Enberg
(http://www.spinics.net/lists/linux-sparse/msg02520.html ) is still
needed when running sparse on x86-64. It would be nice to merge it in
git.

-- 
Frederic Crozat <fcrozat@suse.com>
SUSE


--=-YC7Er+jOG8IuPYDixjhK
Content-Disposition: inline;
	filename*0=0001-Add-__builtin_stpcpy-and-__sync_synchronize-to-decla.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-Add-__builtin_stpcpy-and-__sync_synchronize-to-decla.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

From 1fc7c049236924a7ce1ccd0488d5f38b99763055 Mon Sep 17 00:00:00 2001
From: Frederic Crozat <fcrozat@suse.com>
Date: Wed, 29 Feb 2012 15:50:14 +0100
Subject: [PATCH] Add __builtin_stpcpy and __sync_synchronize to
 declare_builtin_functions

---
 lib.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/lib.c b/lib.c
index 396e9f1..be0fa8f 100644
--- a/lib.c
+++ b/lib.c
@@ -682,6 +682,7 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern __SIZE_TYPE__ __builtin_strspn(const char *, const char *);\n");
 	add_pre_buffer("extern __SIZE_TYPE__ __builtin_strcspn(const char *, const char *);\n");
 	add_pre_buffer("extern char * __builtin_strpbrk(const char *, const char *);\n");
+	add_pre_buffer("extern char* __builtin_stpcpy(const char *, const char*);\n");
 	add_pre_buffer("extern __SIZE_TYPE__ __builtin_strlen(const char *);\n");
 
 	/* And bitwise operations.. */
@@ -714,6 +715,7 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern long __builtin_alpha_cmpbge(long, long);\n");
 	add_pre_buffer("extern long __builtin_labs(long);\n");
 	add_pre_buffer("extern double __builtin_fabs(double);\n");
+	add_pre_buffer("extern void __sync_synchronize();\n");
 
 	/* Add Blackfin-specific stuff */
 	add_pre_buffer(
-- 
1.7.7


--=-YC7Er+jOG8IuPYDixjhK--

