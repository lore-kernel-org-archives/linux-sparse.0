From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] graph: do not scan removed instructions
Date: Wed, 8 Nov 2017 02:54:17 +0800
Message-ID: <CANeU7QkG8NqyYWy6OmmDjaXXeS1iuZxrnbvG2CADd6qGpjL2Ow@mail.gmail.com>
References: <20171107105430.4810-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:56260 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbdKGSyS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Nov 2017 13:54:18 -0500
Received: by mail-yw0-f178.google.com with SMTP id t11so183353ywg.12
        for <linux-sparse@vger.kernel.org>; Tue, 07 Nov 2017 10:54:18 -0800 (PST)
In-Reply-To: <20171107105430.4810-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>

On Tue, Nov 7, 2017 at 6:54 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  graph.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/graph.c b/graph.c
> index 8cbc22027..c9af9a580 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -130,6 +130,8 @@ static void graph_calls(struct entrypoint *ep, int internal)
>                         continue;
>
>                 FOR_EACH_PTR(bb->insns, insn) {
> +                       if (!insn->bb)
> +                               continue;

Looks good to me.

Chris
