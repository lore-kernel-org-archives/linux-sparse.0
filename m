From: "Mitesh Shah" <mshah@teja.com>
Subject: attributes are not stored at right location for array variables
Date: Wed, 31 Jan 2007 08:57:55 -0800
Message-ID: <AKEOJDDJLNPHDAKOMMBHGEPKCPAA.mshah@teja.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.teja.com ([209.10.202.133]:33147 "EHLO mail.teja.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932950AbXAaQ5h (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 31 Jan 2007 11:57:37 -0500
Received: from SURAT ([70.231.247.214])
	(authenticated user mshah@teja.com)
	by mail.teja.com (Kerio MailServer 6.1.4)
	for linux-sparse@vger.kernel.org;
	Wed, 31 Jan 2007 08:59:17 -0800
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>


It seems that the attributes are not stored with the variable ctype when the variable is an array. For declaration such as,

char c[100] __attribute__((aligned(64)));

The attribute is stored with the array ctype instead of the variable C ctype.

In function direct_declarator in parse.c at line 920 the ctype gets replaced with the array ctype and in the next iteration it is
passed to handle_attributes. handle_attributes should be passed the original ctype so here is the patch.

Thanks,

-Mitesh

-------------------------------------------------------

index 5077ee6..306b144 100644
--- a/parse.c
+++ b/parse.c
@@ -881,7 +881,7 @@ static struct token *direct_declarator(struct token *token, struct symbol *decl,
        }

        for (;;) {
-               token = handle_attributes(token, ctype);
+               token = handle_attributes(token, &decl->ctype);

                if (token_type(token) != TOKEN_SPECIAL)
                        return token;
