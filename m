Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED9034D4EB
	for <linux-sparse@vger.kernel.org>; Mon, 16 Mar 2026 07:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644475; cv=none; b=l4IXlkKmDuIQlVlTgAcQU4fyjL3x5V36SfAH3A5LPUwKcixELbT9IuLuIde8RcX3D4Njiy/kZr/yrU+SKLUJXS1BvPjyJk2eWD5ddqDQMU1LoVsmmzqOyrqBrwyXzxma/X2gBdZY7m9UF6luhC3MZmtYPerzlUVPvoofAi8F4eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644475; c=relaxed/simple;
	bh=ehnZminfkURSgBkrlx6xHS9PiXQyNbzkc+Rxuly3FyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFWuH1KbPdT7sjcsr0DQcDAlNbiOD8w7em3bHcUXUqNMCqEQEJjDUrjILJYsdal5/CgWfN2M2LIm9VuCxNPvwUhLwZm1JT+hjs4pmKOmWM3Jv28hRoMsXhYN8OMrQ8XO0ko9Zr34mJ2ebdOWfu0wghHkZgIybhP82XqCGf85XcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cdrQ5bsF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cdrQ5bsF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=pcWbk8UiiZBkSd+3etfZvQohb0NFaZCpPbrq523lTS8=; b=cdrQ5bsFANCQAPTTdhElxrHBES
	5GKRBW79eN9uCZ6/HmB8WOTzhUXq1wfdEBhlmtUEel6Psw6ew8Nt95zTFU+7zRm25sB349wP6t7Bk
	vNln2eWNDnbFawoVLk0t8sYsHj9SZQ949hgV/pEA/14DfMgqAZoAVWiM5UNKJ02YvuGptVN9L0X0Z
	84bxE08Zojk7SoDl8vL3kpiLqWwSeZHfPEjc92O3LH0TYkU9XnaJBvU7p8XxSEJq74j0O35cFni6B
	GNyDW1+srry93jwLpS2QWZ9Re61ZJu0nO7KMgd5JD/MRd5r+amq0/anIjG/iQ368qyVMLysWzIdgP
	1qTO62RQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w21zv-00000003E3w-1Bcl;
	Mon, 16 Mar 2026 07:04:19 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 20/21] make expand_one_symbol() inline
Date: Mon, 16 Mar 2026 07:04:14 +0000
Message-ID: <20260316070415.768839-20-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316070415.768839-1-viro@zeniv.linux.org.uk>
References: <20260316065622.GA607739@ZenIV>
 <20260316070415.768839-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

better code generation that way...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 pre-process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pre-process.c b/pre-process.c
index 73f4d615..728feeb3 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -206,7 +206,7 @@ static void expand_include_level(struct token *token)
 	replace_with_integer(token, include_level - 1);
 }
 
-static int expand_one_symbol(struct token **list)
+static inline int expand_one_symbol(struct token **list)
 {
 	struct token *token = *list;
 	struct symbol *sym;
-- 
2.47.3

