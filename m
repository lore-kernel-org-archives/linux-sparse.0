From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 4/4] V2 fix warnings report by selfcheck
Date: Tue, 18 Jul 2017 17:37:49 +0100
Message-ID: <1a921c9b-2e3f-3d3c-99de-b3cc71b5c700@ramsayjones.plus.com>
References: <CANeU7QmR-XJ2AiuXKiRgh4Ytf30LDDbYd8_qQoq3qXiPasDawg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:39691 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbdGRQhw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 18 Jul 2017 12:37:52 -0400
In-Reply-To: <CANeU7QmR-XJ2AiuXKiRgh4Ytf30LDDbYd8_qQoq3qXiPasDawg@mail.gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>



On 18/07/17 03:56, Christopher Li wrote:
> Signed-off-by: Christopher Li <sparse@chrisli.org>
> ---
>  ast-model.c | 2 +-
>  ast-view.c  | 3 ++-
>  lib.h       | 1 +
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/ast-model.c b/ast-model.c
> index 704c487..63d2762 100644
> --- a/ast-model.c
> +++ b/ast-model.c
> @@ -59,7 +59,7 @@ AstNode* ast_nth_child(AstNode *node, int n)
>   inspect_child_node(node);
> 
>   if (n >= node->childnodes->len)
> - return FALSE;
> + return NULL;
>   return g_array_index(node->childnodes, AstNode *, n);
>  }
> 
> diff --git a/ast-view.c b/ast-view.c
> index c2b3963..22aba11 100644
> --- a/ast-view.c
> +++ b/ast-view.c
> @@ -2,8 +2,9 @@
>  #include <stdlib.h>
>  #include "ast-model.h"
>  #include "ast-inspect.h"
> +#include "ast-view.h"
> 
> -GtkWidget *
> +static GtkWidget *
>  create_view_and_model (void *ptr)
>  {
>   GtkTreeViewColumn   *text;
> diff --git a/lib.h b/lib.h
> index 3f8d361..c90e0e3 100644

I didn't see any warnings related to the above, no doubt
because I don't have libxml and libgtk2 installed (or llvm
on Linux).

I did have the fix below, of course.

ATB,
Ramsay Jones

> --- a/lib.h
> +++ b/lib.h
> @@ -150,6 +150,7 @@ extern int fdump_linearize;
>  extern unsigned long long fmemcpy_max_count;
> 
>  extern int arch_m64;
> +extern int arch_msize_long;
>  extern int arch_big_endian;
> 
>  extern void declare_builtin_functions(void);
> 
