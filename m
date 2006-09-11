From: Adam DiCarlo <bikko@us.ibm.com>
Subject: [PATCH RESEND] Add type information to enum mismatch warning
Date: Mon, 11 Sep 2006 14:06:14 -0700
Message-ID: <4505CFC6.4000807@us.ibm.com>
Reply-To: bikko@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:14012 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964926AbWIKVGQ
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 11 Sep 2006 17:06:16 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8BL6GtK001299
	for <linux-sparse@vger.kernel.org>; Mon, 11 Sep 2006 17:06:16 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8BL6Gqt369312
	for <linux-sparse@vger.kernel.org>; Mon, 11 Sep 2006 15:06:16 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8BL6FqE011788
	for <linux-sparse@vger.kernel.org>; Mon, 11 Sep 2006 15:06:16 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>


Signed-off-by: Adam DiCarlo <adam.dicarlo@gmail.com>
---
  evaluate.c |    5 ++++-
  1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 177797a..3076d41 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -253,8 +253,11 @@ warn_for_different_enum_types (struct po
  	if (typea == typeb)
  		return;

-	if (typea->type == SYM_ENUM && typeb->type == SYM_ENUM)
+	if (typea->type == SYM_ENUM && typeb->type == SYM_ENUM) {
  		warning(pos, "mixing different enum types");
+		info(pos, "    %s versus", show_typename(typea));
+		info(pos, "    %s", show_typename(typeb));
+	}
  }

  /*
-- 
1.4.2.ga444
