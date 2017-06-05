From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2 0/8] division-by-zero warnings
Date: Mon, 5 Jun 2017 12:16:36 -0700
Message-ID: <CANeU7Q=7N7vByUq9zYwDQoHQzRShW1mWDFdhtMJ7ut96phNuhA@mail.gmail.com>
References: <20170603080135.46477-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:36471 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbdFETQm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 5 Jun 2017 15:16:42 -0400
Received: by mail-it0-f46.google.com with SMTP id m47so72169273iti.1
        for <linux-sparse@vger.kernel.org>; Mon, 05 Jun 2017 12:16:42 -0700 (PDT)
In-Reply-To: <20170603080135.46477-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Jun 3, 2017 at 1:01 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The goal of this series is to add the 'division by zero'
> warnings that are missing. Indeed, sparse only warned about
> division by zero when the LHS was a constant. When the LHS
> was not a constant (and thus also when the division was part
> of a compound assignement) no warning was ever issued.

This series looks fine to me.

Signed-off-By: Chris Li <sparse@chrisli.org>

Chris
