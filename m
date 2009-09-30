From: Michael Stefaniuc <mstefaniuc@gmail.com>
Subject: [PATCH] Ignore the alloc_size attribute.
Date: Wed, 30 Sep 2009 22:19:30 +0200
Message-ID: <20090930201930.GB32461@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32067 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752441AbZI3UT1 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 30 Sep 2009 16:19:27 -0400
Received: from int-mx04.intmail.prod.int.phx2.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.17])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8UKJVBf003750
	for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2009 16:19:31 -0400
Received: from brasov.str.redhat.com (brasov.str.redhat.com [10.32.0.1])
	by int-mx04.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8UKJUcr027541
	for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2009 16:19:31 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Wine has annotated the Win32 alloc functions with the alloc_size
attribute. This cuts down the noise a lot when running sparse on the
Wine source code.

Signed-off-by: Michael Stefaniuc <mstefaniuc@gmail.com>
---
Resend for the chrisl tree.


 parse.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/parse.c b/parse.c
index fa3b45e..c3f9b6a 100644
--- a/parse.c
+++ b/parse.c
@@ -475,6 +475,8 @@ static struct init_keyword {
 const char *ignored_attributes[] = {
 	"alias",
 	"__alias__",
+	"alloc_size",
+	"__alloc_size__",
 	"always_inline",
 	"__always_inline__",
 	"bounded",
-- 
1.6.5.rc2
