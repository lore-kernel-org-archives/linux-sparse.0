From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH v2] sparse: add LLVM code generation backend
Date: Mon, 27 Apr 2009 20:32:26 -0400
Message-ID: <49F64E9A.2030009@garzik.org>
References: <20090426205806.GA20933@havoc.gtf.org>	 <70318cbf0904271215o48ac3952ua0aca68a50cba16d@mail.gmail.com>	 <49F6342B.30605@garzik.org> <70318cbf0904271627w25df616di12e5b1454e89764f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46387 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753383AbZD1Ac2 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 27 Apr 2009 20:32:28 -0400
In-Reply-To: <70318cbf0904271627w25df616di12e5b1454e89764f@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

Christopher Li wrote:
> On Mon, Apr 27, 2009 at 3:39 PM, Jeff Garzik <jeff@garzik.org> wrote:
>> You can see the above code was taken verbatim from show-parse.c, and is
>> probably nothing more than a check the original author (Linus?) felt
>> appropriate at the time, for show-parse.c.  I wouldn't read too much into
>> its presence in s2l-gen.c -- maybe those checks can simply be deleted.
> 
> I did not explain it clear it enough. It is not about the code is not
> used. My point is:
> 
> 1) linearize instruction does not lose the information you care about
>    generating better LLVM code. The evaluation does.

> 2) By writing your own AST recursive code, it does not gain more
>    information than what you can already do with current linearize
>    instruction. The EXPR_DEREF is processed in evaluation stage.
>    The structure laid you care about is already gone by the time your
>    s2l-gen about to emit LLVM byte codes. You did not generate any
>    GET_ELEMENT_PTR in your LLVM byte code, right?

Not true -- I can walk SYM_STRUCT of the function arguments' base_type 
passed to a SYM_FN.  Similarly so for struct-based variable declarations.

With that information, you can easily back-reference lvalue uses to the 
original struct.

	Jeff



