From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 17/29] ptrmap: core implementation
Date: Fri, 18 Aug 2017 17:02:41 -0400
Message-ID: <CANeU7Q=KQOca4VAWurnkCUuRsGvVM-GDTBrdiee9h0ePqGoCKw@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com> <20170816153455.97693-18-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:37160 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751586AbdHRVCm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 17:02:42 -0400
Received: by mail-yw0-f196.google.com with SMTP id s143so6629965ywg.4
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 14:02:42 -0700 (PDT)
In-Reply-To: <20170816153455.97693-18-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Aug 16, 2017 at 11:34 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The implementation done in this patch is a very simple one
> based on list of blocks of key-value pairs.
>
> The idea being to later switch to a dynamic structure using
> a hash-table as soon as the number of element reach some threshold.
> However, these hash-table are only needed for some huge
> and artificial input files.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  Makefile |  1 +
>  ptrmap.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  ptrmap.h | 12 ++++++++++
>  3 files changed, 97 insertions(+)
>  create mode 100644 ptrmap.c
>  create mode 100644 ptrmap.h
>
> diff --git a/Makefile b/Makefile
> index 48e1f508f..762aee505 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -117,6 +117,7 @@ LIB_OBJS= target.o parse.o tokenize.o pre-process.o symbol.o lib.o scope.o \
>           expression.o show-parse.o evaluate.o expand.o inline.o linearize.o \
>           char.o sort.o allocate.o compat-$(OS).o ptrlist.o \
>           builtin.o \
> +         ptrmap.o \
>           stats.o \
>           flow.o cse.o simplify.o memops.o liveness.o storage.o unssa.o dissect.o
>
> diff --git a/ptrmap.c b/ptrmap.c
> new file mode 100644
> index 000000000..2a08380c9
> --- /dev/null
> +++ b/ptrmap.c
> @@ -0,0 +1,84 @@
> +#include "ptrmap.h"
> +#include "allocate.h"
> +#include <stddef.h>
> +
> +#define        MAP_NR  7
> +
> +struct ptrpair {
> +       void *key;
> +       void *val;
> +};
> +struct ptrmap {
> +       struct ptrmap *next;
> +       int nr;
> +       struct ptrpair pairs[MAP_NR];
> +};

If you are going for simple. why not just make
struct ptrpair as allocatable object then have
struct ptrpair_list as normal ptrlist?

The add would be normal ptrlist add.
The lookup is just FOREACH_PTR loop.
The update is lookup then change the value.

That could safe you some code. The difference
will be, your current ptrlist has better cache
behavior. But if you care that much then it should
move to hash implementation


Chris
