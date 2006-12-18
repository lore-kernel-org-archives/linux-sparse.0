From: James Westby <jw+debian@jameswestby.net>
Subject: [PATCH] Update README to match changes in the initialization code
Date: Mon, 18 Dec 2006 17:01:13 +0000
Message-ID: <20061218170107.GA7269@jameswestby.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:45953 "EHLO
	smtp-out2.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754714AbWLRWgl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 18 Dec 2006 17:36:41 -0500
Received: from [172.23.170.143] (helo=anti-virus02-10)
	by smtp-out2.blueyonder.co.uk with smtp (Exim 4.52)
	id 1GwLrW-0001NI-VI
	for linux-sparse@vger.kernel.org; Mon, 18 Dec 2006 17:01:15 +0000
Received: from [82.32.6.109] (helo=loser.MSHOME)
	by asmtp-out1.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1GwLrW-0003NZ-3q
	for linux-sparse@vger.kernel.org; Mon, 18 Dec 2006 17:01:14 +0000
Received: from jw2328 by loser.MSHOME with local (Exim 4.63)
	(envelope-from <jw+debian@jameswestby.net>)
	id 1GwLrV-0001tR-Rr
	for linux-sparse@vger.kernel.org; Mon, 18 Dec 2006 17:01:13 +0000
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

There have been changes in the functions to call to get the parse tree
from sparse, so update the README file to reflect these changes.

Signed-off-by: James Westby <jw+debian@jameswestby.net>
---
 README |   20 +++-----------------
 1 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/README b/README
index 6b1034b..b9ee73c 100644
--- a/README
+++ b/README
@@ -47,28 +47,14 @@ requires the information.
 
 This means that a user of the library will literally just need to do
 
-	struct token *token;
-	int fd = open(filename, O_RDONLY);
 	struct symbol_list *list = NULL;
 
-	if (fd < 0)
-		exit_with_complaint();
-
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
+	// Initialise sparse and tokenize, preprocess and parse the file.
+	list = sparse(filename);
 
 	// Evaluate the types now if we want to
 	// Or leave it until later.
-	symbol_iterate(list, evaluate_symbol, NULL);
+	evaluate_symbol_list(list);
 
 and he is now done - having a full C parse of the file he opened.  The
 library doesn't need any more setup, and once done does not impose any
-- 
1.4.4.2
