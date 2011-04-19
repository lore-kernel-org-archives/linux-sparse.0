From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/2] Add new streams to a hash-list based on their names
Date: Tue, 19 Apr 2011 11:17:13 -0700 (PDT)
Message-ID: <alpine.LFD.2.02.1104191113010.22048@i5.linux-foundation.org>
References: <alpine.LFD.2.02.1104191108330.21972@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62481 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297Ab1DSSRS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 19 Apr 2011 14:17:18 -0400
Received: by pzk9 with SMTP id 9so2772431pzk.19
        for <linux-sparse@vger.kernel.org>; Tue, 19 Apr 2011 11:17:18 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1104191108330.21972@i5.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org


This trivially creates a small (currently 64-entry) hash table for
stream numbers, so that you can look up a stream by its name.

Nothing currently uses it, but the next commit will teach
"already_tokenized()" to look up the stream by name, allowing us to
avoid the "walk over each stream we've seen" loop.  The silly string
compare in that loop can take a lot of CPU time.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

The hash itself is soem random thing made up to look something like the 
Linux kernel path component hash. It seems "good enough".

NOTE! The linked list of "struct stream" is based on indexes, since that's 
the only way to look up a stream - they move around when we re-allocate 
them using realloc(), and you can't actually use a regular linked list of 
"struct stream *". 

 token.h    |    3 ++-
 tokenize.c |   25 ++++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/token.h b/token.h
index a7ec77e05b15..cd2923318446 100644
--- a/token.h
+++ b/token.h
@@ -40,7 +40,7 @@ struct stream {
 
 	/* Use these to check for "already parsed" */
 	enum constantfile constant;
-	int dirty;
+	int dirty, next_stream;
 	struct ident *protect;
 	struct token *ifndef;
 	struct token *top_if;
@@ -49,6 +49,7 @@ struct stream {
 extern int input_stream_nr;
 extern struct stream *input_streams;
 extern unsigned int tabstop;
+extern int *hash_stream(const char *name);
 
 struct ident {
 	struct ident *next;	/* Hash chain of identifiers */
diff --git a/tokenize.c b/tokenize.c
index 272974b3b844..d4f05e563770 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -14,6 +14,7 @@
 #include <string.h>
 #include <ctype.h>
 #include <unistd.h>
+#include <stdint.h>
 
 #include "lib.h"
 #include "allocate.h"
@@ -179,9 +180,28 @@ const char *show_token(const struct token *token)
 	}
 }
 
+#define HASHED_INPUT_BITS (6)
+#define HASHED_INPUT (1 << HASHED_INPUT_BITS)
+#define HASH_PRIME 0x9e370001UL
+
+static int input_stream_hashes[HASHED_INPUT] = { [0 ... HASHED_INPUT-1] = -1 };
+
+int *hash_stream(const char *name)
+{
+	uint32_t hash = 0;
+	unsigned char c;
+
+	while ((c = *name++) != 0)
+		hash = (hash + (c << 4) + (c >> 4)) * 11;
+
+	hash *= HASH_PRIME;
+	hash >>= 32 - HASHED_INPUT_BITS;
+	return input_stream_hashes + hash;
+}
+
 int init_stream(const char *name, int fd, const char **next_path)
 {
-	int stream = input_stream_nr;
+	int stream = input_stream_nr, *hash;
 	struct stream *current;
 
 	if (stream >= input_streams_allocated) {
@@ -199,6 +219,9 @@ int init_stream(const char *name, int fd, const char **next_path)
 	current->path = NULL;
 	current->constant = CONSTANT_FILE_MAYBE;
 	input_stream_nr = stream+1;
+	hash = hash_stream(name);
+	current->next_stream = *hash;
+	*hash = stream;
 	return stream;
 }
 
-- 
1.7.5.rc1.1.gc3f61.dirty

