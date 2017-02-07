From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2 0/5] more simplification of constant multiplicative ops
Date: Wed, 8 Feb 2017 03:18:58 +0800
Message-ID: <CANeU7QmEm-JFBzOXxkrkOXXSEVPsNmjr7dQkkvBNBxB0huYTZw@mail.gmail.com>
References: <CANeU7QkOmqZH-X4C3Ma6b94jyx1LnjM=UEH2CjEt0SwgZ4Y2Kw@mail.gmail.com>
 <20170207190028.24343-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:36134 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932119AbdBGTS7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 14:18:59 -0500
Received: by mail-io0-f171.google.com with SMTP id j13so98026046iod.3
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 11:18:59 -0800 (PST)
In-Reply-To: <20170207190028.24343-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Feb 8, 2017 at 3:00 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This serie add a few more simplification of multiplicative operators
> (multiplication, division & modulo) with constants 1 or -1.
> Only simplifications that doesn't depend on undefined behavior are done.
>
> Changes since v1:

Just double checking. I suppose to take out the old version
of the patch already applied in spase-next then apply this
series, right?

Chris
