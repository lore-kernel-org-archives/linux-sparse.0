From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v4 00/63] LLVM fixes
Date: Tue, 21 Mar 2017 14:00:44 +0100
Message-ID: <20170321130043.usyby3sfb6oiln6k@macbook.local>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
 <CACXZuxdcgnhBwnaS9nDqh47KrpkqEu11SB6FXGTebpBPZ1GZ-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33878 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757235AbdCUNAv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 21 Mar 2017 09:00:51 -0400
Received: by mail-wr0-f180.google.com with SMTP id l37so111612760wrc.1
        for <linux-sparse@vger.kernel.org>; Tue, 21 Mar 2017 06:00:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxdcgnhBwnaS9nDqh47KrpkqEu11SB6FXGTebpBPZ1GZ-A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Tue, Mar 21, 2017 at 11:24:57AM +0000, Dibyendu Majumdar wrote:
> Hi Luc,
> 
> On 21 March 2017 at 00:15, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > This series solves a number of issues in sparse-llvm,
> > mainly about wrong or missing type information as needed
> > to build LLVM IR.
> >
> >
> >   llvm: add test cases for symbol's address
> >   llvm: add test cases for pointers passed as argument
> >   llvm: add test cases for arrays passed as argument
> >   llvm: add test cases for degenerated pointers
> >   llvm: add support for OP_NEG
> >   llvm: add support for OP_SETVAL with floats
> >   llvm: add support for OP_SETVAL with labels
> 
> Thank you once again for posting this set of patches. I wanted to
> understand what your approach is with testing of the LLVM backend in
> general. The test cases that are currently present and also the new
> ones you are adding do not appear to be runnable. Unless you are
> saving expected LLVM IR output and comparing the test output with that
> I think the tests do not prove that the generated code is correct.

I'm not surprised at all that some of the test cases, new or old,
are not runnable (I suppose that you mean that their execution
produce wrong result).

It's a bit too early for me to look closely at the generated code,
there was simply too much input code that caused crashes, triggered
some asserts or produced type error in the LLVM IR. And it's not
like everything is now solved regarding this.

For the next steps, yes, it would certainly be needed to have tests
for the correctness of the generated code. And by 'tests' I mean
'test cases suitable and present in sparse's test suite'.
I was somehow expecting you will submit them/somes as you seem
quite interested in sparse/LLVM.


-- Luc
