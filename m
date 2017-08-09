From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH v4 2/9] Remove single-store shortcut
Date: Wed, 9 Aug 2017 20:47:57 +0100
Message-ID: <CACXZuxejN5zBn4NN7XXmGhM26NJMiGAutW7+csb7kVPjWZRVLg@mail.gmail.com>
References: <CANeU7Qk99kn3etn8yoEKKFzcW15wHjt7OYPSpZhqCDc4DE3EDQ@mail.gmail.com>
 <20170809193806.30975-1-luc.vanoostenryck@gmail.com> <20170809193806.30975-3-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:34610 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752813AbdHITr6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 15:47:58 -0400
Received: by mail-ua0-f194.google.com with SMTP id k43so4421726uaf.1
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 12:47:57 -0700 (PDT)
In-Reply-To: <20170809193806.30975-3-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

Hi Luc,

This this change independent of the rest of changes in the series -
i.e. can I just apply this change?

Regards
Dibyendu

On 9 August 2017 at 20:37, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Current sparse code doesn't handle very gracefully
> code with undefined pseudos. These can occurs, of
> course because the dev has not initialize them,
> maybe by error, but they can also occurs when they
> are only set (and used) in a single path or even worse,
> hen initiializing a bitfield.
>
> The origin of the problem is the single store shortcut
> in simplify_one_symbol() which doesn't take in account
> the (absence of) dominance when loads exist without
> stores.
>
> Fix this by removing this single-store shortcut and leave
> all the work for the general case which handle this
> situation quite well (and/but set those variables to 0).
>
> Warning: this change impact the performance.
>
> Note: this patch will also avoid internal infinite loops
>       occuring when processing undefined vars present
>       during the SSA construction.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  flow.c                      | 39 ++-------------------------------------
>  validation/infinite-loop0.c |  1 -
>  2 files changed, 2 insertions(+), 38 deletions(-)
>
> diff --git a/flow.c b/flow.c
> index c7161d47e..5a3d55f76 100644
> --- a/flow.c
> +++ b/flow.c
> @@ -650,11 +650,10 @@ void check_access(struct instruction *insn)
>
>  static void simplify_one_symbol(struct entrypoint *ep, struct symbol *sym)
>  {
> -       pseudo_t pseudo, src;
> +       pseudo_t pseudo;
>         struct pseudo_user *pu;
> -       struct instruction *def;
>         unsigned long mod;
> -       int all, stores, complex;
> +       int all;
>
>         /* Never used as a symbol? */
>         pseudo = sym->pseudo;
> @@ -670,17 +669,12 @@ static void simplify_one_symbol(struct entrypoint *ep, struct symbol *sym)
>         if (mod)
>                 goto external_visibility;
>
> -       def = NULL;
> -       stores = 0;
> -       complex = 0;
>         FOR_EACH_PTR(pseudo->users, pu) {
>                 /* We know that the symbol-pseudo use is the "src" in the instruction */
>                 struct instruction *insn = pu->insn;
>
>                 switch (insn->opcode) {
>                 case OP_STORE:
> -                       stores++;
> -                       def = insn;
>                         break;
>                 case OP_LOAD:
>                         break;
> @@ -697,37 +691,8 @@ static void simplify_one_symbol(struct entrypoint *ep, struct symbol *sym)
>                 default:
>                         warning(sym->pos, "symbol '%s' pseudo used in unexpected way", show_ident(sym->ident));
>                 }
> -               complex |= insn->offset;
>         } END_FOR_EACH_PTR(pu);
>
> -       if (complex)
> -               goto complex_def;
> -       if (stores > 1)
> -               goto multi_def;
> -
> -       /*
> -        * Goodie, we have a single store (if even that) in the whole
> -        * thing. Replace all loads with moves from the pseudo,
> -        * replace the store with a def.
> -        */
> -       src = VOID;
> -       if (def)
> -               src = def->target;
> -
> -       FOR_EACH_PTR(pseudo->users, pu) {
> -               struct instruction *insn = pu->insn;
> -               if (insn->opcode == OP_LOAD) {
> -                       check_access(insn);
> -                       convert_load_instruction(insn, src);
> -               }
> -       } END_FOR_EACH_PTR(pu);
> -
> -       /* Turn the store into a no-op */
> -       kill_store(def);
> -       return;
> -
> -multi_def:
> -complex_def:
>  external_visibility:
>         all = 1;
>         FOR_EACH_PTR_REVERSE(pseudo->users, pu) {
> diff --git a/validation/infinite-loop0.c b/validation/infinite-loop0.c
> index a28492307..0e3e3805c 100644
> --- a/validation/infinite-loop0.c
> +++ b/validation/infinite-loop0.c
> @@ -8,5 +8,4 @@ void foo(void)
>   * check-name: internal infinite loop (0)
>   * check-command: sparse -Wno-decl $file
>   * check-timeout:
> - * check-known-to-fail
>   */
> --
> 2.14.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
