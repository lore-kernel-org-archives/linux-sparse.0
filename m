From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] OP_SWITCH should use 'insn->cond' instead of 'insn->target'
Date: Wed, 23 Nov 2016 09:16:57 +0800
Message-ID: <CANeU7QmTuzPMY2+6yk2zjaxYWx6BXvq=MU-bv-+r48pRnkXhtw@mail.gmail.com>
References: <20161122163233.3765-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:33833 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756435AbcKWBQ7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Nov 2016 20:16:59 -0500
Received: by mail-io0-f181.google.com with SMTP id c21so90741285ioj.1
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2016 17:16:58 -0800 (PST)
In-Reply-To: <20161122163233.3765-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@looxix.net>

On Wed, Nov 23, 2016 at 12:32 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> From: Luc Van Oostenryck <luc.vanoostenryck@looxix.net>
>
> show_instruction() uses the field 'target' to display OP_SWITCH
> instruction instead of 'cond' like OP_BR does.
> It doesn't change anything since these two fields use the same
> storage inside struct instruction but better to use the right field
> to keep consistent.

Looks good to me. Will apply.

Chris
