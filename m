From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 7/16] Let void have sizeof 1
Date: Fri, 19 Dec 2008 01:32:28 +0300
Message-ID: <20081218223216.23692.711.stgit@zaytsev.su>
References: <20081218181935.28136.60256.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:11655 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbYLRWXQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Dec 2008 17:23:16 -0500
Received: by nf-out-0910.google.com with SMTP id d3so99862nfc.21
        for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2008 14:23:14 -0800 (PST)
In-Reply-To: <20081218181935.28136.60256.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

Gcc assumes sizeof(void) being 1.
Currently sparse would generate wrong code for:

void *test(void *p) {
       p++;
       return p;
}

unsigned long test1(void *p)
{
       return sizeof(*p);
}

.L0x2b48867c1010:
       <entry-point>
       add.32      %r2 <- %arg1, $-1
       ret.32      %r2

test1:
.L0x2b48867c10b0:
       <entry-point>
       ret.32      $-1

And with bit_size set to &bits_in_char, the code looks
as expected.

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
---
 symbol.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/symbol.c b/symbol.c
index 4da253b..02844cf 100644
--- a/symbol.c
+++ b/symbol.c
@@ -834,7 +834,7 @@ static const struct ctype_declare {
 	struct symbol *base_type;
 } ctype_declaration[] = {
 	{ &bool_ctype,	    SYM_BASETYPE, MOD_UNSIGNED,		    &bits_in_bool,	     &max_int_alignment, &int_type },
-	{ &void_ctype,	    SYM_BASETYPE, 0,			    NULL,		     NULL,		 NULL },
+	{ &void_ctype,	    SYM_BASETYPE, 0,			    &bits_in_char,	     NULL,		 NULL },
 	{ &type_ctype,	    SYM_BASETYPE, MOD_TYPE,		    NULL,		     NULL,		 NULL },
 	{ &incomplete_ctype,SYM_BASETYPE, 0,			    NULL,		     NULL,		 NULL },
 	{ &bad_ctype,	    SYM_BASETYPE, 0,			    NULL,		     NULL,		 NULL },

