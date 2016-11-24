From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] lib: __builtin_object_size should accept void *
Date: Thu, 24 Nov 2016 08:16:24 +0800
Message-ID: <CANeU7Qm4Q7fawnTkGgsgQoiLJXwJLJng+4Y60+n5c_nbK-vRgQ@mail.gmail.com>
References: <1479932572-12543-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:35040 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933573AbcKXAQ0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Nov 2016 19:16:26 -0500
Received: by mail-io0-f195.google.com with SMTP id h133so3402130ioe.2
        for <linux-sparse@vger.kernel.org>; Wed, 23 Nov 2016 16:16:26 -0800 (PST)
In-Reply-To: <1479932572-12543-1-git-send-email-mst@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Josh Triplett <josh@kernel.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

A similar patch has been applied:

Chris

commit f2bf519e1da89779380fd781c0eb28aae415979d
Author: Lance Richardson <lrichard@redhat.com>
Date:   Wed Sep 21 10:13:58 2016 -0400

    sparse: update __builtin_object_size() prototype

    Sparse emits a large number of warnings for the linux kernel source
    tree of the form:
        ./arch/x86/include/asm/uaccess.h:735:18: \
            warning: incorrect type in argument 1 (different modifiers)
        ./arch/x86/include/asm/uaccess.h:735:18:    expected void *<noident>
        ./arch/x86/include/asm/uaccess.h:735:18:    got void const *from

    Fix by making the first parameter to __builtin_object_size()
    type "const void *" instead of "void *", which is consistent with GCC
    behavior (the prototype for this builtin in GCC documentation is evidently
    incorrect).

    Signed-off-by: Lance Richardson <lrichard@redhat.com>
    Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
    Signed-off-by: Christopher Li <sparse@chrisli.org>

diff --git a/lib.c b/lib.c
index d5b56b0..2d66aa0 100644
--- a/lib.c
+++ b/lib.c
@@ -888,7 +888,7 @@ void declare_builtin_functions(void)
        add_pre_buffer("extern long double __builtin_nanl(const char *);\n");

        /* And some __FORTIFY_SOURCE ones.. */
-       add_pre_buffer ("extern __SIZE_TYPE__
__builtin_object_size(void *, int);\n");
+       add_pre_buffer ("extern __SIZE_TYPE__
__builtin_object_size(const void *, int);\n");
        add_pre_buffer ("extern void * __builtin___memcpy_chk(void *,
const void *, __SIZE_TYPE__, __SIZE_TYPE__);\n");
        add_pre_buffer ("extern void * __builtin___memmove_chk(void *,
const void *, __SIZE_TYPE__, __SIZE_TYPE__);\n");
        add_pre_buffer ("extern void * __builtin___mempcpy_chk(void *,
const void *, __SIZE_TYPE__, __SIZE_TYPE__);\n");



On Thu, Nov 24, 2016 at 4:24 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> I'm seeing these warnings with current Linux:
> ./arch/x86/include/asm/uaccess.h:705:18: warning: incorrect type in argument 1 (different modifiers)
> ./arch/x86/include/asm/uaccess.h:705:18:    expected void *<noident>
> ./arch/x86/include/asm/uaccess.h:705:18:    got void const *from
>
> Because of this code:
>
> static __always_inline unsigned long __must_check
> copy_to_user(void __user *to, const void *from, unsigned long n)
> {
>         int sz = __compiletime_object_size(from);
>
> ...
> }
>
> where we have
>
> # define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
>
> to fix, mark the argument as const void *.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> Sorry if this has already been reported/fixed.
>
>  lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib.c b/lib.c
> index d5b56b0..2d66aa0 100644
> --- a/lib.c
> +++ b/lib.c
> @@ -888,7 +888,7 @@ void declare_builtin_functions(void)
>         add_pre_buffer("extern long double __builtin_nanl(const char *);\n");
>
>         /* And some __FORTIFY_SOURCE ones.. */
> -       add_pre_buffer ("extern __SIZE_TYPE__ __builtin_object_size(void *, int);\n");
> +       add_pre_buffer ("extern __SIZE_TYPE__ __builtin_object_size(const void *, int);\n");
>         add_pre_buffer ("extern void * __builtin___memcpy_chk(void *, const void *, __SIZE_TYPE__, __SIZE_TYPE__);\n");
>         add_pre_buffer ("extern void * __builtin___memmove_chk(void *, const void *, __SIZE_TYPE__, __SIZE_TYPE__);\n");
>         add_pre_buffer ("extern void * __builtin___mempcpy_chk(void *, const void *, __SIZE_TYPE__, __SIZE_TYPE__);\n");
> --
> MST
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
