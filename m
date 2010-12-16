From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH 1/2] Fix tokenizer for octal escape sequences
Date: Thu, 16 Dec 2010 18:14:45 +0900
Message-ID: <1292490886-6238-1-git-send-email-namhyung@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49433 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989Ab0LPJPM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 16 Dec 2010 04:15:12 -0500
Received: by pva4 with SMTP id 4so463141pva.19
        for <linux-sparse@vger.kernel.org>; Thu, 16 Dec 2010 01:15:11 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

Don't allow 8 and 9 to be included in octal escape sequences.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 tokenize.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tokenize.c b/tokenize.c
index 4c975175eccc..272974b3b844 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -495,7 +495,7 @@ static int escapechar(int first, int type, stream_t *stream, int *valp)
 			case '0'...'7': {
 				int nr = 2;
 				value -= '0';
-				while (next >= '0' && next <= '9') {
+				while (next >= '0' && next <= '7') {
 					value = (value << 3) + (next-'0');
 					next = nextchar(stream);
 					if (!--nr)
-- 
1.7.3.3.400.g93cef

