From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] teach cgcc about OSX aka darwin
Date: Mon, 5 Jun 2017 11:13:00 -0700
Message-ID: <CANeU7QkVXSuGAJCwjdHQCtXinTvUEdNy3Cus4CkBoRq-UW-79A@mail.gmail.com>
References: <20170529003757.3848-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:35384 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751162AbdFESNB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 5 Jun 2017 14:13:01 -0400
Received: by mail-it0-f53.google.com with SMTP id m62so70038091itc.0
        for <linux-sparse@vger.kernel.org>; Mon, 05 Jun 2017 11:13:01 -0700 (PDT)
In-Reply-To: <20170529003757.3848-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, May 28, 2017 at 5:37 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> cgcc knows about a few unix OSes but not yet about OSX/darwin.
>
> Fix this by adding the two needed defines to cgcc's specs.

Looks fine to me.

Chris
