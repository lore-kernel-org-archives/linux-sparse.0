From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH] sparse: Add 'artifical' to ignore attributes
Date: Sun, 19 Jun 2011 19:20:51 +0300
Message-ID: <1308500451-22637-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:57758 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564Ab1FSQaE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 19 Jun 2011 12:30:04 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org, Pekka Enberg <penberg@kernel.org>

This patch adds the 'artifical' GCC attribute to list of ignore attributes.
It's an attribute that's used by glibc which causes the following bogus sparse
warnings when using it for userspace projects:

  /usr/include/bits/stdlib.h:37:1: error: attribute '__artificial__': unknown attribute
  /usr/include/bits/stdlib.h:64:1: error: attribute '__artificial__': unknown attribute

Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 ident-list.h |    1 +
 parse.c      |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/ident-list.h b/ident-list.h
index b94aece..b12d172 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -87,6 +87,7 @@ IDENT(fastcall); IDENT(__fastcall__);
 IDENT(dllimport); IDENT(__dllimport__);
 IDENT(dllexport); IDENT(__dllexport__);
 IDENT(restrict); IDENT(__restrict);
+IDENT(artificial); IDENT(__artificial__);
 
 /* Preprocessor idents.  Direct use of __IDENT avoids mentioning the keyword
  * itself by name, preventing these tokens from expanding when compiling
diff --git a/parse.c b/parse.c
index 537055f..bcee794 100644
--- a/parse.c
+++ b/parse.c
@@ -486,6 +486,8 @@ const char *ignored_attributes[] = {
 	"__alloc_size__",
 	"always_inline",
 	"__always_inline__",
+	"artificial",
+	"__artificial__",
 	"bounded",
 	"__bounded__",
 	"cdecl",
-- 
1.7.4.1

