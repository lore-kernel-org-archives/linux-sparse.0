From: =?UTF-8?B?SmFjZWsgxZpsaXdlcnNraQ==?= <sliwers@googlemail.com>
Subject: Re: Defect in linearization of short circuit &&
Date: Mon, 15 Feb 2010 20:12:38 +0100
Message-ID: <4B799CA6.70807@googlemail.com>
References: <4B77FD0F.50401@googlemail.com> <4B78655D.2080007@googlemail.com> <70318cbf1002141509u4ebc4ef5x51ec41f5f1452a7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:36610 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755797Ab0BOTMq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 15 Feb 2010 14:12:46 -0500
Received: by ewy28 with SMTP id 28so583409ewy.28
        for <linux-sparse@vger.kernel.org>; Mon, 15 Feb 2010 11:12:42 -0800 (PST)
In-Reply-To: <70318cbf1002141509u4ebc4ef5x51ec41f5f1452a7a@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

Christopher Li pisze:
> 
> EXPR_BINOP used in normal operation require two operands.
> e.g.  a + b, a | b
> Both operands will get evaluated.
> 
> EXPR_LOGICAL using for condition branching and it has the short curcit
> behavior in mind. e.g. a || b

I found the offending block of code.  It is in expand.c, in function 
expand_logical:

       /*
        * If the right side is safe and cheaper than a branch,
        * just avoid the branch and turn it into a regular binop
        * style SAFELOGICAL.
        */
       if (rcost < BRANCH_COST) {
               expr->type = EXPR_BINOP;
               rcost -= BRANCH_COST - 1;
       }

After removing these lines, everything works fine.

But I guess that there must have been a reason to add them in the first 
place.  I see it checking the cost of the operation, but I don't know 
why somebody assumes that it would be safe not to make a branch. Does 
anybody know how to fix it without simply removing these lines?

Thanks!
Jacek
