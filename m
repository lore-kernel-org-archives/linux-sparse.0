From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 1/1] parser: add support for asm goto
Date: Fri, 18 Jun 2010 10:29:43 +0200
Message-ID: <4C1B2E77.3090404@suse.cz>
References: <1276158810-21313-1-git-send-email-jslaby@suse.cz>	<AANLkTikFMmCaTyACFgGGU84XxPUtpbfz0b3U67ZHj-jJ@mail.gmail.com>	<4C1250D3.10003@suse.cz>	<AANLkTikFcgP9fOlzepBbrX4GM0ESJaMiHlT1v2bMUVBw@mail.gmail.com> <AANLkTimGxxcjL74Yxshk3ybzQld3uf3Yhuk6VNAvQZWA@mail.gmail.com> <4C1B2C95.8000903@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:49329 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757937Ab0FRI3k (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 18 Jun 2010 04:29:40 -0400
Received: by fg-out-1718.google.com with SMTP id l26so310814fgb.1
        for <linux-sparse@vger.kernel.org>; Fri, 18 Jun 2010 01:29:39 -0700 (PDT)
In-Reply-To: <4C1B2C95.8000903@suse.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 06/18/2010 10:21 AM, Jiri Slaby wrote:
> Holy crap, in docco, there is nothing like that, but I checked gcc
> parser sources to be sure, and there indeed is:
>      asm type-qualifier[opt] ( asm-argument ) ;
>      asm type-qualifier[opt] goto ( asm-goto-argument ) ;
> So yes, asm volatile goto is valid. Would you take care of that?

It is as easy as:
diff --git a/parse.c b/parse.c
index caf10b9..1d20658 100644
--- a/parse.c
+++ b/parse.c
@@ -1915,7 +1915,8 @@ static struct token *parse_asm_statement(struct
token *token, struct statement *
        stmt->type = STMT_ASM;
        if (match_idents(token, &__volatile___ident, &__volatile_ident,
&volatile_ident, NULL)) {
                token = token->next;
-       } else if (match_idents(token, &goto_ident, NULL)) {
+       }
+       if (match_idents(token, &goto_ident, NULL)) {
                is_goto = 1;
                token = token->next;
        }

thanks,
-- 
js
suse labs
