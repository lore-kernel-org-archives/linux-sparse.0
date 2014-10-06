From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v3] sparse: treat function pointers as pointers to const data
Date: Mon, 6 Oct 2014 16:44:47 +0200
Message-ID: <CAKv+Gu-jTrCnhuS0GEkifj1rA0gjh=cLLEXO9GLxNdw6ctn-Ug@mail.gmail.com>
References: <1410157803-3658-1-git-send-email-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:40498 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbaJFOot (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 6 Oct 2014 10:44:49 -0400
Received: by mail-la0-f43.google.com with SMTP id mc6so4512403lab.2
        for <linux-sparse@vger.kernel.org>; Mon, 06 Oct 2014 07:44:47 -0700 (PDT)
In-Reply-To: <1410157803-3658-1-git-send-email-ard.biesheuvel@linaro.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org, linux-sparse@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On 8 September 2014 08:30, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> This code snippet:
>
> static void bar(void const *arg)
> {
>         int (*foo)(void) = arg;
> }
>
> produces the following warning:
>
> test.c:4:28: warning: incorrect type in initializer (different modifiers)
> test.c:4:28:    expected int ( *foo )( ... )
> test.c:4:28:    got void const *arg
>
> which is caused by the fact that the function pointer 'foo' is not annotated
> as being a pointer to const data. However, dereferencing a function pointer
> does not produce an lvalue, so a function pointer points to const data by
> definition, and we should treat it accordingly.
>
> To avoid producing a warning on the inverse case, i.e.,
>
> static void bar(void)
> {
>         void *foo = bar;
> }
>
> we only address the case where the function pointer is the target of
> an assignment.
>
> Reviewed-by: Josh Triplett <josh@joshtriplett.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v3: add rationale for restriction to assignments to commit message
>     add R-b
>
> v2: only treat function pointers as pointers to const data when they are the
>     target of an assignment
>
>  evaluate.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/evaluate.c b/evaluate.c
> index 66556150ddac..a5a830978bda 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -1359,6 +1359,15 @@ static int compatible_assignment_types(struct expression *expr, struct symbol *t
>                                 typediff = "different address spaces";
>                                 goto Err;
>                         }
> +                       /*
> +                        * If this is a function pointer assignment, it is
> +                        * actually fine to assign a pointer to const data to
> +                        * it, as a function pointer points to const data
> +                        * implicitly, i.e., dereferencing it does not produce
> +                        * an lvalue.
> +                        */
> +                       if (b1->type == SYM_FN)
> +                               mod1 |= MOD_CONST;
>                         if (mod2 & ~mod1) {
>                                 typediff = "different modifiers";
>                                 goto Err;
> --
> 1.8.3.2
>

Ping?
