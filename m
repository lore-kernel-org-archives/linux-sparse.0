From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH v2] sparse: add LLVM code generation backend
Date: Mon, 27 Apr 2009 21:21:30 -0400
Message-ID: <49F65A1A.50300@garzik.org>
References: <20090426205806.GA20933@havoc.gtf.org>	 <70318cbf0904271215o48ac3952ua0aca68a50cba16d@mail.gmail.com>	 <49F6342B.30605@garzik.org>	 <70318cbf0904271627w25df616di12e5b1454e89764f@mail.gmail.com>	 <49F64E9A.2030009@garzik.org> <70318cbf0904271804i4b8a14cbqfa62f521dc7258a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42357 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756227AbZD1BVc (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 27 Apr 2009 21:21:32 -0400
In-Reply-To: <70318cbf0904271804i4b8a14cbqfa62f521dc7258a3@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

Christopher Li wrote:
> On Mon, Apr 27, 2009 at 5:32 PM, Jeff Garzik <jeff@garzik.org> wrote:
>> Not true -- I can walk SYM_STRUCT of the function arguments' base_type
>> passed to a SYM_FN.  Similarly so for struct-based variable declarations.
>>
>> With that information, you can easily back-reference lvalue uses to the
>> original struct.
> 
> Let say I follow this route, isn't that you can apply the same trick for the
> linearize instruction case? struct instruction has a type member give a
> pointer to C type.
> 
> I still don't see a reason why you have to use your own AST recursive
> code.

You mean, besides the reasons already listed?  Namely, no upstream 
changes are required, and I already have something that works.

Sure, the same trick can be applied.  But that requires a total backend 
rewrite plus dealing with linearize obstacles already described (ref 
linearize_load_gen, linearize_store_gen).  Thus it is obviously a lot 
more work, with additional obstacles (patching upstream, which affects 
existing users), just get back to achieving the same result :)

	Jeff



