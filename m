From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: segfault on switch() + bitwise combo
Date: Sat, 10 Jun 2006 11:43:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606101143360.5498@g5.osdl.org>
References: <20060609151742.GA21428@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:40378 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030468AbWFJSny (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 10 Jun 2006 14:43:54 -0400
In-Reply-To: <20060609151742.GA21428@martell.zuzino.mipt.ru>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-sparse@vger.kernel.org, Morten Welinder <terra@gnome.org>



On Fri, 9 Jun 2006, Alexey Dobriyan wrote:
>
> It triggers by checking with -Wbitwise on drivers/net/wireless/ipw2100.c
> and net/sctp/sm_make_chunk.c

Perhaps something like this?

		Linus
---
diff --git a/evaluate.c b/evaluate.c
index 2c70cee..42005eb 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -359,7 +359,7 @@ static struct symbol *bad_expr_type(stru
 		break;
 	}
 
-	return NULL;
+	return expr->ctype = &bad_ctype;
 }
 
 static struct symbol *compatible_float_binop(struct expression **lp, struct expression **rp)
