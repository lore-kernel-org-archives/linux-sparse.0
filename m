From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Best way to inspect the parse tree from Sparse
Date: Mon, 7 Aug 2017 20:46:54 +0200
Message-ID: <20170807184653.a6xtjfbutnsnecnf@ltop.local>
References: <CACXZuxdB3HKmTvh8Xa41OD+3-R4_Hx5g8OqS_D6H093Etb0y2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37271 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751429AbdHGSq5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 14:46:57 -0400
Received: by mail-wm0-f54.google.com with SMTP id t201so13815095wmt.0
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 11:46:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxdB3HKmTvh8Xa41OD+3-R4_Hx5g8OqS_D6H093Etb0y2Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 07, 2017 at 04:11:43PM +0100, Dibyendu Majumdar wrote:
> Hi,
> 
> I would like to understand the structure of the parse tree generated
> by Sparse a bit better. I am looking at the output from the show_*()
> functions but it is not clear to me exactly what the output means. For
> example:
> 
> extern int printf(const char *, ...);
> 
> int main(int argc, const char *argv[]) {
> printf("hello world!\n");
> return 0;
> }
> 
> Results in:
> 
> .align 4
> int extern [signed] [addressable] [toplevel] main( ... )
>         movi.64         v2,&"hello world!\n"
>         push.64         v2
>         call            printf
>         add.64          vSP,vSP,$8
>         mov.32          v3,retval
>         movi.32         v4,$0
>         addi.64         v5,vFP,$offsetof(return:00000202755B1A98)
>         st.32           v4,[v5]
>         ret             (00000202755B1A98)
> .L00000202755B1A98:
>         addi.64         v6,vFP,$offsetof(return:00000202755B1A98)
>         ld.32           v7,[v6]
>         mov.32          retval,7
>         ret
> 
> 
> I get the first four lines, but the rest don't make sense to me.

The 'vFP' is the (virtual) Frame Pointer and the $offsetof() is
the offset to where the variable is stored in the frame.
'retval' seems to be a pseudo-register used for the return value
of function calls and 'return' seems to be a pseudo-variable holding
the return value.

So v3 hold the return value of the printf() (and is ignored) then
0 is stored in the 'return' pseudo-variable and is read-back just
after to be returned by the function.


> I suppose that the dump is trying to show the parse tree in a linear
> form ...  but is that useful? Would it be better to dump the parse
> tree in a different form?

Yes, I think so too.
I only tried it a few time and it wasn't at all helping me.
The parsing tree is all about the statements and the expressions,
so I always end to look directly at the code.
I dunno about the inspect & dissect tools.

-- Luc
