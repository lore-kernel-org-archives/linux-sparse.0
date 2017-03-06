From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 07/13] llvm: fix output OP_ADD mixed with pointers
Date: Mon, 6 Mar 2017 20:52:35 +0100
Message-ID: <20170306195234.dqrbqs4owehwipdl@macpro.local>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
 <20170305112047.3411-8-luc.vanoostenryck@gmail.com>
 <CANeU7Qk6xjhNPVZWxTB4iOavH5=bha+a_utz7+PJuSTo1WKgOg@mail.gmail.com>
 <CACXZuxfX0TiYGJDewbRW9Tr3-nzqiBrdOK0K+mO0qqwyGCrjSQ@mail.gmail.com>
 <CANeU7Q=Y7mx501ZAvXesWCL_C92RsjQvFNJ_4dLvUeOg2chFhg@mail.gmail.com>
 <20170306164306.hibukuy2t4j4camh@macpro.local>
 <CANeU7QnS2_OgvaZo1T+_cfw=ZKFvZEM8dnMet4kfqhTzGWUDHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37221 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932368AbdCFUAA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Mar 2017 15:00:00 -0500
Received: by mail-wm0-f50.google.com with SMTP id n11so74124841wma.0
        for <linux-sparse@vger.kernel.org>; Mon, 06 Mar 2017 11:59:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QnS2_OgvaZo1T+_cfw=ZKFvZEM8dnMet4kfqhTzGWUDHQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 07, 2017 at 01:07:27AM +0800, Christopher Li wrote:
> On Tue, Mar 7, 2017 at 12:43 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > With an example:
> > == C code ==
> >         void *foo(int *p) { return p + 5; }
> >
> > == linearized code ==
> >         foo:
> >         .L0:
> >                 <entry-point>
> >                 add.64      %r2 <- %arg1, $20
> >                 cast.64     %r3 <- (64) %r2
> >                 ret.64      %r3
> >
> > == LLVM code from sparse-llvm ==
> >         ; ModuleID = '<stdin>'
> >         source_filename = "sparse"
> >
> >         define i8* @foo(i32* %ARG1) {
> >         L0:
> >           %0 = getelementptr i32, i32* %ARG1, inttoptr (i64 20 to i32*)
> >           %R3 = bitcast i32* %0 to i8*
> >           ret i8* %R3
> >         }
> >
> 
> 
> OK, good. Let's use this example.
> I am using clang to get the llvm bytecode. t.c is your example.
> 
> clang -S -emit-llvm /tmp/t.c
> Here is output, compare the line I am pointing at:
> The indices should be 5 according clang's output.
> However sparse-llvm generate as 20 per your output
> if I am reading it correctly.

Absolutely.

-- Luc 
