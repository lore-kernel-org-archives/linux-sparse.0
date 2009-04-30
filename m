From: Reinhard Tartler <siretart@tauware.de>
Subject: [PATCH] show_token: handle TOKEN_UNTAINT and TOKEN_ARG_COUNT types
Date: Thu, 30 Apr 2009 23:08:53 +0200
Message-ID: <87tz0ek0is.fsf@faui44a.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:44208 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751857AbZHKMUF (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 11 Aug 2009 08:20:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MaqKg-0005Dc-D3
	for linux-sparse@vger.kernel.org; Tue, 11 Aug 2009 12:20:02 +0000
Received: from faui44a.informatik.uni-erlangen.de ([131.188.34.129])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-sparse@vger.kernel.org>; Tue, 11 Aug 2009 12:20:02 +0000
Received: from siretart by faui44a.informatik.uni-erlangen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-sparse@vger.kernel.org>; Tue, 11 Aug 2009 12:20:02 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


These cases are probably never hit with "regular" codepaths, but are
useful when called in a gdb session to print token sequences.

Signed-off-by: Reinhard Tartler <siretart@tauware.de>
---
 tokenize.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tokenize.c b/tokenize.c
index 6b67b96..93dd007 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -162,9 +162,18 @@ const char *show_token(const struct token *token)
 	case TOKEN_STREAMEND:
 		sprintf(buffer, "<end of '%s'>", stream_name(token->pos.stream));
 		return buffer;
-	
+
+	case TOKEN_UNTAINT:
+		sprintf(buffer, "<untaint>");
+		return buffer;
+
+	case TOKEN_ARG_COUNT:
+		sprintf(buffer, "<argcnt>");
+		return buffer;
+
 	default:
-		return "WTF???";
+		sprintf(buffer, "unhandled token type '%d' ", token_type(token));
+		return buffer;
 	}
 }

-- 
Gruesse/greetings,
Reinhard Tartler, KeyID 945348A4

