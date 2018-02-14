From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 3/5] IR: remove never-generated instructions
Date: Wed, 14 Feb 2018 22:48:19 +0100
Message-ID: <20180214214817.pvoijsfw3nbcbphq@ltop.local>
References: <20180214010843.23651-1-luc.vanoostenryck@gmail.com>
 <20180214010843.23651-4-luc.vanoostenryck@gmail.com>
 <CACXZuxc7dFwDPq56das5Q1p6hA9qW=C3QdppRf0cjHeeQcsnUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35871 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031408AbeBNVsY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 14 Feb 2018 16:48:24 -0500
Received: by mail-wm0-f53.google.com with SMTP id f3so24497784wmc.1
        for <linux-sparse@vger.kernel.org>; Wed, 14 Feb 2018 13:48:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxc7dFwDPq56das5Q1p6hA9qW=C3QdppRf0cjHeeQcsnUg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Feb 14, 2018 at 05:08:06AM +0000, Dibyendu Majumdar wrote:
> On 14 February 2018 at 01:08, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Some of the IR instructions have been defined but are
> > never generated.
> >
> > -### Unused ops
> > -#### OP_VANEXT
> > -#### OP_VAARG
> > -#### OP_MALLOC
> > -#### OP_FREE
> > -#### OP_ALLOCA
> > -#### OP_GET_ELEMENT_PTR
> > -#### OP_INVOKE
> > -#### OP_UNWIND
> 
> Hi Luc, I would argue for not removing some of these instructions.
> 
> The VA instructions are definitely needed as today Sparse backend code
> generators cannot handle var args because no instructions are
> generated.
> Similarly alloca should perhaps be emitted to indicate stack
> allocations - this would make the stack usage explicit.

Yes, backends need support for that. Be assured that I'm acutely
aware of it. What is present here is just some definitions with
nothing behind.

It should also be noted that:
- something like OP_VANEXT is not really needed (depending on how
  OP_VAARG is specified),
- we don't need a new instruction for sparse-llvm to be able to
  generate LLVM's alloca (our handling of symbol together with
  OP_SYMADDR is enough)

So these defines I propose here to remove are totally useless. I can
leave the definition of OP_VAARG but I prefer to reintroduce it when :
- its semantic will be specified and documented
- I'll add the code that will really use it.

Best regards,
-- Luc
