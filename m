From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/2] warn on implicit type
Date: Wed, 7 Jun 2017 23:16:27 -0700
Message-ID: <CANeU7Qny5i4TDMWihLv9CnPXWTpVsZfZXG8dqUR3USYTsJZpNA@mail.gmail.com>
References: <20170608024736.49780-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:32895 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750919AbdFHGQ3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 8 Jun 2017 02:16:29 -0400
Received: by mail-io0-f172.google.com with SMTP id b184so16107949ioe.0
        for <linux-sparse@vger.kernel.org>; Wed, 07 Jun 2017 23:16:28 -0700 (PDT)
In-Reply-To: <20170608024736.49780-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Jun 7, 2017 at 7:47 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The goal of this mini-series is to warn about implicit.
> It's part of a larger series whose goal is to straighten
> situations where the return type of a function doesn't
> match the type of what is returned, often silently and
> with incoherence in the code generated.

Looks good to me.

BTW, are those intend to merge into sparse-next or for
review only?

If it is for sparse-next. I kind of wish to have one dedicate
branch to pull from you. You can still have different branch
for review. It is just went I pull, I don't have to merge between
your branches.

Chris
