From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [PATCH 03/15] Add type information to struct instruction.
Date: Mon, 22 Dec 2008 19:21:19 -0800
Message-ID: <70318cbf0812221921q5e53a8edhad06369537dc3a6c@mail.gmail.com>
References: <20081215000849.16107.74332.stgit@zaytsev.su>
	 <20081215002610.16107.25437.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:51635 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902AbYLWDVU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Dec 2008 22:21:20 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2197081rvb.1
        for <linux-sparse@vger.kernel.org>; Mon, 22 Dec 2008 19:21:19 -0800 (PST)
In-Reply-To: <20081215002610.16107.25437.stgit@zaytsev.su>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: Josh Triplett <josh@kernel.org>, Blue Swirl <blauwirbel@gmail.com>, linux-sparse@vger.kernel.org, David Given <dg@cowlark.com>

I think this patch can have more discussion.

If possible, I would rather no increase the instruction struct size.
It is a very common structure, which responsible for a large part
of the byte code memory usage. There is only one person
(David) can benefit from it so far.

I think what David need is just distinction of int vs pointer.
We can do that by save an array of the known basic types.
Including the abstract pointer type. Then we just use an
index to the array rather than use the raw size directly.

That have the extra benefit of, different architecture can share
the same byte code.

Chris

On Sun, Dec 14, 2008 at 4:26 PM, Alexey Zaytsev
<alexey.zaytsev@gmail.com> wrote:
> From: David Given <dg@cowlark.com>
>
> Currently there is no generic way to derive phy
> type information from the instruction flow.
> ---
>  linearize.c |    4 +++-
>  linearize.h |    1 +
>  2 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/linearize.c b/linearize.c
> index fce1ae8..526a710 100644
> --- a/linearize.c
> +++ b/linearize.c
> @@ -55,7 +55,9 @@ static inline int type_size(struct symbol *type)
>
>  static struct instruction *alloc_typed_instruction(int opcode, struct symbol *type)
>  {
> -       return alloc_instruction(opcode, type_size(type));
> +       struct instruction *insn = alloc_instruction(opcode, type_size(type));
> +       insn->type = type;
> +       return insn;
>  }
>
>  static struct entrypoint *alloc_entrypoint(void)
> diff --git a/linearize.h b/linearize.h
> index 32b1c1a..0c5e4ef 100644
> --- a/linearize.h
> +++ b/linearize.h
> @@ -71,6 +71,7 @@ struct instruction {
>                 size:24;
>        struct basic_block *bb;
>        struct position pos;
> +       struct symbol *type;
>        union {
>                pseudo_t target;
>                pseudo_t cond;          /* for branch and switch */
>
>
