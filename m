From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH v2] sparse: add LLVM code generation backend
Date: Mon, 27 Apr 2009 18:39:39 -0400
Message-ID: <49F6342B.30605@garzik.org>
References: <20090426205806.GA20933@havoc.gtf.org> <70318cbf0904271215o48ac3952ua0aca68a50cba16d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49260 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754352AbZD0Wjn (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 27 Apr 2009 18:39:43 -0400
In-Reply-To: <70318cbf0904271215o48ac3952ua0aca68a50cba16d@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

Christopher Li wrote:
> On Sun, Apr 26, 2009 at 1:58 PM, Jeff Garzik <jeff@garzik.org> wrote:
>> +       case EXPR_DEREF:
>> +       case EXPR_SIZEOF:
>> +       case EXPR_ALIGNOF:
>> +               warning(expr->pos, "invalid expression after evaluation");
>> +               return NULL;
> 
> Regarding using liniearize instruction vs rolling your own.
> 
> I don't think you can get more information than linearize instruction
> here. EXPR_DEREF has already been processed during evaluation.

Recall the history of the code:  show-parse.c -> compile-i386.c -> 
s2l-gen.c.

You can see the above code was taken verbatim from show-parse.c, and is 
probably nothing more than a check the original author (Linus?) felt 
appropriate at the time, for show-parse.c.  I wouldn't read too much 
into its presence in s2l-gen.c -- maybe those checks can simply be deleted.

	Jeff



