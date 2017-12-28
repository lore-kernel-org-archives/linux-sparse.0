From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH] fix implicit size of unsized arrays
Date: Thu, 28 Dec 2017 21:02:27 +0000
Message-ID: <CACXZuxebnX36BjVyJjSecw7Uef0PaRcgYfLCgkqYz5tLrKHLpA@mail.gmail.com>
References: <20171228150747.77209-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:39746 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbdL1VC2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 Dec 2017 16:02:28 -0500
Received: by mail-ua0-f181.google.com with SMTP id e19so5849456uam.6
        for <linux-sparse@vger.kernel.org>; Thu, 28 Dec 2017 13:02:27 -0800 (PST)
In-Reply-To: <20171228150747.77209-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 28 December 2017 at 15:07, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> When an array is declared without an explicit size. In this case,
> an implicit size is given by the number of elements in its initializer
> if one is present.
>
> Currently, in sparse, this implicit size is only associated with
> the node corresponding to the initializer while the base type is
> left unsized. This is a problem because the node is only used for
> the modifiers & address-space and the bitsize of nodes are expected
> to match the size of the basetype. So this implicit size can be used
> for when directly using the bit_size of the node but the array is
> still left, essentially unsized.
>

Previous thread on this issue:

https://www.spinics.net/lists/linux-sparse/msg05427.html

Regards
Dibyendu
