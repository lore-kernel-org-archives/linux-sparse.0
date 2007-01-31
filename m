From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Sparse fooled by double semicolon
Date: Tue, 30 Jan 2007 22:58:38 -0800
Message-ID: <20070131065838.GA23326@chrisli.org>
References: <1170219027.11455.68.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc15.comcast.net ([63.240.77.85]:37829 "EHLO
	sccrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932846AbXAaHY5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 31 Jan 2007 02:24:57 -0500
Content-Disposition: inline
In-Reply-To: <1170219027.11455.68.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>

Good catch, can you please try the following patch?

Chris

Fix double semicolon in struct declare

Pavel discover this test case:
#include <string.h>
void test(void)
{
       struct { int foo;; } val;
       memset(&val, 0, sizeof(val));
}

Sparse creates a member with empty ctype. We should skip that.

Signed-Off-By: Christopher Li<spase@chrisli.org>

Index: sparse/parse.c
===================================================================
--- sparse.orig/parse.c	2007-01-29 14:46:09.000000000 -0800
+++ sparse/parse.c	2007-01-30 23:11:42.000000000 -0800
@@ -1039,7 +1039,8 @@ static struct token *struct_declaration_
 			sparse_error(token->pos, "expected ; at end of declaration");
 			break;
 		}
-		token = token->next;
+		while(match_op(token, ';'))
+			token = token->next;
 	}
 	return token;
 }
