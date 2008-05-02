From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] ignore __cold__ attribute
Date: Fri, 02 May 2008 15:42:33 -0400
Message-ID: <1209757353.25568.2.camel@dv>
References: <1208860883.31429.8.camel@johannes.berg>
	 <20080422090739.2izftuclwocs80o4-cebfxv@fcnzpbc.arg@webmail.spamcop.net>
	 <1208870706.31429.23.camel@johannes.berg> <1208900131.22856.4.camel@dv>
	 <4811413E.1080103@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:37224 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932185AbYEBTmm (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 2 May 2008 15:42:42 -0400
In-Reply-To: <4811413E.1080103@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-sparse <linux-sparse@vger.kernel.org>

On Thu, 2008-04-24 at 19:26 -0700, Josh Triplett wrote:

> Looks good to me.  Could I get a signoff and commit message please?

I posted it already, but I think it was lost, so here it is again.


Ignore "cold" and "hot" attributes, which appeared in gcc 4.3

They describe how likely the function is to be executed, which can
affect optimization.  Also ignore the attributes with underscores.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 ident-list.h |    2 ++
 parse.c      |    4 ++++
 2 files changed, 6 insertions(+), 0 deletions(-)


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
