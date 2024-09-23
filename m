Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DC240855
	for <linux-sparse@vger.kernel.org>; Mon, 23 Sep 2024 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727080827; cv=none; b=rAsebJdvODFOSWyZzpbRBJNmMMee9Kj2JVEn5gWNrGiO4eOczbWLqEH7pstcwE7IRIwIEzFfEan/93xCcCSX4qguiWSuZKw1BQvzmuN1brwLT++DUISmlPGr2I9QOHXkwHfv2RvqX7l/nCpDARaQv6HVBEJ07zcmf2bN8FwIRCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727080827; c=relaxed/simple;
	bh=UUI/3HZ9uiIeRDL+8be+g6lckTwI8z1BjOvEgWnmU2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ac8oc+cIf8AQQQ4nBDT0+IO2xqv1bCKHfYGVPpwokGUq4Ujn+QFazCo5nUr4TgAXZ9Ccz87dr6QGNMwlF5B/NPCkCMwu0SNzlfkXrMl6P17jvgKKHVXcC5urnDaPJjEh+uNe/JAXXBZGm4H/cRtTdEXyh2GUeiZ5W3igMbFXrRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=mdjhY50h; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="mdjhY50h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1727080817;
	bh=TKojGQo5efZPVPhdbfLGFXdP1X1sJLA7NWhICEw5iS4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=mdjhY50hyPqO34IJtBam/cB5F1Y4Yl0G/26+LnPqgBmhpalE4aiAxP8wKaWscNIFZ
	 zYaSmZQOgWFM/5WVzyDiW0LzXeeaaPx4O5gd9OX6Iq48eUpqoHQ3mx7zjZMbg6/gYM
	 UYXHuCeK6jBJWv93hBq0j5UflbNiL9M/bcXD05Go=
X-QQ-mid: bizesmtp83t1727080813tqdo9n6k
X-QQ-Originating-IP: Q/YpEDnwgrIuSpgjVuwTVdN4vCqR1lEU04pD1jEO2oE=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 23 Sep 2024 16:40:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1424971217008246655
From: wenlunpeng <wenlunpeng@uniontech.com>
To: linux-sparse@vger.kernel.org
Cc: wenlunpeng <wenlunpeng@uniontech.com>
Subject: [PATCH] fix: Skip if symbol have no op when handle_qualifiers
Date: Mon, 23 Sep 2024 16:39:44 +0800
Message-Id: <20240923083944.2263208-1-wenlunpeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0

Missing s->op will cause a SIGSEGV when trying to get s->op->type.

I encountered the issue when building with sparse in a linux kernel tree
containing a vendor network driver. A simple `make` will success but a
`make C=2` will exit with exit-code 139. The coredump shows that s->op
here is NULL when dealing with a source code line like:
	u8 *byte;

Lines like this exist everywhere. I cannot figure out why just this file
breaks sparse. But I think the NULL judge is needed here.

Signed-off-by: wenlunpeng <wenlunpeng@uniontech.com>
---
 parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse.c b/parse.c
index 3d6fef7c..66d0be04 100644
--- a/parse.c
+++ b/parse.c
@@ -1505,7 +1505,7 @@ static struct token *handle_qualifiers(struct token *t, struct decl_state *ctx)
 {
 	while (token_type(t) == TOKEN_IDENT) {
 		struct symbol *s = lookup_keyword(t->ident, NS_TYPEDEF);
-		if (!s)
+		if (!s || !s->op)
 			break;
 		if (!(s->op->type & (KW_ATTRIBUTE | KW_QUALIFIER)))
 			break;
-- 
2.20.1

