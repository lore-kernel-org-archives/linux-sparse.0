Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DCF3C0606
	for <linux-sparse@vger.kernel.org>; Tue, 31 Mar 2026 08:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774944242; cv=none; b=gbR1yPbDtNAmNKUlle2s2qjYLHMe3/UiwWINQDDPMnbZ4xdbenZxxVfpnYqQ1yHnEb9NgMDMoNYlZVXY0iADbNeTmWLmKVF0KydSW5f+QbnXjgHM+6DCSCx9/J4eK402nVOv7pAB/+gWLcAV+Tk6QCmsSh9AgrK4+yLmVHjTwbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774944242; c=relaxed/simple;
	bh=pGAjZAm/3o5QQcz53s49zOeeK5mOX1xtPkpozCiGi9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOMMu7WeUNwbs1ZwF4j872/GOlJGwsO+8yCkrXRyqjOLnWZqEM8PdV7DIWbwupf3r9ok7QLCP6TDh9Wa4ZY8pS4UghhoKkHgkU3og9j+BerouzRyPh2D6Hu6HnXTT27bD1+52R/224ne5hluYYPTb/NiWyedGI0fbmhD20vpMJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=V1TYbQDX; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="V1TYbQDX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JAsJBJJnn1avqDGPMewuXYWy4txWAWfeG+aAhAj3I6A=; b=V1TYbQDXqIZje6GDmImf8Oxs7D
	baGzh9D7or/pTZc+kx+/mLlZtcvvRCdZuw3GuxEdqPgGwoypDZnu92I1jQpWpBO/IjL0yUdXYPtec
	Aix3/7s6qlurS1rnSgECdbveFeTf/XfxPSBJ2d2lEZlbXttCmcFw6RorgHUPnDVhmFnZOLc9Aw1+C
	L/VrDnGOaYda3owFbDFr8hvzLdlO87Xelh7xI3XQk5aIIgeMKrvskGHBVD39i/GOuRWol5Q/Hhua3
	hFw/49hrZNHsWMLP/gWDn5cUKyJYFYQLV1XPL227imZv9hF2Z9kNx2uBWx2TXt4LSxBEBqJEwBeJm
	xoJyPuBQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w7U8H-00000005mdp-2COP;
	Tue, 31 Mar 2026 08:07:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 1/6] nextchar(): get rid of special[]
Date: Tue, 31 Mar 2026 09:07:24 +0100
Message-ID: <20260331080729.1378613-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331080631.GA1328137@ZenIV>
References: <20260331080631.GA1328137@ZenIV>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

We want to hit the slow path on '\t', '\n', '\\' and '\r'.  Doing that
as series of checks is painful, but we don't need to be that precise -
we almost never see control symbols outside of that set and the slow
path will handle them just fine.  And checking if character belongs to
[\0-\017\\] is easy enough without bothering with storing the set as
an array.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 tokenize.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tokenize.c b/tokenize.c
index 85bc3f49..c3c6c234 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -441,10 +441,7 @@ static inline int nextchar(stream_t *stream)
 
 	if (offset < stream->size) {
 		int c = stream->buffer[offset++];
-		static const char special[256] = {
-			['\t'] = 1, ['\r'] = 1, ['\n'] = 1, ['\\'] = 1
-		};
-		if (!special[c]) {
+		if (c >= ' ' && c != '\\') {
 			stream->offset = offset;
 			stream->pos++;
 			return c;
-- 
2.47.3

