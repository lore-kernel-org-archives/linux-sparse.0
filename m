From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 1/2] sparse: Add '__vector_size__' to ignored attributes
Date: Mon, 18 Jun 2012 14:07:23 +0300
Message-ID: <20120618110723.GA19915@elgon.mountain>
References: <cover.1340005296.git.dan.carpenter@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:25698 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab2FRLHc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 18 Jun 2012 07:07:32 -0400
Content-Disposition: inline
In-Reply-To: <cover.1340005296.git.dan.carpenter@oracle.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: KOSAKI Motohiro <kosaki.motohiro@gmail.com>

From: KOSAKI Motohiro <kosaki.motohiro@gmail.com>

We already had "vector_size" but we also need __vector_size__ to silence
some warnings in glibc:

/usr/include/bits/link.h:67:45: error: attribute '__vector_size__': unknown attribute

Signed-off-by: KOSAKI Motohiro <kosaki.motohiro@gmail.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 ident-list.h |    1 +
 parse.c      |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/ident-list.h b/ident-list.h
index b12d172..973bf57 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -88,6 +88,7 @@ IDENT(dllimport); IDENT(__dllimport__);
 IDENT(dllexport); IDENT(__dllexport__);
 IDENT(restrict); IDENT(__restrict);
 IDENT(artificial); IDENT(__artificial__);
+IDENT(vector_size); IDENT(__vector_size__);
 
 /* Preprocessor idents.  Direct use of __IDENT avoids mentioning the keyword
  * itself by name, preventing these tokens from expanding when compiling
diff --git a/parse.c b/parse.c
index a809c14..2dcd488 100644
--- a/parse.c
+++ b/parse.c
@@ -568,6 +568,7 @@ const char *ignored_attributes[] = {
 	"used",
 	"__used__",
 	"vector_size",
+	"__vector_size__",
 	"visibility",
 	"__visibility__",
 	"warn_unused_result",
-- 
1.7.8.rc0.dirty

