From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Output from linearize and LLVM error
Date: Fri, 27 Jan 2017 15:09:17 +0000
Message-ID: <CACXZuxcwfTFFEpLmopuRgv-bTYQQ5SYUoKQniTSAE_VYEdKRQg@mail.gmail.com>
References: <CACXZuxdM0zwfubUxHTJDen456-y9cpgpQJBcB8gKoXYtX5baSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:32990 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755046AbdA0PKM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Jan 2017 10:10:12 -0500
Received: by mail-vk0-f44.google.com with SMTP id k127so176645806vke.0
        for <linux-sparse@vger.kernel.org>; Fri, 27 Jan 2017 07:09:18 -0800 (PST)
In-Reply-To: <CACXZuxdM0zwfubUxHTJDen456-y9cpgpQJBcB8gKoXYtX5baSA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

On 27 January 2017 at 14:00, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> struct foo {
>         int i;
> };
> typedef struct foo foo;
> foo*  testfunc(void);
> foo* testfunc(void) {
>         foo *p = (foo *) malloc(sizeof(struct foo));
>         return p;
> }
>
> Here is the output from test-linearize:
>
> testfunc:
> .L0x7ffae85d1010:
>  <entry-point>
>  call.64     %r1 <- malloc, $4
>  cast.64     %r2 <- (64) %r1
>  ret.64      %r2
>
> The second LLVM assertion failure occurs in the cast to (64).
>

In linearize.c:

static struct instruction *alloc_cast_instruction(struct symbol *src,
struct symbol *ctype)
{
 int opcode = OP_CAST;
 struct symbol *base = src;
 if (base->ctype.modifiers & MOD_SIGNED)
  opcode = OP_SCAST;
 if (base->type == SYM_NODE)
  base = base->ctype.base_type;
 if (base->type == SYM_PTR) {
  base = base->ctype.base_type;
  if (base != &void_ctype)
   opcode = OP_PTRCAST;
 }
 if (base->ctype.base_type == &fp_type)
  opcode = OP_FPCAST;
 return alloc_typed_instruction(opcode, ctype);
}

So if base->type is SYM_PTR but base->c.type.base_type is not void
then the cast instruction is left as OP_CAST, but it should be
OP_PTRCAST regardless?

Thanks and Regards
Dibyendu
