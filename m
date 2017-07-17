From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Makefile: suppress pkg-config output from make
Date: Mon, 17 Jul 2017 13:07:22 -0400
Message-ID: <CANeU7Qk3H_81aPps8qW79mVMGFuT5QdzTDACAv5RUnFbAU4C2A@mail.gmail.com>
References: <8a9ee6b0-93e6-86fa-c572-8c74cc4be597@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35713 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751383AbdGQRHX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 17 Jul 2017 13:07:23 -0400
Received: by mail-pf0-f172.google.com with SMTP id e199so18266084pfh.2
        for <linux-sparse@vger.kernel.org>; Mon, 17 Jul 2017 10:07:23 -0700 (PDT)
In-Reply-To: <8a9ee6b0-93e6-86fa-c572-8c74cc4be597@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, Jul 17, 2017 at 10:41 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>   $ make
>   ...
>   Package libxml-2.0 was not found in the pkg-config search path.
>   Perhaps you should add the directory containing `libxml-2.0.pc'
>   to the PKG_CONFIG_PATH environment variable
>   No package 'libxml-2.0' found
>   ...
>   $
>
> In order to suppress the message, move the LIBXML_CFLAGS make variable
> setting into the $(HAVE_LIBXML) conditional.

Good catch. I kind of install every package to make sparse happy.  My setup
did not catch this missing package error. Totally make sense.

Thanks you for the patch. I will look into this.

Chris
