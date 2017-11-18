From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/4] floating-point specific instructions
Date: Sat, 18 Nov 2017 15:27:32 +0100
Message-ID: <CAExDi1SsChYg=WmB1gxbNJDcG+O71fLWv8OGV7UbMA6U7BdMiA@mail.gmail.com>
References: <20170328141829.21421-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:40676 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761448AbdKRO1d (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Nov 2017 09:27:33 -0500
Received: by mail-it0-f42.google.com with SMTP id 72so7212802itl.5
        for <linux-sparse@vger.kernel.org>; Sat, 18 Nov 2017 06:27:33 -0800 (PST)
In-Reply-To: <20170328141829.21421-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 28, 2017 at 4:18 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Floating-point arithmetic is quite different from arithmetic
> on integers (or on real numbers). In particular,
> most transformations, simplifications that can be done on integers
> are invalid when done on floats.
>
> Since they don't follow the same rules as their integer
> counterpart, better to give a specific opcode to floating-point
> operations instead of having to test the type of the operands at
> each manipulation.
>

This has now been pushed this to my dev tree at:
        git://github.com/lucvoo/sparse.git master

By excluding the floating-point operations from the integer ones,
this fixes a whole class of problems with illegal simplification of
float operations.

This ends the first batch of essential fixes I wanted to be integrated.

-- Luc
