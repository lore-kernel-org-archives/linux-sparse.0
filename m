From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2 1/3] memcpy()'s byte count is unsigned
Date: Mon, 5 Jun 2017 13:52:37 -0700
Message-ID: <CANeU7QmDHd4mZNZyaYVvJ0LPykUNbH3H1TEELZhYYDp=Ob_sMg@mail.gmail.com>
References: <20170603074727.66945-1-luc.vanoostenryck@gmail.com> <20170603074727.66945-2-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:35403 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751188AbdFEUwi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 5 Jun 2017 16:52:38 -0400
Received: by mail-it0-f45.google.com with SMTP id m62so74456669itc.0
        for <linux-sparse@vger.kernel.org>; Mon, 05 Jun 2017 13:52:38 -0700 (PDT)
In-Reply-To: <20170603074727.66945-2-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

On Sat, Jun 3, 2017 at 12:47 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The checker part of sparse does some checking on memcpy(),
> memset(), copy_{from,to}_user() byte count and warn if the
> value is known to be too large. The comparison is done with
> signed numbers and it also warns if the value is negative.


I see you have the V1 in git tree in the 0/3 email.

Do you have the V2 in the git tree some where as well?
I can't seem to find the V2 version of the 0/3 email.

Chris
