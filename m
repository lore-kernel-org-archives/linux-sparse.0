From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 2/2] sparse: Add 'error' to ignored attributes
Date: Mon, 18 Jun 2012 14:07:49 +0300
Message-ID: <20120618110749.GB19915@elgon.mountain>
References: <cover.1340005296.git.dan.carpenter@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:39501 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab2FRLH7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 18 Jun 2012 07:07:59 -0400
Content-Disposition: inline
In-Reply-To: <cover.1340005296.git.dan.carpenter@oracle.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: KOSAKI Motohiro <kosaki.motohiro@gmail.com>

From: KOSAKI Motohiro <kosaki.motohiro@gmail.com>

Add some more ignored attributes which are used in glibc header files.  It
silences the warnings such as the following:

/usr/include/bits/fcntl2.h:36:1: error: attribute '__error__': unknown attribute

Signed-off-by: KOSAKI Motohiro <kosaki.motohiro@gmail.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 ident-list.h |    1 +
 parse.c      |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/ident-list.h b/ident-list.h
index 973bf57..a0b808f 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -89,6 +89,7 @@ IDENT(dllexport); IDENT(__dllexport__);
 IDENT(restrict); IDENT(__restrict);
 IDENT(artificial); IDENT(__artificial__);
 IDENT(vector_size); IDENT(__vector_size__);
+IDENT(error); IDENT(__error__);
 
 /* Preprocessor idents.  Direct use of __IDENT avoids mentioning the keyword
  * itself by name, preventing these tokens from expanding when compiling
diff --git a/parse.c b/parse.c
index 2dcd488..db6b519 100644
--- a/parse.c
+++ b/parse.c
@@ -509,6 +509,8 @@ const char *ignored_attributes[] = {
 	"__dllexport__",
 	"dllimport",
 	"__dllimport__",
+	"error",
+	"__error__",
 	"externally_visible",
 	"__externally_visible__",
 	"fastcall",
-- 
1.7.8.rc0.dirty
