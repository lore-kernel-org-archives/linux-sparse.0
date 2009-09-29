From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Ignore the alloc_size attribute.
Date: Tue, 29 Sep 2009 23:01:19 +0200
Message-ID: <20090929210119.GB3592@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:11588 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752809AbZI2VBR (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 29 Sep 2009 17:01:17 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8TL1Kib024228
	for <linux-sparse@vger.kernel.org>; Tue, 29 Sep 2009 17:01:21 -0400
Received: from brasov.str.redhat.com (brasov.str.redhat.com [10.32.0.1])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8TL1KgP013365
	for <linux-sparse@vger.kernel.org>; Tue, 29 Sep 2009 17:01:20 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Wine has annotated the Win32 alloc functions with the alloc_size
attribute. This cuts down the noise a lot when running sparse on the
Wine source code.

Signed-off-by: Michael Stefaniuc <mstefani@redhat.com>
---
 parse.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/parse.c b/parse.c
index 5f6f9c3..dfd5703 100644
--- a/parse.c
+++ b/parse.c
@@ -475,6 +475,8 @@ static struct init_keyword {
 	{ "__nothrow__",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "malloc",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "__malloc__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "alloc_size",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__alloc_size__",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "nonnull",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "__nonnull",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "__nonnull__",	NS_KEYWORD,	.op = &ignore_attr_op },
-- 
1.6.5.rc1
