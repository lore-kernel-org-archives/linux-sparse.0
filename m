Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254213D75AA
	for <linux-sparse@vger.kernel.org>; Tue, 31 Mar 2026 08:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774944241; cv=none; b=tNTN2onj5OYAogdDY8RanE6UCqJFwnZEmYdlRR6tkiA0wV7l3Cjep6/eRQboOuYvGuyvx6hulQ9DSdF1uNfZoztTV9KfmalaTHBuXpW/jET8XTQbNVEKAn/PdbSZ/9mggn6+tjplItKWMPmxL5DP2W0v069at+9TvrSbLrwgQeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774944241; c=relaxed/simple;
	bh=ZGsIUkEJerKK32+tYcWrS6JHeJVS8uwtC/3XfE0RU+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t75UDl1VtdNFpJsGb8IZDRtyF1BU8S6RkIdToYdvAuupuNquSnGAWnG/wmUXPPmCHF5Q4M7427DYz3o9hRUIEd6R9FOtmE32g+AodNRFfV7AXVAD2nIHLKmrw0dqcFz82NoOCA4CYkCD0RjskIEkU23lgUEMHsOmJHtPVHgnS2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=L4OFkmbh; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="L4OFkmbh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=29klGdsbMzRxt4ndadeSx69KgZrkWh1Ma36c01Q6oQA=; b=L4OFkmbhoDp/ZWP1hsXCQksLHR
	CoEt6IBDfc9SeG9W+Y8msMbdDAOBBaxvRNImHh35Zq04gvTxZTMNIYgSXCVUd7XaovgBXY9df03zd
	jANrGYKyqXQFnJZYJKBm+6woOEZ36CdwIwjSFDCh0FQ13NdFALJ0MdFfub5h/5TDOEODJnfXxyyCu
	Cl3HvtmBkAE/cjZ2hM76gjlCc5fwCzI+yapvajixWD8ql90LSQAREjSGDIPxuZBMTh3HwLN4Ofroh
	WMqydHhA5KT/NH26kSLQ6qkEfY6yUNP1QXnlQrTFmEAV9zRXvrVRcA1yBfjndvJ2prbtXfrZsk6bR
	OSCIhOpA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w7U8H-00000005mds-3OsT;
	Tue, 31 Mar 2026 08:07:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 2/6] simplify the inlined side of nextchar()
Date: Tue, 31 Mar 2026 09:07:25 +0100
Message-ID: <20260331080729.1378613-2-viro@zeniv.linux.org.uk>
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

* make sure that data stream->buffer + stream->size always points to
'\0'.  That is enough to send nextchar() towards the slow path without
the need to check offset for overflow.
* replace stream->offset with stream->current - pointer to current
location in buffer rather than offset in it.
* have the increments of stream->current and stream->pos done before
we check whether we need to call nextchar_slow() (with nextchar_slow()
adjusted to be called with incremented ->current and ->pos).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 tokenize.c | 71 +++++++++++++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/tokenize.c b/tokenize.c
index c3c6c234..7c12cf6e 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -47,7 +47,8 @@ unsigned int tabstop = 8;
 #define BUFSIZE (8192)
 
 typedef struct {
-	int fd, offset, size;
+	unsigned char *current;
+	int fd, size;
 	int pos, line, nr;
 	int newline, whitespace;
 	struct token **tokenlist;
@@ -351,31 +352,34 @@ static struct token * alloc_token(stream_t *stream)
  */
 static int nextchar_slow(stream_t *stream)
 {
-	int offset = stream->offset;
+	unsigned char *p = stream->current;	// bumped by fast path
 	int size = stream->size;
 	int c;
-	int spliced = 0, had_cr, had_backslash;
+	bool spliced = false, had_cr, had_backslash;
 
 restart:
-	had_cr = had_backslash = 0;
+	had_cr = had_backslash = false;
 
 repeat:
-	if (offset >= size) {
+	if (p > stream->buffer + size) {
 		if (stream->fd < 0)
 			goto got_eof;
 		size = read(stream->fd, stream->buffer, BUFSIZE);
 		if (size <= 0)
 			goto got_eof;
+		stream->buffer[size] = '\0';	// sentry
 		stream->size = size;
-		stream->offset = offset = 0;
+		stream->current = stream->buffer;
+		p = stream->buffer + 1;
 	}
 
-	c = stream->buffer[offset++];
+	c = p[-1];
 	if (had_cr)
 		goto check_lf;
 
 	if (c == '\r') {
-		had_cr = 1;
+		had_cr = true;
+		p++;
 		goto repeat;
 	}
 
@@ -383,6 +387,7 @@ norm:
 	if (!had_backslash) {
 		switch (c) {
 		case '\t':
+			stream->pos--;
 			stream->pos += tabstop - stream->pos % tabstop;
 			break;
 		case '\n':
@@ -391,38 +396,40 @@ norm:
 			stream->newline = 1;
 			break;
 		case '\\':
-			had_backslash = 1;
+			had_backslash = true;
 			stream->pos++;
+			p++;
 			goto repeat;
-		default:
-			stream->pos++;
 		}
 	} else {
 		if (c == '\n') {
 			stream->line++;
-			stream->pos = 0;
-			spliced = 1;
+			stream->pos = 1;
+			spliced = true;
+			p++;
 			goto restart;
 		}
-		offset--;
 		c = '\\';
+		stream->pos--;
+		p--;
 	}
-out:
-	stream->offset = offset;
+	stream->current = p;
 
 	return c;
 
-check_lf:
+check_lf:	// CR+LF => LF, solitary CR => LF
 	if (c != '\n')
-		offset--;
+		p--;
 	c = '\n';
 	goto norm;
 
 got_eof:
-	if (had_backslash) {
-		c = '\\';
-		goto out;
-	}
+	stream->pos--;
+	stream->buffer[0] = '\0';	// sentry
+	stream->current = stream->buffer;
+	stream->size = 0;
+	if (had_backslash)
+		return '\\';
 	if (stream->pos & Wnewline_eof)
 		warning(stream_pos(stream), "no newline at end of file");
 	else if (spliced)
@@ -437,16 +444,10 @@ got_eof:
  */
 static inline int nextchar(stream_t *stream)
 {
-	int offset = stream->offset;
-
-	if (offset < stream->size) {
-		int c = stream->buffer[offset++];
-		if (c >= ' ' && c != '\\') {
-			stream->offset = offset;
-			stream->pos++;
-			return c;
-		}
-	}
+	int c = *stream->current++;
+	stream->pos++;
+	if (c != '\\' && c >= ' ')
+		return c;
 	return nextchar_slow(stream);
 }
 
@@ -972,9 +973,8 @@ static struct token *setup_stream(stream_t *stream, int idx, int fd,
 
 	stream->token = NULL;
 	stream->fd = fd;
-	stream->offset = 0;
 	stream->size = buf_size;
-	stream->buffer = buf;
+	stream->current = stream->buffer = buf;
 
 	begin = alloc_token(stream);
 	token_type(begin) = TOKEN_STREAMBEGIN;
@@ -1014,7 +1014,7 @@ struct token * tokenize(const struct position *pos, const char *name, int fd, st
 {
 	struct token *begin, *end;
 	stream_t stream;
-	unsigned char buffer[BUFSIZE];
+	unsigned char buffer[BUFSIZE + 1];
 	int idx;
 
 	idx = init_stream(pos, name, fd, next_path);
@@ -1023,6 +1023,7 @@ struct token * tokenize(const struct position *pos, const char *name, int fd, st
 		return endtoken;
 	}
 
+	buffer[0] = '\0';
 	begin = setup_stream(&stream, idx, fd, buffer, 0);
 	end = tokenize_stream(&stream);
 	if (endtoken)
-- 
2.47.3

