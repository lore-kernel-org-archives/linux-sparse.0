From: Ethan Jackson <ethan@nicira.com>
Subject: [PATCH] sparse: Add 'leaf' to ignored attributes.
Date: Tue, 17 Jan 2012 14:47:11 -0800
Message-ID: <1326840431-27368-1-git-send-email-ethan@nicira.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64743 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241Ab2AQWsD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 17 Jan 2012 17:48:03 -0500
Received: by ggdk6 with SMTP id k6so3497776ggd.19
        for <linux-sparse@vger.kernel.org>; Tue, 17 Jan 2012 14:48:02 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Ethan Jackson <ethan@nicira.com>

This patch adds the 'leaf' GCC attribute to the list of ignored
attributes.  Glibc uses this attribute causing the following
warnings in userspace projects:

  /usr/include/stdlib.h:514:26: error: attribute '__leaf__': unknown attribute

Signed-off-by: Ethan Jackson <ethan@nicira.com>
---
 ident-list.h |    2 ++
 parse.c      |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/ident-list.h b/ident-list.h
index b12d172..35ac6bd 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -88,6 +88,8 @@ IDENT(dllimport); IDENT(__dllimport__);
 IDENT(dllexport); IDENT(__dllexport__);
 IDENT(restrict); IDENT(__restrict);
 IDENT(artificial); IDENT(__artificial__);
+IDENT(leaf); IDENT(__leaf__);
+
 
 /* Preprocessor idents.  Direct use of __IDENT avoids mentioning the keyword
  * itself by name, preventing these tokens from expanding when compiling
diff --git a/parse.c b/parse.c
index bd42180..f8ade3e 100644
--- a/parse.c
+++ b/parse.c
@@ -519,6 +519,8 @@ const char *ignored_attributes[] = {
 	"__format_arg__",
 	"hot",
 	"__hot__",
+        "leaf",
+        "__leaf__",
 	"l1_text",
 	"__l1_text__",
 	"l1_data",
-- 
1.7.8.3

