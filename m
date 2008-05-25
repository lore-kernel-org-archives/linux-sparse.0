From: Vegard Nossum <vegard.nossum@gmail.com>
Subject: [PATCH] Fix use of invalid file descriptor
Date: Sun, 25 May 2008 09:51:57 +0200
Message-ID: <20080525075157.GA3681@damson.getinternet.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:8066 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbYEYHwE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 25 May 2008 03:52:04 -0400
Received: by nf-out-0910.google.com with SMTP id d3so680143nfc.21
        for <linux-sparse@vger.kernel.org>; Sun, 25 May 2008 00:52:01 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

From: Vegard Nossum <vegardno@ifi.uio.no>
Date: Sun, 25 May 2008 09:41:29 +0200
Subject: [PATCH] Fix use of invalid file descriptor

tokenize_buffer() calls setup_stream() with a file descriptor argument of -1.
This number makes it all the way into nextchar_slow(), where -1 is used as an
actual file descriptor when calling read().

Check for the -1 before calling read() if the buffer is empty.

(By the way, that read() there is probably missing some additional error
 handling. An EINTR at the right moment...)

Signed-off-by: Vegard Nossum <vegardno@ifi.uio.no>
---
 tokenize.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/tokenize.c b/tokenize.c
index e72c56e..d154882 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -213,6 +213,8 @@ restart:
 
 repeat:
 	if (offset >= size) {
+		if (stream->fd < 0)
+			goto got_eof;
 		size = read(stream->fd, stream->buffer, BUFSIZE);
 		if (size <= 0)
 			goto got_eof;
-- 
1.5.4.1

