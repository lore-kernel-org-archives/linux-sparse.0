Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256417;
	b=j0QLk/4F36j7/2QgNtxbLw0q6bO7yeqN7CcVL0ydQHuQ0TYoKDOANHBnCUIRK/m0v3tS
	 Lzz+FH1zt8eOG15MPHRvKU1HwypRtR7szoG0FYLhLJMPqPBDB2StCEByjrQ8gV5FxWJYS
	 ehhi0pFo6S9ehSHlSajuO0FSk41jYaHMK7+3RnAE0qM90UgK1bbrB/5P6MwBI4WNpDXcX
	 Dv4qcQlyBJHYQTYyAMLBUG3sHysD2aUF+ZfuEuYHVpSM8em+JpDBNG7rLA4nBrBXaZhkL
	 wLBm+PSyHpe8/sYqTUnTR3vy7Jk9V02CiU7A3QKSXVpfsAdGfy0guOiSImBzpX8XbrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256417;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Q3D35otzMWtIkhd6z/s37HHGuVO602fagS3BbKP3030=;
	b=Al7XLCjAnKD4A0DrTQWlQ+7TJ0YRr/SJsnjIYqUcCIvrP7qgCXJDvtC/wfp0x1xAnbDL
	 nMBdnUtujUnjjx+MvYOe1cvTvsYAUTXjuq8LoazdMt3qeTjlE5breeXW0NXODCwjy1TUL
	 FboiY7qPCb7IPmyXGRgYQHTc9Kg0+BVDALaTSpsazpks+i/WFyot7nwUTzdUxfyQ0FRis
	 BqFGR7HhC+XCqDb5oBuqFlTV7Wpo9eG139CDC44B4YwvBM7rGdi2+sTwUeseJ/3j6h6be
	 JV5BbTMpEKxXXYc+5jeVKTxKEq6ls+4yVBZjR+hkJp3xRGuM0sd+Bi8pEIOYQq6IvLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=PnHMmhdI;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99799606A326
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99799606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=PnHMmhdI
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM34PdWz1XM6JG;
	Mon,  9 Nov 2026 20:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256414; x=1796848415; bh=Q3D35
	otzMWtIkhd6z/s37HHGuVO602fagS3BbKP3030=; b=PnHMmhdIKuBhii5Vu3dr2
	YHXbfIiA2xCsi3JpBymIWfScrFQD5dBJDwEZvJyUuN91yaLkBxGUuUJP0QG4atW/
	+ygr9Cfoyy0v4CWh4bMUJ+qrCLxVAK/c3Yr4bI8a794Izos+lGIrvhSy3b8uHmV8
	ZaPiQAYmTCrKwsa846Hv6cPPwGdPVnMFKXchq/VndjmucXkUHhxzOPr7KyfKZ3AJ
	CH1hbnV5W8K/HwWYT0Re2V01uJew3FVX/NHF8vPppjhJvP4pscbiyYn7sy+Ptnwp
	5YOohz57/73tNmHfO+WPTSMvBUWf0P0nS/oj2vFJv6DeS7AfJpmaP9XV77QvzkZk
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id AqL3nqwE5iJF; Mon,  9 Nov 2026 20:33:34 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLw3fwKz1XMG49;
	Mon,  9 Nov 2026 20:33:28 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 19/73] ast-model: Return AST_N_COLUMNS and inspect child nodes lazily
Date: Mon,  9 Nov 2026 12:32:05 -0800
Message-ID: <20261109203259.362845-20-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109203259.362845-1-bvanassche@acm.org>
References: <20261109203259.362845-1-bvanassche@acm.org>
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Return AST_N_COLUMNS instead of 1 from ast_get_n_columns() so GtkTreeMode=
l
exposes the full column count to GTK tree views.

Populate child nodes lazily via inspect_child_node() and reject negative
indices in ast_iter_nth_child() before indexing node->childnodes.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 ast-model.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/ast-model.c b/ast-model.c
index cbd82dbb3b38..0cf74ef4ba77 100644
--- a/ast-model.c
+++ b/ast-model.c
@@ -227,7 +227,7 @@ ast_get_flags(GtkTreeModel *tree_model)
 static gint
 ast_get_n_columns(GtkTreeModel *tree_model)
 {
-	return 1;
+	return AST_N_COLUMNS;
 }
=20
=20
@@ -427,8 +427,11 @@ ast_iter_nth_child(GtkTreeModel *tree_model,
                         gint          n)
 {
 	AstNode    *node =3D parent ? parent->user_data : (AstNode*) tree_model=
;
-	GArray *array =3D node->childnodes;
-	if (n >=3D array->len)
+	GArray *array;
+
+	inspect_child_node(node);
+	array =3D node->childnodes;
+	if (n < 0 || n >=3D array->len)
 		return FALSE;
 	iter->user_data =3D g_array_index(array, AstNode *, n);
 	return TRUE;
