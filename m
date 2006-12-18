From: James Westby <jw+debian@jameswestby.net>
Subject: [PATCH] Update the information in README about using the library.
Date: Mon, 18 Dec 2006 22:00:21 +0000
Message-ID: <20061218220021.GC8251@jameswestby.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:47561 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754663AbWLRWA3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 18 Dec 2006 17:00:29 -0500
Received: from [172.23.170.145] (helo=anti-virus03-08)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1GwQX5-0003By-Fu
	for linux-sparse@vger.kernel.org; Mon, 18 Dec 2006 22:00:27 +0000
Received: from [82.32.6.109] (helo=loser.MSHOME)
	by asmtp-out6.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1GwQX5-0003dO-17
	for linux-sparse@vger.kernel.org; Mon, 18 Dec 2006 22:00:27 +0000
Received: from jw2328 by loser.MSHOME with local (Exim 4.63)
	(envelope-from <jw+debian@jameswestby.net>)
	id 1GwQWz-0002QA-O2
	for linux-sparse@vger.kernel.org; Mon, 18 Dec 2006 22:00:21 +0000
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Changes in the library have left the README giving out of date information
on how to intialise the library and get the symbols out of it. Update the
documentation to match the latest functions.

Signed-off-by: James Westby <jw+debian@jameswestby.net>
---
 README |   29 ++++++++---------------------
 1 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/README b/README
index 6b1034b..69492ab 100644
--- a/README
+++ b/README
@@ -47,35 +47,22 @@ requires the information.
 
 This means that a user of the library will literally just need to do
 
-	struct token *token;
-	int fd = open(filename, O_RDONLY);
-	struct symbol_list *list = NULL;
+  struct string_list *filelist = NULL;
+  char *file;
 
-	if (fd < 0)
-		exit_with_complaint();
+  action(sparse_initialize(argc, argv, filelist));
 
-	// Initialize parse symbols
-	init_symbols();
-
-	// Tokenize the input stream
-	token = tokenize(filename, fd, NULL);
-
-	// Pre-process the stream
-	token = preprocess(token);
-
-	// Parse the resulting C code
-	translation_unit(token, &list);
-
-	// Evaluate the types now if we want to
-	// Or leave it until later.
-	symbol_iterate(list, evaluate_symbol, NULL);
+  FOR_EACH_PTR_NOTAG(filelist, file) {
+    action(sparse(file));
+  } END_FOR_EACH_PTR_NOTAG(file);
 
 and he is now done - having a full C parse of the file he opened.  The
 library doesn't need any more setup, and once done does not impose any
 more requirements.  The user is free to do whatever he wants with the
 parse tree that got built up, and needs not worry about the library ever
 again.  There is no extra state, there are no parser callbacks, there is
-only the parse tree that is described by the header files. 
+only the parse tree that is described by the header files. The action 
+funtion takes a pointer to a symbol_list and does whatever it likes with it.
 
 The library also contains (as an example user) a few clients that do the
 preprocessing, parsing and type evaluation and just print out the
-- 
1.4.4.2
