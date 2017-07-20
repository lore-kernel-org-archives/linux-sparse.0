From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 5/5] avoid crash with sym->bb_target == NULL
Date: Thu, 20 Jul 2017 06:57:02 -0400
Message-ID: <CANeU7QnKA8bJihFUC_f=_gcWg27QOQWLxDXd+MO9aYg33g_TVg@mail.gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com> <20170706191950.81268-6-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33821 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934348AbdGTK5D (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 20 Jul 2017 06:57:03 -0400
Received: by mail-pf0-f182.google.com with SMTP id q85so11085816pfq.1
        for <linux-sparse@vger.kernel.org>; Thu, 20 Jul 2017 03:57:03 -0700 (PDT)
In-Reply-To: <20170706191950.81268-6-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jul 6, 2017 at 3:19 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> +                       sym = expr->symbol;
> +                       if (sym->bb_target)
> +                               buf += sprintf(buf, ".L%u", sym->bb_target->nr);
You chould do:
bb = expr->symbol->target;
if (bb)
    buf +=  sprintf(buf, ".L%u", bb ? bb->nr);
else
    buf += sprintf(buf, ".L<invalid>");

It is up to you.

Chris
