From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] allow char to be unsigned
Date: Wed, 16 Oct 2013 14:22:34 +0300
Message-ID: <20131016112234.GA18544@longonot.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:45871 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760586Ab3JPLZh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 16 Oct 2013 07:25:37 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: smatch@vger.kernel.org, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>

On s390x machines the char type is unsigned.  We can detect these at
build time using the GCC __CHAR_UNSIGNED__ macro.

Reported-by: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/symbol.c b/symbol.c
index 86aef1c..9e0a27a 100644
--- a/symbol.c
+++ b/symbol.c
@@ -784,6 +784,12 @@ void init_symbols(void)
 	}
 }
 
+#ifdef __CHAR_UNSIGNED__
+#define CHAR_SIGNEDNESS MOD_UNSIGNED
+#else
+#define CHAR_SIGNEDNESS MOD_SIGNED
+#endif
+
 #define MOD_ESIGNED (MOD_SIGNED | MOD_EXPLICITLY_SIGNED)
 #define MOD_LL (MOD_LONG | MOD_LONGLONG)
 #define MOD_LLL MOD_LONGLONGLONG
@@ -801,7 +807,7 @@ static const struct ctype_declare {
 	{ &incomplete_ctype,SYM_BASETYPE, 0,			    NULL,		     NULL,		 NULL },
 	{ &bad_ctype,	    SYM_BASETYPE, 0,			    NULL,		     NULL,		 NULL },
 
-	{ &char_ctype,	    SYM_BASETYPE, MOD_SIGNED | MOD_CHAR,    &bits_in_char,	     &max_int_alignment, &int_type },
+	{ &char_ctype,	    SYM_BASETYPE, CHAR_SIGNEDNESS | MOD_CHAR,    &bits_in_char,	     &max_int_alignment, &int_type },
 	{ &schar_ctype,	    SYM_BASETYPE, MOD_ESIGNED | MOD_CHAR,   &bits_in_char,	     &max_int_alignment, &int_type },
 	{ &uchar_ctype,	    SYM_BASETYPE, MOD_UNSIGNED | MOD_CHAR,  &bits_in_char,	     &max_int_alignment, &int_type },
 	{ &short_ctype,	    SYM_BASETYPE, MOD_SIGNED | MOD_SHORT,   &bits_in_short,	     &max_int_alignment, &int_type },
