From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 06/13] llvm: fix type of literal integer passed as arguments
Date: Mon, 6 Mar 2017 22:56:29 +0800
Message-ID: <CANeU7Qn7XP18dexKFNiD34SFEATVMEQ8TJ=jV3DFeAyr_O58AQ@mail.gmail.com>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com> <20170305112047.3411-7-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:34526 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753105AbdCFPFJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Mar 2017 10:05:09 -0500
Received: by mail-it0-f65.google.com with SMTP id r141so9818223ita.1
        for <linux-sparse@vger.kernel.org>; Mon, 06 Mar 2017 07:04:38 -0800 (PST)
In-Reply-To: <20170305112047.3411-7-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>

On Sun, Mar 5, 2017 at 7:20 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Like for all others instructions, LLVM needs the type
> of each operands. However this information is not always
> available via the pseudo, like here when passing a integer
> constant as argument since for sparse constants are typeless.
>
> Fix this by getting the type via the function prototype.
>
> Reported-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  sparse-llvm.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/sparse-llvm.c b/sparse-llvm.c
> index c593f831f..27cc1b88c 100644
> --- a/sparse-llvm.c
> +++ b/sparse-llvm.c
> @@ -740,7 +740,16 @@ static void output_op_call(struct function *fn, struct instruction *insn)

Adding CC to Jeff Garzik,

I notice a near by line in the same function does:

FOR_EACH_PTR(insn->arguments, arg) {
                  n_arg++;
} END_FOR_EACH_PTR(arg);

Shouldn't it just use ptr_list_size() instead?

>
>         i = 0;
>         FOR_EACH_PTR(insn->arguments, arg) {
> -               args[i++] = pseudo_to_value(fn, insn, arg);
> +               LLVMValueRef value;
> +               if (arg->type == PSEUDO_VAL) {
> +                       /* Value pseudos do not have type information. */
> +                       /* Use the function prototype to get the type. */
> +                       struct symbol *ctype = get_nth1_arg(insn->func->sym, i + 1);

Here is an usage case of iterate through two separate list in order.
You can use PREPARE_PTR_LIST() and NEXT_PTR_LIST()
with FOR_EACH_PTR() to iterate the ins->func->sym list in order.

You can take a look at evaluate.c how to use PREPARE_PTR_LIST
with FOR_EACH_PTR().  e.g. evaluate.c::evaluate_arguments().

If we use get_nth1_arg here. We are effectively using two for loops.
The outer loop count from one to nth argument. The inner loop in
get_nth1_arg() count from one to nth argument again.

Using PREPARE_PTR_LIST(), it has just one loop.

Chris
