From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/2] fix: evaluate_dereference() unexamined base type
Date: Mon, 27 Nov 2017 01:48:01 +0800
Message-ID: <CANeU7QkDYorh5B=5nJ8sQjzvJcwHuzv+hjM3bAFtG90k2_1AxA@mail.gmail.com>
References: <20171125093115.95791-1-luc.vanoostenryck@gmail.com> <20171125093115.95791-3-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yb0-f173.google.com ([209.85.213.173]:39369 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbdKZRsC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 26 Nov 2017 12:48:02 -0500
Received: by mail-yb0-f173.google.com with SMTP id n185so9524715yba.6
        for <linux-sparse@vger.kernel.org>; Sun, 26 Nov 2017 09:48:02 -0800 (PST)
In-Reply-To: <20171125093115.95791-3-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Nov 25, 2017 at 5:31 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Examination of a pointer type doesn't examine the corresponding base type
> (this base type maybe not yet be complete).
> The examination of thz base type must thus be done later.
>
> However, in some cases (maybe only when typeof() is involved) it's
> possible to call evaluate_dereference() while the base type is still
> unexamined.
>
> Fix this by adding the missing examine_symbol_type() on the base type.

The changes looks fine to me.

Will this show up as some thing easy pull-able for
sparse master?

Chris
