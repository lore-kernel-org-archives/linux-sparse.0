From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm outstanding fixes
Date: Mon, 13 Mar 2017 19:04:29 +0000
Message-ID: <CACXZuxfDudaFj7Qybtrfw0JRWr9n5ofMA7XHB5Sh+EWfU4EEDw@mail.gmail.com>
References: <CACXZuxeKgVsaz_7TKseghcxzxZNdvK0gU-MhLxtmzYye8Uwz_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:36644 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754671AbdCMTEc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Mar 2017 15:04:32 -0400
Received: by mail-io0-f176.google.com with SMTP id l7so90333359ioe.3
        for <linux-sparse@vger.kernel.org>; Mon, 13 Mar 2017 12:04:31 -0700 (PDT)
In-Reply-To: <CACXZuxeKgVsaz_7TKseghcxzxZNdvK0gU-MhLxtmzYye8Uwz_g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

On 13 March 2017 at 12:08, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> Hi,
>
> This is just a summary of the fixes that are not yet in any patch series:
>
> + Incorrect generation of GEP offsets due to offset being unsigned.
> + op_fpcast implementation
> + op_setval implementation
> + Fix for variadic function call based upon type information in pseudo values
> + Fix for local variables and simple assignments, including support
> for floating type values.
>

Also function ptr call syntax of the type (*f)() results in wrong
linearized output. There is no fix for this yet.

Regards
