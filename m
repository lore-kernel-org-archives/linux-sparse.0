From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] ignore __cold__ attribute
Date: Tue, 22 Apr 2008 17:35:31 -0400
Message-ID: <1208900131.22856.4.camel@dv>
References: <1208860883.31429.8.camel@johannes.berg>
	 <20080422090739.2izftuclwocs80o4-cebfxv@fcnzpbc.arg@webmail.spamcop.net>
	 <1208870706.31429.23.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:56310 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753841AbYDVVfe (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 Apr 2008 17:35:34 -0400
In-Reply-To: <1208870706.31429.23.camel@johannes.berg>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse <linux-sparse@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>

On Tue, 2008-04-22 at 15:25 +0200, Johannes Berg wrote:
> *Shrug*. I just wanted the kernel to work again and failed (in about 20
> minutes of searching) to find a changelog for gcc mentioning this so
> gave up and just added the one that the kernel uses. Want to amend the
> patch?

I think this would be better.  Now sparse would ignore both "cold" and
"hot", both with and without underscores.  They are also added to
ident-list.h.

diff --git a/ident-list.h b/ident-list.h
index 8fcd7de..6104826 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -74,6 +74,8 @@ IDENT(__malloc__);
 IDENT(nonnull); IDENT(__nonnull); IDENT(__nonnull__);
 IDENT(constructor); IDENT(__constructor__);
 IDENT(destructor); IDENT(__destructor__);
+IDENT(cold); IDENT(__cold__);
+IDENT(hot); IDENT(__hot__);
 IDENT(cdecl); IDENT(__cdecl__);
 IDENT(stdcall); IDENT(__stdcall__);
 IDENT(fastcall); IDENT(__fastcall__);
diff --git a/parse.c b/parse.c
index 137ba77..877414c 100644
--- a/parse.c
+++ b/parse.c
@@ -353,6 +353,10 @@ static struct init_keyword {
 	{ "__constructor__",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "destructor",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "__destructor__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "cold",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__cold__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "hot",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__hot__",	NS_KEYWORD,	.op = &ignore_attr_op },
 };
 
 void init_parser(int stream)


-- 
Regards,
Pavel Roskin
