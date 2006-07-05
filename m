From: Josh Triplett <josht@vnet.ibm.com>
Subject: [PATCH 2/2] Handle EXPR_TYPE in copy_expression
Date: Wed, 05 Jul 2006 15:09:32 -0700
Message-ID: <1152137372.6507.135.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:39065 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965049AbWGEWJb
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 5 Jul 2006 18:09:31 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k65M9UxA021940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Wed, 5 Jul 2006 18:09:31 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k65M8mwN297938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Wed, 5 Jul 2006 16:08:48 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k65M9UAC020186
	for <linux-sparse@vger.kernel.org>; Wed, 5 Jul 2006 16:09:30 -0600
Received: from dyn9047018143.beaverton.ibm.com (dyn9047018143.beaverton.ibm.com [9.47.18.143])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k65M9Uvi020176
	for <linux-sparse@vger.kernel.org>; Wed, 5 Jul 2006 16:09:30 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

With the introduction of __builtin_types_compatible_p, types can now appear as
expressions (underneath an EXPR_COMPARE), so copy_expression needs to handle
EXPR_TYPE; just pass type expressions through without copying, since they
won't change when inlining.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 inline.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/inline.c b/inline.c
index 1f0172e..81530d1 100644
--- a/inline.c
+++ b/inline.c
@@ -79,6 +79,7 @@ static struct expression * copy_expressi
 	case EXPR_VALUE:
 	case EXPR_STRING:
 	case EXPR_FVALUE:
+	case EXPR_TYPE:
 		break;
 
 	/* Unops: check if the subexpression is unique */
