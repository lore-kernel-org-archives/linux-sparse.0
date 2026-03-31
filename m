Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193F23D75A0
	for <linux-sparse@vger.kernel.org>; Tue, 31 Mar 2026 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774944241; cv=none; b=T3GebYdIfMoM6SohlPEKQQxrqGwE61iilNOTGaPtyR/zTb4sukcfmrrG4tJPLctDmZQkCxgSchBbAe95tSsGb7XHEfzwFAADWJdwuvrA0+2C9/Y4NmQdZhack78ZCXm+gD+LuE7z9ZoITGX0tdoiTwhZWAFx56bQMtmwEMeciKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774944241; c=relaxed/simple;
	bh=w9QQqnh4wEyAZO7S5sATQjd9DhNxFvjB4GnJd0Ghy40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEOmeffF+lG0hc9w/5giyB6BrCSYfmS70N0Qez3KK61ny7tH6RouvKKex2qoUH0CipBqzxoxveuS1BItX1In5zvSYnwLSW7xXx+JXsNPccI58/2XdG9XljP1A8yEfPkQPYJrZFXhPoN5QnWpuV3+cJdcFeYCVFfoMPXm1lMIQc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bA+Esy8D; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bA+Esy8D"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ReSWQt0OAgcbE+BfjOj3vT8ED9+R+ZRSb4elC0zNnM0=; b=bA+Esy8DbvZIXP7H1FPJ4HkAIf
	AQber+TBa29+0S+cbmlLQ+QUcALX3JaxBoGiqTKpq9iliLrB0SG5woCsbJyQ7mTWaFrCz4+IhVrJI
	G1N0pJURjMLepkXEK4wfRFFjOSMsrwXEurP/k2pan04voyK5k8Lji9K6cZHjZ+xWD5B1SKLjJaIpn
	cmn+AvXs0IX+Xp2/gUiu+QDJOwdpoxkrfSWa4cZswtOOHQoaehKt+iYbpxzN7PZn3+jy+omB0viuY
	gSb+9hhCDyDzRYs6pbhqtCIUuu+dOaPuAKu+ixA+7gF+RunqVFtztDxlNR1fh116KB+hzifuwsTOt
	97Y5IBLg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w7U8I-00000005me2-25Tn;
	Tue, 31 Mar 2026 08:07:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 3/6] tokenize_stream(): don't bother with isspace()
Date: Tue, 31 Mar 2026 09:07:26 +0100
Message-ID: <20260331080729.1378613-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331080729.1378613-1-viro@zeniv.linux.org.uk>
References: <20260331080631.GA1328137@ZenIV>
 <20260331080729.1378613-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

we have a spare bit in cclass[]...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 tokenize.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tokenize.c b/tokenize.c
index 7c12cf6e..e6e071ae 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -496,9 +496,16 @@ enum {
 	Dot = 16,
 	ValidSecond = 32,
 	Quote = 64,
+	Whitespace = 128,
 };
 
 static const char cclass[257] = {
+	[' ' + 1] = Whitespace,
+	['\t' + 1] = Whitespace,
+	['\n' + 1] = Whitespace,
+	['\v' + 1] = Whitespace,
+	['\r' + 1] = Whitespace,
+	['\f' + 1] = Whitespace,
 	['0' + 1 ... '9' + 1] = Digit | Hex,
 	['A' + 1 ... 'D' + 1] = Letter | Hex,
 	['E' + 1] = Letter | Hex | Exp,	/* E<exp> */
@@ -986,16 +993,16 @@ static struct token *tokenize_stream(stream_t *stream)
 {
 	int c = nextchar(stream);
 	while (c != EOF) {
-		if (!isspace(c)) {
+		if (!(cclass[c + 1] & Whitespace)) {
 			struct token *token = alloc_token(stream);
 			stream->token = token;
 			stream->newline = 0;
 			stream->whitespace = 0;
 			c = get_one_token(c, stream);
-			continue;
+		} else {
+			stream->whitespace = 1;
+			c = nextchar(stream);
 		}
-		stream->whitespace = 1;
-		c = nextchar(stream);
 	}
 	return mark_eof(stream);
 }
-- 
2.47.3

