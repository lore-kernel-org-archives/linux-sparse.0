From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse: document that -Wbitwise is default
Date: Wed, 18 Oct 2017 12:29:43 -0700
Message-ID: <CANeU7Qmd3BxncccFvVOx4_gSAuhjejRj3PQhB18mQu=uS6=ZSA@mail.gmail.com>
References: <20171017233136.24533-1-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:48521 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbdJRT3o (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Oct 2017 15:29:44 -0400
Received: by mail-yw0-f193.google.com with SMTP id q1so1524391ywh.5
        for <linux-sparse@vger.kernel.org>; Wed, 18 Oct 2017 12:29:44 -0700 (PDT)
In-Reply-To: <20171017233136.24533-1-jacob.e.keller@intel.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Oct 17, 2017 at 4:31 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> In commit commit 02a886bfa3d9 ("Introduce keyword driven
> attribute parsing", 2007-03-08) the -Wbitwise keyword was broken and did
> not actually work. Instead, bitwise checks were always enabled.
>
> This was fixed by commit commit 0dfda0d1f0fe ("make -Wbitwise
> operational again", 2017-02-18) which allowed -Wbitwise and -Wno-bitwise
> to work as expected.
>
> However, since -Wbitwise was enabled for so long, that commit changed
> the default of -Wbitwise to be enabled, rather than the documented
> "disabled".
>
> Fix the documentation to match, and explain that -Wbitwise is enabled by
> default and must be disabled.

Thanks. Will apply.

Chris
