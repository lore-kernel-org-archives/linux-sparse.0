From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] remove warning "call with no type"
Date: Sat, 10 Feb 2018 11:00:26 -0800
Message-ID: <CANeU7Qnp+3nLjE7AZ=tMOA4OmjEa3j_XQe6UgUHd2_e5W4fTiA@mail.gmail.com>
References: <20180131104043.3345-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36661 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeBJTA2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Feb 2018 14:00:28 -0500
Received: by mail-qk0-f181.google.com with SMTP id 15so14029416qkl.3
        for <linux-sparse@vger.kernel.org>; Sat, 10 Feb 2018 11:00:27 -0800 (PST)
In-Reply-To: <20180131104043.3345-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Jan 31, 2018 at 2:40 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This warning is issued when trying to linearize a call
> expressions with a null expr->ctype but such null ctype
> is a consequence of an error detected during evaluation
> and this error must already have issued a warning or an
> error message specific to the problem.
>
> In short, this "call with no type" is non-informative
> and redundant, so avoid usless noise and remove this
> warning.

The change looks fine to me. This the change assume the
expr->ctype be NULL is result of an error and has been reported
before. I am sure that assumption holds for most of the cases. Not
sure it holds for all corner cases. On the other hand, if the expr->ctype
is NULL, it is already screwed, change it to VOID is not too bad.

Chris
