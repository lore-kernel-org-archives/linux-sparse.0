From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] fix cast to pointer to floating-point
Date: Wed, 26 Apr 2017 04:47:47 +0800
Message-ID: <CANeU7Qkmp63yLomHfn0A9vAG6cgDJjfWTeQqKy=mnUrfRB2xPg@mail.gmail.com>
References: <20170311141659.36768-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:34103 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1950310AbdDYUrs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 25 Apr 2017 16:47:48 -0400
Received: by mail-io0-f174.google.com with SMTP id a103so222959823ioj.1
        for <linux-sparse@vger.kernel.org>; Tue, 25 Apr 2017 13:47:48 -0700 (PDT)
In-Reply-To: <20170311141659.36768-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Mar 11, 2017 at 10:16 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> By mistake, a cast to floating-pointer pointer was
> created as OP_FPCAST instead of OP_PTRCAST.
>
> Fix this by adding the missing 'else'.

That looks good. Good catch.

Chris
