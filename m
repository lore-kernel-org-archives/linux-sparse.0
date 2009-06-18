From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Avoid "attribute 'warning': unknown attribute" warning
Date: Thu, 18 Jun 2009 10:41:29 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906181034590.16802@localhost.localdomain>
References: <alpine.LFD.2.01.0906180940490.16802@localhost.localdomain> <alpine.LFD.2.01.0906180951570.16802@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35410 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751918AbZFRRld (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Jun 2009 13:41:33 -0400
In-Reply-To: <alpine.LFD.2.01.0906180951570.16802@localhost.localdomain>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org


This avoids getting annoying warnings from <curl/typecheck-gcc.h> and from 
<bits/string3.h>, which use the "__attribute__((__warning__ (msg)))" gcc 
attribute.

[ The attribute causes gcc to print out the supplied warning message if 
  the function is used. We should some day support it, but this patch just 
  makes us ignore it. ]

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 parse.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/parse.c b/parse.c
index df696e5..e5ad867 100644
--- a/parse.c
+++ b/parse.c
@@ -528,6 +528,8 @@ static struct init_keyword {
 	{ "__cold__",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "hot",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "__hot__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "warning",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__warning__",	NS_KEYWORD,	.op = &ignore_attr_op },
 };
 
 void init_parser(int stream)
