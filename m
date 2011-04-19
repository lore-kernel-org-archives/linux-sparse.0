From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: PATCH 2/2] Teach 'already_tokenized()' to use the stream name hash
 table
Date: Tue, 19 Apr 2011 11:19:40 -0700 (PDT)
Message-ID: <alpine.LFD.2.02.1104191117290.22119@i5.linux-foundation.org>
References: <alpine.LFD.2.02.1104191108330.21972@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59364 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608Ab1DSSTq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 19 Apr 2011 14:19:46 -0400
Received: by pzk9 with SMTP id 9so2773638pzk.19
        for <linux-sparse@vger.kernel.org>; Tue, 19 Apr 2011 11:19:46 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1104191108330.21972@i5.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org


This replaces the "loop over all streams" with a simple hash lookup.  It
makes the cost of checking for already tokenized streams basically go
away (it could be up to 5% of CPU time, almost entirely due to the
"strcmp()" of the name).

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

That "up to 5%" is probably debatable, and will depend on just how many 
includes you have etc etc. And on the CPU and library issues. But 3-4% is 
definitely the case for my kernel C=2 build on my current machine.

So it's real, and worth it.

 pre-process.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index 603cc00c999f..6d12f173146d 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -655,10 +655,12 @@ static const char *token_name_sequence(struct token *token, int endop, struct to
 
 static int already_tokenized(const char *path)
 {
-	int i;
-	struct stream *s = input_streams;
+	int stream, next;
+
+	for (stream = *hash_stream(path); stream >= 0 ; stream = next) {
+		struct stream *s = input_streams + stream;
 
-	for (i = input_stream_nr; --i >= 0; s++) {
+		next = s->next_stream;
 		if (s->constant != CONSTANT_FILE_YES)
 			continue;
 		if (strcmp(path, s->name))
-- 
1.7.5.rc1.1.gc3f61.dirty

