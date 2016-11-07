From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] sparse: update __builtin_object_size() prototype
Date: Mon, 7 Nov 2016 11:09:35 +0100
Message-ID: <20161107100934.GB443@macbook.home>
References: <1474467238-20939-1-git-send-email-lrichard@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36061 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbcKGKJi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Nov 2016 05:09:38 -0500
Received: by mail-wm0-f68.google.com with SMTP id c17so15518213wmc.3
        for <linux-sparse@vger.kernel.org>; Mon, 07 Nov 2016 02:09:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1474467238-20939-1-git-send-email-lrichard@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Lance Richardson <lrichard@redhat.com>, Johannes Berg <johannes@sipsolutions.net>

On Wed, Sep 21, 2016 at 10:13:58AM -0400, Lance Richardson wrote:
> Sparse emits a large number of warnings for the linux kernel source
> tree of the form:
>     ./arch/x86/include/asm/uaccess.h:735:18: \
>         warning: incorrect type in argument 1 (different modifiers)
>     ./arch/x86/include/asm/uaccess.h:735:18:    expected void *<noident>
>     ./arch/x86/include/asm/uaccess.h:735:18:    got void const *from
> 
> Fix by making the first parameter to __builtin_object_size()
> type "const void *" instead of "void *", which is consistent with GCC
> behavior (the prototype for this builtin in GCC documentation is evidently
> incorrect).
> 
> Signed-off-by: Lance Richardson <lrichard@redhat.com>
> ---
>  lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib.c b/lib.c
> index aa2af68..122dd6f 100644
> --- a/lib.c
> +++ b/lib.c
> @@ -917,7 +917,7 @@ void declare_builtin_functions(void)
>  	add_pre_buffer("extern long double __builtin_nanl(const char *);\n");
>  
>  	/* And some __FORTIFY_SOURCE ones.. */
> -	add_pre_buffer ("extern __SIZE_TYPE__ __builtin_object_size(void *, int);\n");
> +	add_pre_buffer ("extern __SIZE_TYPE__ __builtin_object_size(const void *, int);\n");
>  	add_pre_buffer ("extern void * __builtin___memcpy_chk(void *, const void *, __SIZE_TYPE__, __SIZE_TYPE__);\n");
>  	add_pre_buffer ("extern void * __builtin___memmove_chk(void *, const void *, __SIZE_TYPE__, __SIZE_TYPE__);\n");
>  	add_pre_buffer ("extern void * __builtin___mempcpy_chk(void *, const void *, __SIZE_TYPE__, __SIZE_TYPE__);\n");
> -- 

Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>


Chris, can you please take this patch (or Johannes' one).
When compiling the kernel, there is more than 2000 false warnings
only for the uaccess.h case described here above.

Luc
